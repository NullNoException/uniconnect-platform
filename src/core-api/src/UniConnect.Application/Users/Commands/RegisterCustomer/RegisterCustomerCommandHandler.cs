using MediatR;
using UniConnect.Domain.Entities;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Domain.Services;
using Microsoft.EntityFrameworkCore;

namespace UniConnect.Application.Users.Commands.RegisterCustomer;

public class RegisterCustomerCommandHandler : IRequestHandler<RegisterCustomerCommand, Guid>
{
    private readonly IApplicationDbContext _db;
    private readonly IEmailService _emailService;

    public RegisterCustomerCommandHandler(IApplicationDbContext db, IEmailService emailService)
    {
        _db = db;
        _emailService = emailService;
    }

    public async Task<Guid> Handle(RegisterCustomerCommand request, CancellationToken cancellationToken)
    {
        if (await _db.Users.AnyAsync(u => u.Email == request.Email, cancellationToken))
            throw new ConflictException("Email already exists.");

        var user = new User
        {
            Email = request.Email,
            UserType = UniConnect.Domain.Enums.UserType.Student, // or Customer if defined
            Status = UniConnect.Domain.Enums.UserStatus.Pending,
            // PasswordHash = ... (hash password)
        };

        _db.Users.Add(user);
        await _db.SaveChangesAsync(cancellationToken);

        // Create user profile
        var profile = new UserProfile
        {
            UserId = user.Id,
            FirstName = request.FirstName,
            LastName = request.LastName,
            PhoneNumber = request.PhoneNumber,
            PreferredLanguage = request.PreferredLanguage
        };
        _db.UserProfiles.Add(profile);
        await _db.SaveChangesAsync(cancellationToken);

        // Send verification email
        await _emailService.SendVerificationEmailAsync(user.Email, /*token*/ "dummy-token");

        return user.Id;
    }
}
