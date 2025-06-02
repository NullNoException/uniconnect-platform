using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Documents.DTOs;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Documents.Commands.UploadDocument;

public class UploadDocumentCommandHandler : IRequestHandler<UploadDocumentCommand, DocumentDto>
{
    private readonly IDocumentRepository _documentRepository;
    private readonly IStorageService _storageService;
    private readonly IMalwareScannerService _malwareScannerService;
    private readonly ILogger<UploadDocumentCommandHandler> _logger;
    private const string DocumentBucketName = "uniconnect-documents"; // Configuration candidate

    public UploadDocumentCommandHandler(
        IDocumentRepository documentRepository,
        IStorageService storageService,
        IMalwareScannerService malwareScannerService,
        ILogger<UploadDocumentCommandHandler> logger)
    {
        _documentRepository = documentRepository;
        _storageService = storageService;
        _malwareScannerService = malwareScannerService;
        _logger = logger;
    }

    public async Task<DocumentDto> Handle(UploadDocumentCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Starting document upload process for user {UserId}, filename {FileName}", request.UserId, request.File.FileName);

        // 1. Validate (already done by FluentValidation middleware)

        // 2. Scan for malware
        var malwareScanResult = await _malwareScannerService.ScanFileAsync(request.File, cancellationToken);
        if (malwareScanResult.IsInfected)
        {
            _logger.LogWarning("Malware detected in file {FileName} for user {UserId}. Details: {ScanDetails}", request.File.FileName, request.UserId, malwareScanResult.Details);
            // Optionally, create a document record with status Infected and don't upload to storage
            // Or throw a specific exception to be handled by the controller
            throw new InvalidOperationException($"Malware detected in file: {malwareScanResult.Details}");
        }
        _logger.LogInformation("Malware scan completed for {FileName}. Status: Clean", request.File.FileName);

        // 3. Ensure bucket exists (IStorageService responsibility or here)
        if (!await _storageService.BucketExistsAsync(DocumentBucketName, cancellationToken))
        {
            await _storageService.CreateBucketAsync(DocumentBucketName, cancellationToken);
            _logger.LogInformation("Bucket {BucketName} created.", DocumentBucketName);
        }

        // 4. Upload to storage
        var fileExtension = Path.GetExtension(request.File.FileName);
        var storedFileName = $"{Guid.NewGuid()}{fileExtension}"; // Unique name for storage
        var storagePath = await _storageService.UploadAsync(request.File, DocumentBucketName, storedFileName, cancellationToken);
        _logger.LogInformation("File {FileName} uploaded to {Path}", request.File.FileName, storagePath);

        // 5. Create document record in database
        var document = new UniConnect.Domain.Entities.Document
        {
            OriginalFileName = request.File.FileName,
            FileName = storedFileName,
            ContentType = request.File.ContentType,
            FileSize = request.File.Length,
            StoragePath = storagePath, // Or just storedFileName if bucket is implicit
            DocumentType = request.DocumentType, // Use the enum from the request
            UploadedByUserId = request.UserId,
            MalwareScanStatus = MalwareScanStatus.Clean, // Assuming success if not thrown
            // CreatedAt is handled by AuditableEntity base class
        };

        await _documentRepository.AddAsync(document, cancellationToken);
        _logger.LogInformation("Document record created with ID {DocumentId}", document.Id);

        return new DocumentDto
        {
            Id = document.Id,
            OriginalFileName = document.OriginalFileName,
            ContentType = document.ContentType,
            FileSize = document.FileSize,
            DocumentType = document.DocumentType, // Already the enum
            CreatedAt = document.CreatedAt,
            MalwareScanStatus = document.MalwareScanStatus
        };
    }
}
