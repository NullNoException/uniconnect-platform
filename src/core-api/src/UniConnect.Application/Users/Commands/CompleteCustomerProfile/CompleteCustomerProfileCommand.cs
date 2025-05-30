using MediatR;
using System.Collections.Generic;

namespace UniConnect.Application.Users.Commands.CompleteCustomerProfile;

public record CompleteCustomerProfileCommand(
    Guid UserId,
    string FirstName,
    string LastName,
    string? DateOfBirth,
    string? PhoneNumber,
    string? ProfilePictureUrl,
    List<EducationDto> Educations,
    List<string> TargetCountries,
    List<string> EducationGoals,
    CommunicationPreferencesDto CommunicationPreferences
) : IRequest<Unit>;

public record EducationDto(string School, string Degree, string FieldOfStudy, string StartYear, string? EndYear);
public record CommunicationPreferencesDto(bool Email, bool Sms, bool WhatsApp, bool Telegram);
