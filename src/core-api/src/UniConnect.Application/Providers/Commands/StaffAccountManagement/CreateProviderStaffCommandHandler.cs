using MediatR;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.StaffAccountManagement;

public class CreateProviderStaffCommandHandler : IRequestHandler<CreateProviderStaffCommand, ProviderStaffDto>
{
    private readonly IRepository<ProviderStaff> _providerStaffRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IUnitOfWork _unitOfWork;

    public CreateProviderStaffCommandHandler(
        IRepository<ProviderStaff> providerStaffRepository,
        IRepository<User> userRepository,
        IUnitOfWork unitOfWork)
    {
        _providerStaffRepository = providerStaffRepository;
        _userRepository = userRepository;
        _unitOfWork = unitOfWork;
    }

    public async Task<ProviderStaffDto> Handle(CreateProviderStaffCommand request, CancellationToken cancellationToken)
    {
        // Check for existing user by email
        var existingUsers = await _userRepository.FindAsync(u => u.Email == request.Email, cancellationToken);
        if (existingUsers.Any())
            throw new InvalidOperationException("A user with this email already exists.");

        var user = new User
        {
            Email = request.Email,
            UserType = UserType.ProviderStaff,
            Status = UserStatus.Pending,
            // Optionally set more fields
            // PasswordHash = ... (invite flow or set by staff)
        };
        await _userRepository.AddAsync(user, cancellationToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        var staff = new ProviderStaff
        {
            ProviderId = request.ProviderId,
            UserId = user.Id,
            Position = request.Position,
            SupervisorId = request.SupervisorId
        };
        await _providerStaffRepository.AddAsync(staff, cancellationToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return new ProviderStaffDto
        {
            Id = staff.Id,
            ProviderId = staff.ProviderId,
            UserId = staff.UserId,
            Email = user.Email,
            FirstName = request.FirstName,
            LastName = request.LastName,
            PhoneNumber = request.PhoneNumber,
            Position = staff.Position,
            SupervisorId = staff.SupervisorId
        };
    }
}
