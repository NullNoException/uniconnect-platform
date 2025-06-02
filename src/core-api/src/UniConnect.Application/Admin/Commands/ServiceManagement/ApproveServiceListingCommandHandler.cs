using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Admin.Commands.ServiceManagement;

public class ApproveServiceListingCommandHandler : IRequestHandler<ApproveServiceListingCommand, ServiceDto>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<ApproveServiceListingCommandHandler> _logger;

    public ApproveServiceListingCommandHandler(
        IRepository<Service> serviceRepository,
        IUnitOfWork unitOfWork,
        ILogger<ApproveServiceListingCommandHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<ServiceDto> Handle(ApproveServiceListingCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Admin {AdminId} approving service {ServiceId} with status {Status}",
            request.AdminId, request.ServiceId, request.Status);

        var service = await _serviceRepository.GetByIdAsync(request.ServiceId, cancellationToken);
        if (service == null)
        {
            throw new InvalidOperationException($"Service with ID {request.ServiceId} not found");
        }

        // Update approval status
        service.ApprovalStatus = request.Status;
        service.ApprovalDate = DateTime.UtcNow;
        service.ApprovedById = request.AdminId;
        service.ApprovalNotes = request.ApprovalNotes;

        if (request.Status == ServiceApprovalStatus.Rejected)
        {
            service.RejectionReason = request.RejectionReason;
            service.IsActive = false; // Deactivate rejected services
        }
        else if (request.Status == ServiceApprovalStatus.Approved)
        {
            service.IsActive = true; // Activate approved services
        }

        await _serviceRepository.UpdateAsync(service);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Service {ServiceId} approval status updated to {Status} by admin {AdminId}",
            request.ServiceId, request.Status, request.AdminId);

        return new ServiceDto
        {
            Id = service.Id,
            ServiceName = service.ServiceName,
            Description = service.Description,
            ShortDescription = service.ShortDescription,
            ProviderId = service.ProviderId,
            CategoryId = service.CategoryId,
            BasePrice = service.BasePrice,
            CurrencyId = service.CurrencyId,
            EstimatedDeliveryDays = service.EstimatedDeliveryDays,
            ThumbnailUrl = service.ThumbnailUrl,
            IsActive = service.IsActive,
            ApprovalStatus = service.ApprovalStatus,
            ApprovalDate = service.ApprovalDate,
            ApprovedById = service.ApprovedById,
            ApprovalNotes = service.ApprovalNotes,
            RejectionReason = service.RejectionReason,
            CreatedAt = service.CreatedAt,
            UpdatedAt = service.UpdatedAt
        };
    }
}
