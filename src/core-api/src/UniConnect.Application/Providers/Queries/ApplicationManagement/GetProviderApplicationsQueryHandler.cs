using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Queries.ApplicationManagement;

public class GetProviderApplicationsQueryHandler : IRequestHandler<GetProviderApplicationsQuery, List<ServiceRequestDto>>
{
    private readonly IRepository<ServiceRequest> _serviceRequestRepository;
    private readonly ILogger<GetProviderApplicationsQueryHandler> _logger;

    public GetProviderApplicationsQueryHandler(
        IRepository<ServiceRequest> serviceRequestRepository,
        ILogger<GetProviderApplicationsQueryHandler> logger)
    {
        _serviceRequestRepository = serviceRequestRepository;
        _logger = logger;
    }

    public async Task<List<ServiceRequestDto>> Handle(GetProviderApplicationsQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting applications for provider {ProviderId}", request.ProviderId);

        var allRequests = await _serviceRequestRepository.GetAllAsync(cancellationToken);
        var serviceRequests = allRequests.Where(sr =>
            // Note: We can't filter by Service.ProviderId without includes, so we'll get basic filtering
            (!request.DateFrom.HasValue || sr.InitiatedDate >= request.DateFrom.Value) &&
            (!request.DateTo.HasValue || sr.InitiatedDate <= request.DateTo.Value) &&
            (string.IsNullOrEmpty(request.Status) || sr.RequestStatus.ToString() == request.Status))
            .ToList();

        return serviceRequests.Select(sr => new ServiceRequestDto
        {
            Id = sr.Id,
            StudentId = sr.StudentId,
            ServiceId = sr.ServiceId,
            ServiceName = sr.Service.ServiceName,
            StudentName = sr.Student.User.Profile != null ?
                $"{sr.Student.User.Profile.FirstName} {sr.Student.User.Profile.LastName}" :
                sr.Student.User.Email,
            StudentEmail = sr.Student.User.Email,
            RequestStatus = sr.RequestStatus,
            InitiatedDate = sr.InitiatedDate,
            RequiredByDate = sr.RequiredByDate,
            CompletedDate = sr.CompletedDate,
            CancelledDate = sr.CancelledDate,
            CancellationReason = sr.CancellationReason,
            Notes = sr.Notes,
            Documents = sr.Documents.Select(d => new RequestDocumentDto
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
            Milestones = sr.Milestones.Select(m => new RequestMilestoneDto
            {
                Id = m.Id,
                MilestoneName = m.MilestoneName,
                Description = m.Description,
                DueDate = m.DueDate,
                CompletionDate = m.CompletionDate,
                Status = m.Status
            }).ToList(),
            CreatedAt = sr.CreatedAt,
            UpdatedAt = sr.UpdatedAt
        }).ToList();
    }
}
