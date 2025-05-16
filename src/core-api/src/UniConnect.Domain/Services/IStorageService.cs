namespace UniConnect.Domain.Services;

public interface IStorageService
{
    Task<string> UploadFileAsync(Stream fileStream, string fileName, string contentType, string container, CancellationToken cancellationToken = default);
    Task<bool> DeleteFileAsync(string fileUrl, CancellationToken cancellationToken = default);
    Task<Stream?> GetFileAsync(string fileUrl, CancellationToken cancellationToken = default);
    Task<string> GetSignedUrlAsync(string fileUrl, TimeSpan expiresIn, CancellationToken cancellationToken = default);
}
