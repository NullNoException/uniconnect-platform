using MediatR;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.VerifyProvider;

public class VerifyProviderCommandHandler : IRequestHandler<VerifyProviderCommand, ProviderDto>
{
    private readonly IRepository<ServiceProvider> _serviceProviderRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IUnitOfWork _unitOfWork;

    public VerifyProviderCommandHandler(
        IRepository<ServiceProvider> serviceProviderRepository,
        IRepository<User> userRepository,
        IUnitOfWork unitOfWork)
    {
        _serviceProviderRepository = serviceProviderRepository;
        _userRepository = userRepository;
        _unitOfWork = unitOfWork;
    }

    public async Task<ProviderDto> Handle(VerifyProviderCommand request, CancellationToken cancellationToken)
    {
        var provider = await _serviceProviderRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
            throw new InvalidOperationException("Provider not found.");

        provider.VerificationStatus = request.IsApproved ? ProviderVerificationStatus.Verified : ProviderVerificationStatus.Rejected;
        provider.VerifiedById = request.VerifiedByAdminId;
        provider.VerificationDate = DateTime.UtcNow;
        // Optionally store comments in a new field or audit log

        await _serviceProviderRepository.UpdateAsync(provider, cancellationToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        var user = await _userRepository.GetByIdAsync(provider.UserId, cancellationToken);

        return new ProviderDto
        {
            Id = provider.Id,
            Email = user?.Email ?? string.Empty,
            OrganizationName = provider.CompanyName,
            ContactName = string.Empty, // Not available in ServiceProvider
            ContactPhone = string.Empty, // Not available in ServiceProvider
            Website = provider.CompanyWebsite,
            Status = provider.VerificationStatus.ToString()
        };
    }
}
