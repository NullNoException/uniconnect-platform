using Microsoft.AspNetCore.Http;

namespace UniConnect.Application.Common.Interfaces;

public interface IStorageService
{
    Task<string> UploadAsync(IFormFile file, string bucketName, string? objectName = null, CancellationToken cancellationToken = default);
    Task<Stream> DownloadAsync(string bucketName, string objectName, CancellationToken cancellationToken = default);
    Task DeleteAsync(string bucketName, string objectName, CancellationToken cancellationToken = default);
    Task<bool> BucketExistsAsync(string bucketName, CancellationToken cancellationToken = default);
    Task CreateBucketAsync(string bucketName, CancellationToken cancellationToken = default);
}
