using System.Text;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Minio;
using Minio.DataModel;
using Minio.DataModel.Args;
using UniConnect.Domain.Services;

namespace UniConnect.Infrastructure.Services;

public class MinioStorageService : IStorageService
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
