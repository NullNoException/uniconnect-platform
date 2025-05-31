using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.ApplicationManagement;

public class RequestApplicationRevisionCommandHandler : IRequestHandler<RequestApplicationRevisionCommand, ServiceRequestDto>
{
    private readonly IRepository<ServiceRequest> _serviceRequestRepository;
    private readonly IRepository<RequestDocument> _documentRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<RequestApplicationRevisionCommandHandler> _logger;

    public RequestApplicationRevisionCommandHandler(
        IRepository<ServiceRequest> serviceRequestRepository,
        IRepository<RequestDocument> documentRepository,
        IUnitOfWork unitOfWork,
        ILogger<RequestApplicationRevisionCommandHandler> logger)
    {
        _serviceRequestRepository = serviceRequestRepository;
        _documentRepository = documentRepository;
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<ServiceRequestDto> Handle(RequestApplicationRevisionCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Requesting revision for application {ApplicationId} by provider {ProviderId}",
            request.ApplicationId, request.ProviderId);

        // Get the service request
        var allRequests = await _serviceRequestRepository.GetAllAsync(cancellationToken);
        var serviceRequest = allRequests.FirstOrDefault(sr => sr.Id == request.ApplicationId);

        if (serviceRequest == null)
        {
            throw new InvalidOperationException($"Application with ID {request.ApplicationId} not found or does not belong to provider {request.ProviderId}");
        }

        // Validate that revision can be requested (only for certain statuses)
        if (serviceRequest.RequestStatus != ServiceRequestStatus.InReview &&
            serviceRequest.RequestStatus != ServiceRequestStatus.InProgress)
        {
            throw new InvalidOperationException($"Cannot request revision for application in status {serviceRequest.RequestStatus}");
        }

        // Update application status to awaiting feedback
        serviceRequest.RequestStatus = ServiceRequestStatus.AwaitingFeedback;
        serviceRequest.Notes = string.IsNullOrEmpty(serviceRequest.Notes)
            ? request.RevisionReason
            : $"{serviceRequest.Notes}\n\n[Revision Requested]: {request.RevisionReason}";

        // Update specific documents with revision notes
        foreach (var docRevision in request.DocumentRevisions)
        {
            var document = serviceRequest.Documents.FirstOrDefault(d => d.Id == docRevision.DocumentId);
            if (document != null)
            {
                document.Status = "Revision Required";
                document.VerificationNotes = docRevision.RevisionNotes;
                document.VerificationDate = DateTime.UtcNow;
                await _documentRepository.UpdateAsync(document);
            }
        }

        await _serviceRequestRepository.UpdateAsync(serviceRequest);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Revision requested for application {ApplicationId}", request.ApplicationId);

        return new ServiceRequestDto
        {
            Id = serviceRequest.Id,
            StudentId = serviceRequest.StudentId,
            ServiceId = serviceRequest.ServiceId,
            ServiceName = serviceRequest.Service.ServiceName,
            StudentName = serviceRequest.Student.User.Profile != null ?
                $"{serviceRequest.Student.User.Profile.FirstName} {serviceRequest.Student.User.Profile.LastName}" :
                serviceRequest.Student.User.Email,
            StudentEmail = serviceRequest.Student.User.Email,
            RequestStatus = serviceRequest.RequestStatus,
            InitiatedDate = serviceRequest.InitiatedDate,
            RequiredByDate = serviceRequest.RequiredByDate,
            CompletedDate = serviceRequest.CompletedDate,
            CancelledDate = serviceRequest.CancelledDate,
            CancellationReason = serviceRequest.CancellationReason,
            Notes = serviceRequest.Notes,
            Documents = serviceRequest.Documents.Select(d => new RequestDocumentDto
            {
                Id = d.Id,
                DocumentTypeId = d.DocumentTypeId,
                DocumentTypeName = d.DocumentType.TypeName,
                DocumentName = d.DocumentName,
                FileUrl = d.FileUrl,
                FileSize = d.FileSize,
                UploadDate = d.UploadDate,
                Status = d.Status,
                VerifiedById = d.VerifiedById,
                VerificationDate = d.VerificationDate,
                VerificationNotes = d.VerificationNotes
            }).ToList(),
            Milestones = serviceRequest.Milestones.Select(m => new RequestMilestoneDto
            {
                Id = m.Id,
                MilestoneName = m.MilestoneName,
                Description = m.Description,
                DueDate = m.DueDate,
                CompletionDate = m.CompletionDate,
                Status = m.Status
            }).ToList(),
            CreatedAt = serviceRequest.CreatedAt,
            UpdatedAt = serviceRequest.UpdatedAt
        };
    }
}
