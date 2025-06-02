using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Admin.Commands.ProviderManagement;

public class VerifyProviderCommandHandler : IRequestHandler<VerifyProviderCommand, ProviderDto>
{
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<VerifyProviderCommandHandler> _logger;

    public VerifyProviderCommandHandler(
        IRepository<ServiceProvider> providerRepository,
        IUnitOfWork unitOfWork,
        ILogger<VerifyProviderCommandHandler> logger)
    {
        _providerRepository = providerRepository;
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<ProviderDto> Handle(VerifyProviderCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Admin {AdminId} verifying provider {ProviderId} with status {Status}",
            request.AdminId, request.ProviderId, request.Status);

        var provider = await _providerRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        // Update verification status
        provider.VerificationStatus = request.Status;
        provider.VerificationDate = DateTime.UtcNow;
        provider.VerifiedById = request.AdminId;
        provider.VerificationNotes = request.VerificationNotes;

        if (request.Status == ProviderVerificationStatus.Rejected)
        {
            provider.RejectionReason = request.RejectionReason;
        }

        await _providerRepository.UpdateAsync(provider);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Provider {ProviderId} verification status updated to {Status} by admin {AdminId}",
            request.ProviderId, request.Status, request.AdminId);

        return new ProviderDto
        {
            Id = provider.Id,
            CompanyName = provider.CompanyName,
            ContactEmail = provider.ContactEmail ?? string.Empty,
            ContactPhone = provider.ContactPhone ?? string.Empty,
            CompanyAddress = provider.CompanyAddress,
            CompanyDescription = provider.CompanyDescription,
            Website = provider.Website,
            TaxIdentificationNumber = provider.TaxIdentificationNumber,
            BusinessRegistrationNumber = provider.BusinessRegistrationNumber,
            VerificationStatus = provider.VerificationStatus,
            VerificationDate = provider.VerificationDate,
            VerifiedById = provider.VerifiedById,
            VerificationNotes = provider.VerificationNotes,
            RejectionReason = provider.RejectionReason,
            CreatedAt = provider.CreatedAt,
            UpdatedAt = provider.UpdatedAt
        };
    }
}
