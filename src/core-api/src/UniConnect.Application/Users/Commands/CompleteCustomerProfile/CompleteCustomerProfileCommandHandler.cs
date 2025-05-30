using MediatR;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace UniConnect.Application.Users.Commands.CompleteCustomerProfile;

public class CompleteCustomerProfileCommandHandler : IRequestHandler<CompleteCustomerProfileCommand>
{
    private readonly IApplicationDbContext _db;

    public CompleteCustomerProfileCommandHandler(IApplicationDbContext db)
    {
        _db = db;
    }

    public async Task<Unit> Handle(CompleteCustomerProfileCommand request, CancellationToken cancellationToken)
    {
        var user = await _db.Users.Include(u => u.Profile)
            .FirstOrDefaultAsync(u => u.Id == request.UserId, cancellationToken);
        if (user == null)
            throw new KeyNotFoundException("User not found");

        user.FirstName = request.FirstName;
        user.LastName = request.LastName;
        user.PhoneNumber = request.PhoneNumber;
        user.ProfilePictureUrl = request.ProfilePictureUrl;
        // Update or create profile
        if (user.Profile == null)
            user.Profile = new UserProfile();
        user.Profile.DateOfBirth = request.DateOfBirth;
        user.Profile.Educations = request.Educations.Select(e => new Education
        {
            School = e.School,
            Degree = e.Degree,
            FieldOfStudy = e.FieldOfStudy,
            StartYear = e.StartYear,
            EndYear = e.EndYear
        }).ToList();
        user.Profile.TargetCountries = string.Join(",", request.TargetCountries);
        user.Profile.EducationGoals = string.Join(",", request.EducationGoals);
        user.Profile.CommunicationPreferences = new CommunicationPreferences
        {
            Email = request.CommunicationPreferences.Email,
            Sms = request.CommunicationPreferences.Sms,
            WhatsApp = request.CommunicationPreferences.WhatsApp,
            Telegram = request.CommunicationPreferences.Telegram
        };
        await _db.SaveChangesAsync(cancellationToken);
        return Unit.Value;
    }
}
