using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Common.Interfaces;

namespace UniConnect.API.Areas.Admin.Controllers;

[Area("Admin")]
[Route("api/admin/files")]
[Authorize(Roles = "Admin")]
public class FilesController : ApiControllerBase
{
    private readonly IFileStorageService _fileStorageService;
    private readonly ILogger<FilesController> _logger;

    // Allowed image extensions for university logos
    private static readonly string[] AllowedImageExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
    private const long MaxFileSizeBytes = 5 * 1024 * 1024; // 5MB

    public FilesController(IFileStorageService fileStorageService, ILogger<FilesController> logger)
    {
        _fileStorageService = fileStorageService;
        _logger = logger;
    }

    /// <summary>
    /// Upload university logo
    /// </summary>
    /// <param name="file">Logo file</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>File URL</returns>
    [HttpPost("universities/logos")]
    [ProducesResponseType(typeof(FileUploadResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<FileUploadResponse>> UploadUniversityLogo(
        IFormFile file,
        CancellationToken cancellationToken)
    {
        if (!_fileStorageService.ValidateFile(
                file.FileName,
                file.ContentType,
                file.Length,
                AllowedImageExtensions,
                MaxFileSizeBytes))
        {
            return BadRequest(new { error = "Invalid file. Please upload a valid image file (JPG, PNG, GIF, WebP) under 5MB." });
        }

        try
        {
            using var stream = file.OpenReadStream();
            var fileRequest = new FileUploadRequest
            {
                FileStream = stream,
                FileName = file.FileName,
                ContentType = file.ContentType,
                Size = file.Length
            };

            var fileUrl = await _fileStorageService.UploadFileAsync(fileRequest, "universities/logos", cancellationToken);

            _logger.LogInformation("University logo uploaded successfully: {FileName} -> {FileUrl}",
                file.FileName, fileUrl);

            return Ok(new FileUploadResponse
            {
                FileUrl = fileUrl,
                FileName = file.FileName,
                FileSize = file.Length,
                ContentType = file.ContentType
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error uploading university logo: {FileName}", file.FileName);
            return StatusCode(500, new { error = "An error occurred while uploading the file." });
        }
    }

    /// <summary>
    /// Delete uploaded file
    /// </summary>
    /// <param name="request">Delete file request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Success response</returns>
    [HttpDelete]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<IActionResult> DeleteFile(
        [FromBody] DeleteFileRequest request,
        CancellationToken cancellationToken)
    {
        if (string.IsNullOrEmpty(request.FileUrl))
        {
            return BadRequest(new { error = "File URL is required." });
        }

        try
        {
            await _fileStorageService.DeleteFileAsync(request.FileUrl, cancellationToken);

            _logger.LogInformation("File deleted successfully: {FileUrl}", request.FileUrl);

            return NoContent();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting file: {FileUrl}", request.FileUrl);
            return StatusCode(500, new { error = "An error occurred while deleting the file." });
        }
    }
}

public record FileUploadResponse
{
    public string FileUrl { get; init; } = string.Empty;
    public string FileName { get; init; } = string.Empty;
    public long FileSize { get; init; }
    public string? ContentType { get; init; }
}

public record DeleteFileRequest(string FileUrl);
