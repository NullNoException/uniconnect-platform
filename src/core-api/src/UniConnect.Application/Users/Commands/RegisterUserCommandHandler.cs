using AutoMapper;
using MediatR;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Models;
using UniConnect.Application.Users.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;
using UniConnect.Domain.Services;

namespace UniConnect.Application.Users.Commands;

public class RegisterUserCommandHandler : IRequestHandler<RegisterUserCommand, Result<UserDto>>
{
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<UserProfile> _profileRepository;
    private readonly IRepository<Student> _studentRepository;
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly IIdentityService _identityService;
    private readonly IUnitOfWork _unitOfWork;
    private readonly IMapper _mapper;
    private readonly IDateTime _dateTime;
    private readonly ICurrentUserService _currentUserService;
    private readonly Domain.Services.IEmailService _emailService;

    public RegisterUserCommandHandler(
        IRepository<User> userRepository,
        IRepository<UserProfile> profileRepository,
        IRepository<Student> studentRepository,
        IRepository<ServiceProvider> providerRepository,
        IIdentityService identityService,
        IUnitOfWork unitOfWork,
        IMapper mapper,
        IDateTime dateTime,
        ICurrentUserService currentUserService,
        UniConnect.Domain.Services.IEmailService emailService)
    {
        _userRepository = userRepository;
        _profileRepository = profileRepository;
        _studentRepository = studentRepository;
        _providerRepository = providerRepository;
        _identityService = identityService;
        _unitOfWork = unitOfWork;
        _mapper = mapper;
        _dateTime = dateTime;
        _currentUserService = currentUserService;
        _emailService = emailService;
    }

    public async Task<Result<UserDto>> Handle(RegisterUserCommand request, CancellationToken cancellationToken)
    {
        // Check if email already exists
        var emailExists = await _identityService.CheckEmailExistsAsync(request.Email);
        if (emailExists)
        {
            return Result<UserDto>.Failure("Email already exists.");
        }

        // Create identity user
        var (success, userId, errorMessage) = await _identityService.CreateUserAsync(
            request.Email,
            request.Password,
            request.UserType.ToString());

        if (!success || string.IsNullOrEmpty(userId))
        {
            return Result<UserDto>.Failure(errorMessage ?? "Failed to create user.");
        }

        try
        {
            await _unitOfWork.BeginTransactionAsync(cancellationToken);

            // Create domain user
            var user = new User
            {
                Id = Guid.Parse(userId),
                Email = request.Email,
                UserType = request.UserType,
                Status = Domain.Enums.UserStatus.Pending,
                CreatedAt = _dateTime.UtcNow,
                CreatedBy = _currentUserService.UserId ?? userId
            };

            await _userRepository.AddAsync(user, cancellationToken);

            // Create user profile
            var profile = new UserProfile
            {
                UserId = user.Id,
                FirstName = request.FirstName,
                LastName = request.LastName,
                PhoneNumber = request.PhoneNumber,
                PreferredLanguage = request.PreferredLanguage ?? "en",
                CreatedAt = _dateTime.UtcNow,
                CreatedBy = _currentUserService.UserId ?? userId
            };

            await _profileRepository.AddAsync(profile, cancellationToken);

            // Create type-specific record
            switch (request.UserType)
            {
                case Domain.Enums.UserType.Student:
                    var student = new Student
                    {
                        UserId = user.Id,
                        CreatedAt = _dateTime.UtcNow,
                        CreatedBy = _currentUserService.UserId ?? userId
                    };
                    await _studentRepository.AddAsync(student, cancellationToken);
                    break;

                case Domain.Enums.UserType.ServiceProvider:
                    var provider = new ServiceProvider
                    {
                        UserId = user.Id,
                        CompanyName = $"{request.FirstName} {request.LastName}'s Company", // Default value
                        VerificationStatus = Domain.Enums.ProviderVerificationStatus.Pending,
                        CreatedAt = _dateTime.UtcNow,
                        CreatedBy = _currentUserService.UserId ?? userId
                    };
                    await _providerRepository.AddAsync(provider, cancellationToken);
                    break;
            }

            await _unitOfWork.SaveChangesAsync(cancellationToken);
            await _unitOfWork.CommitTransactionAsync(cancellationToken);

            // Send welcome email
            await _emailService.SendTemplatedEmailAsync(
                request.Email,
                "WelcomeEmail",
                new { FirstName = request.FirstName },
                cancellationToken);

            // Return the newly created user
            var result = _mapper.Map<UserDto>(user);
            result.Profile = _mapper.Map<UserProfileDto>(profile);

            return Result<UserDto>.Success(result);
        }
        catch (Exception)
        {
            await _unitOfWork.RollbackTransactionAsync(cancellationToken);
            throw;
        }
    }
}
