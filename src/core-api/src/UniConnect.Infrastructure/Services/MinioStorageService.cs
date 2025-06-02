using System.Text;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Minio;
using Minio.DataModel;
using Minio.DataModel.Args;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Services;

namespace UniConnect.Infrastructure.Services;

public class MinioStorageService : UniConnect.Application.Common.Interfaces.IStorageService, IFileStorageService
{
    private readonly MinioClient _minioClient;
    private readonly MinioSettings _minioSettings;
    private readonly ILogger<MinioStorageService> _logger;

    public MinioStorageService(IOptions<MinioSettings> minioSettings, ILogger<MinioStorageService> logger)
    {
        _minioSettings = minioSettings.Value;
        _logger = logger;

        _minioClient = (MinioClient)new MinioClient()
            .WithEndpoint(_minioSettings.Endpoint)
            .WithCredentials(_minioSettings.AccessKey, _minioSettings.SecretKey)
            .WithRegion(_minioSettings.Region)
            .WithSSL(_minioSettings.UseSSL)
            .Build();
    }

    public async Task<string> UploadFileAsync(Stream fileStream, string fileName, string contentType, string container, CancellationToken cancellationToken = default)
    {
        try
        {
            // Ensure bucket exists
            var bucketExistsArgs = new BucketExistsArgs().WithBucket(container);
            bool bucketExists = await _minioClient.BucketExistsAsync(bucketExistsArgs, cancellationToken);

            if (!bucketExists)
            {
                var makeBucketArgs = new MakeBucketArgs().WithBucket(container);
                await _minioClient.MakeBucketAsync(makeBucketArgs, cancellationToken);

                // Set bucket policy if needed
                if (_minioSettings.PublicBuckets.Contains(container))
                {
                    // Skip setting bucket policy for now - API has changed
                    _logger.LogInformation("Would set public read policy for bucket {Bucket}", container);
                }
            }

            // Generate a unique object name to avoid collisions
            string objectName = $"{Guid.NewGuid()}-{fileName}";

            var putObjectArgs = new PutObjectArgs()
                .WithBucket(container)
                .WithObject(objectName)
                .WithStreamData(fileStream)
                .WithObjectSize(fileStream.Length)
                .WithContentType(contentType);

            await _minioClient.PutObjectAsync(putObjectArgs, cancellationToken);

            string fileUrl = $"{container}/{objectName}";
            _logger.LogInformation("File uploaded successfully: {FileUrl}", fileUrl);

            return fileUrl;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error uploading file {FileName} to container {Container}", fileName, container);
            throw new InvalidOperationException($"Failed to upload file {fileName} to container {container}", ex);
        }
    }

    public async Task<bool> DeleteFileAsync(string fileUrl, CancellationToken cancellationToken = default)
    {
        try
        {
            var urlParts = fileUrl.Split('/');
            if (urlParts.Length < 2)
            {
                throw new ArgumentException("Invalid file URL format", nameof(fileUrl));
            }

            string bucket = urlParts[0];
            string objectName = string.Join("/", urlParts.Skip(1));

            var removeObjectArgs = new RemoveObjectArgs()
                .WithBucket(bucket)
                .WithObject(objectName);

            await _minioClient.RemoveObjectAsync(removeObjectArgs, cancellationToken);

            _logger.LogInformation("File deleted successfully: {FileUrl}", fileUrl);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting file {FileUrl}", fileUrl);
            return false;
        }
    }

    public async Task<Stream?> GetFileAsync(string fileUrl, CancellationToken cancellationToken = default)
    {
        try
        {
            var urlParts = fileUrl.Split('/');
            if (urlParts.Length < 2)
            {
                throw new ArgumentException("Invalid file URL format", nameof(fileUrl));
            }

            string bucket = urlParts[0];
            string objectName = string.Join("/", urlParts.Skip(1));

            var memoryStream = new MemoryStream();

            var getObjectArgs = new GetObjectArgs()
                .WithBucket(bucket)
                .WithObject(objectName)
                .WithCallbackStream(stream =>
                {
                    stream.CopyTo(memoryStream);
                    memoryStream.Position = 0;
                });

            await _minioClient.GetObjectAsync(getObjectArgs, cancellationToken);

            _logger.LogInformation("File retrieved successfully: {FileUrl}", fileUrl);
            return memoryStream;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving file {FileUrl}", fileUrl);
            return null;
        }
    }

