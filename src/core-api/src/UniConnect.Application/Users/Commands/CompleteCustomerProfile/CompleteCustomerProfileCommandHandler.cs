using MediatR;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace UniConnect.Application.Users.Commands.CompleteCustomerProfile;

public class CompleteCustomerProfileCommandHandler : IRequestHandler<CompleteCustomerProfileCommand, Unit>
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

        // Update profile fields
        if (user.Profile == null)
            user.Profile = new UserProfile { UserId = user.Id };
        user.Profile.FirstName = request.FirstName;
        user.Profile.LastName = request.LastName;
        user.Profile.PhoneNumber = request.PhoneNumber;
        user.Profile.ProfilePictureUrl = request.ProfilePictureUrl;
        if (!string.IsNullOrWhiteSpace(request.DateOfBirth) && DateTime.TryParse(request.DateOfBirth, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out var dob))
            user.Profile.DateOfBirth = dob;
        // Update Educations
        user.Profile.Educations.Clear();
        foreach (var e in request.Educations)
        {
            user.Profile.Educations.Add(new Education
            {
                School = e.School,
                Degree = e.Degree,
                FieldOfStudy = e.FieldOfStudy,
                StartYear = e.StartYear,
                EndYear = e.EndYear
            });
        }
        // Update TargetCountries and EducationGoals as comma-separated
        user.Profile.TargetCountries = string.Join(",", request.TargetCountries);
        user.Profile.EducationGoals = string.Join(",", request.EducationGoals);
        // Update CommunicationPreferences
        if (user.Profile.CommunicationPreferences == null)
            user.Profile.CommunicationPreferences = new CommunicationPreferences();
        user.Profile.CommunicationPreferences.Email = request.CommunicationPreferences.Email;
        user.Profile.CommunicationPreferences.Sms = request.CommunicationPreferences.Sms;
        user.Profile.CommunicationPreferences.WhatsApp = request.CommunicationPreferences.WhatsApp;
        user.Profile.CommunicationPreferences.Telegram = request.CommunicationPreferences.Telegram;
        await _db.SaveChangesAsync(cancellationToken);
        return Unit.Value;
    }
}
