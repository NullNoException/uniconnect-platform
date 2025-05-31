using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.ApplicationManagement;

public class ProcessApplicationCommandHandler : IRequestHandler<ProcessApplicationCommand, ServiceRequestDto>
{
    private readonly IRepository<ServiceRequest> _serviceRequestRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<ProcessApplicationCommandHandler> _logger;

    public ProcessApplicationCommandHandler(
        IRepository<ServiceRequest> serviceRequestRepository,
        IUnitOfWork unitOfWork,
        ILogger<ProcessApplicationCommandHandler> logger)
    {
        _serviceRequestRepository = serviceRequestRepository;
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<ServiceRequestDto> Handle(ProcessApplicationCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Processing application {ApplicationId} for provider {ProviderId}",
            request.ApplicationId, request.ProviderId);

        // Get the service request
        var allRequests = await _serviceRequestRepository.GetAllAsync(cancellationToken);
        var serviceRequest = allRequests.FirstOrDefault(sr => sr.Id == request.ApplicationId);

        if (serviceRequest == null)
        {
            throw new InvalidOperationException($"Application with ID {request.ApplicationId} not found or does not belong to provider {request.ProviderId}");
        }

        // Validate status transition
        ValidateStatusTransition(serviceRequest.RequestStatus, request.NewStatus);

        // Update the application
        serviceRequest.RequestStatus = request.NewStatus;
        serviceRequest.Notes = request.Notes ?? serviceRequest.Notes;

        if (request.NewStatus == ServiceRequestStatus.Completed && request.CompletionDate.HasValue)
        {
            serviceRequest.CompletedDate = request.CompletionDate.Value;
        }

        if (request.NewStatus == ServiceRequestStatus.Cancelled)
        {
            serviceRequest.CancelledDate = DateTime.UtcNow;
            serviceRequest.CancellationReason = request.CancellationReason;
        }

        await _serviceRequestRepository.UpdateAsync(serviceRequest);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Application {ApplicationId} status updated to {NewStatus}",
            request.ApplicationId, request.NewStatus);

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

    private static void ValidateStatusTransition(ServiceRequestStatus currentStatus, ServiceRequestStatus newStatus)
    {
        // Define valid transitions
        var validTransitions = new Dictionary<ServiceRequestStatus, ServiceRequestStatus[]>
        {
            { ServiceRequestStatus.Draft, new[] { ServiceRequestStatus.Submitted, ServiceRequestStatus.Cancelled } },
            { ServiceRequestStatus.Submitted, new[] { ServiceRequestStatus.InReview, ServiceRequestStatus.Rejected, ServiceRequestStatus.Cancelled } },
            { ServiceRequestStatus.InReview, new[] { ServiceRequestStatus.InProgress, ServiceRequestStatus.AwaitingFeedback, ServiceRequestStatus.Rejected, ServiceRequestStatus.Cancelled } },
            { ServiceRequestStatus.InProgress, new[] { ServiceRequestStatus.AwaitingFeedback, ServiceRequestStatus.Completed, ServiceRequestStatus.Cancelled } },
            { ServiceRequestStatus.AwaitingFeedback, new[] { ServiceRequestStatus.InProgress, ServiceRequestStatus.Completed, ServiceRequestStatus.Cancelled } },
            { ServiceRequestStatus.Completed, Array.Empty<ServiceRequestStatus>() },
            { ServiceRequestStatus.Cancelled, Array.Empty<ServiceRequestStatus>() },
            { ServiceRequestStatus.Rejected, Array.Empty<ServiceRequestStatus>() }
        };

        if (!validTransitions.TryGetValue(currentStatus, out var allowedStatuses) ||
            !allowedStatuses.Contains(newStatus))
        {
            throw new InvalidOperationException($"Invalid status transition from {currentStatus} to {newStatus}");
        }
    }
}