    public async Task<string> GetSignedUrlAsync(string fileUrl, TimeSpan expiresIn, CancellationToken cancellationToken = default)
    {
        try
        {
            var urlParts = fileUrl.Split('/');
            if (urlParts.Length < 2)
            {
                throw new ArgumentException("Invalid file URL format", nameof(fileUrl));
            }

            string bucket = urlParts[0];
            string objectName = string.Join("/", urlParts.Skip(1));

            var presignedGetObjectArgs = new PresignedGetObjectArgs()
                .WithBucket(bucket)
                .WithObject(objectName)
                .WithExpiry((int)expiresIn.TotalSeconds);

            string presignedUrl = await _minioClient.PresignedGetObjectAsync(presignedGetObjectArgs);

            _logger.LogInformation("Presigned URL generated for {FileUrl}", fileUrl);
            return presignedUrl;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating presigned URL for {FileUrl}", fileUrl);
            throw new InvalidOperationException($"Failed to generate presigned URL for file {fileUrl}", ex);
        }
    }

    private static string GetPublicReadPolicy(string bucketName)
    {
        return $@"{{
            ""Version"": ""2012-10-17"",
            ""Statement"": [
                {{
                    ""Effect"": ""Allow"",
                    ""Principal"": {{
                        ""AWS"": [
                            ""*""
                        ]
                    }},
                    ""Action"": [
                        ""s3:GetObject""
                    ],
                    ""Resource"": [
                        ""arn:aws:s3:::{bucketName}/*""
                    ]
                }}
            ]
        }}";
    }

    #region IFileStorageService Implementation

    public async Task<string> UploadFileAsync(FileUploadRequest fileRequest, string folder, CancellationToken cancellationToken = default)
    {
        try
        {
            // Use folder as container/bucket name, but sanitize it
            var container = SanitizeContainerName(folder);

            var fileUrl = await UploadFileAsync(
                fileRequest.FileStream,
                fileRequest.FileName,
                fileRequest.ContentType,
                container,
                cancellationToken);

            _logger.LogInformation("File uploaded successfully to MinIO: {FileName} -> {FileUrl}",
                fileRequest.FileName, fileUrl);

            return fileUrl;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error uploading file to MinIO: {FileName}", fileRequest.FileName);
            throw;
        }
    }

    // New implementation for IFileStorageService
    async Task IFileStorageService.DeleteFileAsync(string fileUrl, CancellationToken cancellationToken)
    {
        try
        {
            bool success = await DeleteFileAsync(fileUrl, cancellationToken);

            if (!success)
            {
                _logger.LogWarning("Failed to delete file from MinIO: {FileUrl}", fileUrl);
                throw new InvalidOperationException($"Failed to delete file: {fileUrl}");
            }

            _logger.LogInformation("File deleted successfully from MinIO: {FileUrl}", fileUrl);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting file from MinIO: {FileUrl}", fileUrl);
            throw;
        }
    }

    public string GetPublicUrl(string filePath)
    {
        // For MinIO, filePath is already a URL in format "container/objectName"
        // We can either return it as-is or construct a full URL with the endpoint
        if (_minioSettings.PublicBuckets.Any(bucket => filePath.StartsWith(bucket + "/")))
        {
            // For public buckets, return direct MinIO URL
            var protocol = _minioSettings.UseSSL ? "https" : "http";
            return $"{protocol}://{_minioSettings.Endpoint}/{filePath}";
        }

        // For private buckets, return the path as-is (will require signed URL for access)
        return filePath;
    }

    public bool ValidateFile(string fileName, string contentType, long size, string[] allowedExtensions, long maxSizeInBytes)
    {
        if (string.IsNullOrEmpty(fileName) || size == 0)
        {
            _logger.LogWarning("File validation failed: Empty filename or zero size");
            return false;
        }

        // Check file size
        if (size > maxSizeInBytes)
        {
            _logger.LogWarning("File size exceeds limit: {FileSize} bytes (max: {MaxSize})", size, maxSizeInBytes);
            return false;
        }

        // Check file extension
        var fileExtension = Path.GetExtension(fileName)?.ToLowerInvariant();
        if (string.IsNullOrEmpty(fileExtension) || !allowedExtensions.Contains(fileExtension))
        {
            _logger.LogWarning("Invalid file extension: {Extension}. Allowed: {AllowedExtensions}",
                fileExtension, string.Join(", ", allowedExtensions));
            return false;
        }

        // Check content type (basic validation)
        if (string.IsNullOrEmpty(contentType))
        {
            _logger.LogWarning("Missing content type for file: {FileName}", fileName);
            return false;
        }

        return true;
    }

    /// <summary>
    /// Sanitize container name to comply with MinIO bucket naming rules
    /// </summary>
    private static string SanitizeContainerName(string folder)
    {
        // MinIO bucket names must be between 3 and 63 characters long
        // Must contain only lowercase letters, numbers, dots, and hyphens
        // Must start and end with a letter or number
        var sanitized = folder.ToLowerInvariant()
            .Replace('/', '-')
            .Replace('_', '-')
            .Replace(' ', '-');

        // Remove any invalid characters
        sanitized = new string(sanitized.Where(c =>
            char.IsLetterOrDigit(c) || c == '-' || c == '.').ToArray());

        // Ensure it starts and ends with alphanumeric
        sanitized = sanitized.Trim('-', '.');

        // Ensure minimum length
        if (sanitized.Length < 3)
        {
            sanitized = $"files-{sanitized}";
        }

        // Ensure maximum length
        if (sanitized.Length > 63)
        {
            sanitized = sanitized.Substring(0, 63).TrimEnd('-', '.');
        }

        return sanitized;
    }

    #endregion

    #region IStorageService Implementation

    public async Task<string> UploadAsync(IFormFile file, string bucketName, string? objectName = null, CancellationToken cancellationToken = default)
    {
        using var stream = file.OpenReadStream();
        var fileName = objectName ?? file.FileName;
        return await UploadFileAsync(stream, fileName, file.ContentType, bucketName, cancellationToken);
    }

    public async Task<Stream> DownloadAsync(string bucketName, string objectName, CancellationToken cancellationToken = default)
    {
        var fileUrl = $"{bucketName}/{objectName}";
        var stream = await GetFileAsync(fileUrl, cancellationToken);
        if (stream == null)
            throw new FileNotFoundException($"File not found: {fileUrl}");
        return stream;
    }

    public async Task DeleteAsync(string bucketName, string objectName, CancellationToken cancellationToken = default)
    {
        var fileUrl = $"{bucketName}/{objectName}";
        await DeleteFileAsync(fileUrl, cancellationToken);
    }

    public async Task<bool> BucketExistsAsync(string bucketName, CancellationToken cancellationToken = default)
    {
        var args = new Minio.DataModel.Args.BucketExistsArgs().WithBucket(bucketName);
        return await _minioClient.BucketExistsAsync(args, cancellationToken);
    }

    public async Task CreateBucketAsync(string bucketName, CancellationToken cancellationToken = default)
    {
        var args = new Minio.DataModel.Args.MakeBucketArgs().WithBucket(bucketName);
        await _minioClient.MakeBucketAsync(args, cancellationToken);
    }

    #endregion
}

public class MinioSettings
{
    public string Endpoint { get; set; } = string.Empty;
    public string AccessKey { get; set; } = string.Empty;
    public string SecretKey { get; set; } = string.Empty;
    public string Region { get; set; } = string.Empty;
    public bool UseSSL { get; set; } = true;
    public List<string> PublicBuckets { get; set; } = new List<string>();
}
