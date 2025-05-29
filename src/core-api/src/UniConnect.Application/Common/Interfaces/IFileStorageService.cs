namespace UniConnect.Application.Common.Interfaces;

/// <summary>
/// File upload request model
/// </summary>
public class FileUploadRequest
{
    public Stream FileStream { get; init; } = null!;
    public string FileName { get; init; } = string.Empty;
    public string ContentType { get; init; } = string.Empty;
    public long Size { get; init; }
}

public interface IFileStorageService
{
    /// <summary>
    /// Upload a file and return the URL
    /// </summary>
    /// <param name="fileRequest">File upload request</param>
    /// <param name="folder">Target folder (e.g., "universities/logos")</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>File URL</returns>
    Task<string> UploadFileAsync(FileUploadRequest fileRequest, string folder, CancellationToken cancellationToken = default);

    /// <summary>
    /// Delete a file by URL
    /// </summary>
    /// <param name="fileUrl">File URL to delete</param>
    /// <param name="cancellationToken">Cancellation token</param>
    Task DeleteFileAsync(string fileUrl, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get the public URL for a file
    /// </summary>
    /// <param name="filePath">Internal file path</param>
    /// <returns>Public URL</returns>
    string GetPublicUrl(string filePath);

    /// <summary>
    /// Validate file type and size
    /// </summary>
    /// <param name="fileName">File name</param>
    /// <param name="contentType">Content type</param>
    /// <param name="size">File size in bytes</param>
    /// <param name="allowedExtensions">Allowed file extensions</param>
    /// <param name="maxSizeInBytes">Maximum file size in bytes</param>
    /// <returns>Validation result</returns>
    bool ValidateFile(string fileName, string contentType, long size, string[] allowedExtensions, long maxSizeInBytes);
}
