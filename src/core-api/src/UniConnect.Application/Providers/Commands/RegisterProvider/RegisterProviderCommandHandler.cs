using MediatR;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;
using UniConnect.Domain.Services;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Providers.Commands.RegisterProvider;

public class RegisterProviderCommandHandler : IRequestHandler<RegisterProviderCommand, ProviderDto>
{
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<ServiceProvider> _serviceProviderRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly IEmailService _emailService;

    public RegisterProviderCommandHandler(
        IRepository<User> userRepository,
        IRepository<ServiceProvider> serviceProviderRepository,
        IUnitOfWork unitOfWork,
        IEmailService emailService)
    {
        _userRepository = userRepository;
        _serviceProviderRepository = serviceProviderRepository;
        _unitOfWork = unitOfWork;
        _emailService = emailService;
    }

    public async Task<ProviderDto> Handle(RegisterProviderCommand request, CancellationToken cancellationToken)
    {
        // Check for existing user by email
        var existingUsers = await _userRepository.FindAsync(u => u.Email == request.Email, cancellationToken);
        if (existingUsers.Any())
            throw new InvalidOperationException("A user with this email already exists.");

        // Hash password (replace with a real hasher in production)
        var passwordHash = $"HASHED_{request.Password}";

        var user = new User
        {
            Email = request.Email,
            PasswordHash = passwordHash,
            UserType = UserType.ServiceProvider,
            Status = UserStatus.Pending,
            CreatedAt = DateTime.UtcNow
        };
        await _userRepository.AddAsync(user, cancellationToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        var serviceProvider = new ServiceProvider
        {
            UserId = user.Id,
            CompanyName = request.OrganizationName,
            CompanyWebsite = request.Website,
            VerificationStatus = ProviderVerificationStatus.Pending,
            // Optionally set more fields
        };
        await _serviceProviderRepository.AddAsync(serviceProvider, cancellationToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        // Send verification email
        await _emailService.SendVerificationEmailAsync(request.Email, user.Id.ToString());

        return new ProviderDto
        {
            Id = serviceProvider.Id,
            Email = user.Email,
            CompanyName = serviceProvider.CompanyName,
            ContactEmail = user.Email,
            ContactPhone = request.ContactPhone,
            Website = serviceProvider.CompanyWebsite,
            VerificationStatus = serviceProvider.VerificationStatus,
            CreatedAt = serviceProvider.CreatedAt,
            UpdatedAt = serviceProvider.UpdatedAt
        };
    }
}
