using FluentValidation;

namespace UniConnect.Application.Users.Commands.CompleteCustomerProfile;

public class CompleteCustomerProfileCommandValidator : AbstractValidator<CompleteCustomerProfileCommand>
{
    public CompleteCustomerProfileCommandValidator()
    {
        RuleFor(x => x.UserId).NotEmpty();
        RuleFor(x => x.FirstName).NotEmpty();
        RuleFor(x => x.LastName).NotEmpty();
        RuleFor(x => x.ProfilePictureUrl)
            .MaximumLength(500)
            .When(x => !string.IsNullOrEmpty(x.ProfilePictureUrl));
        RuleForEach(x => x.Educations).SetValidator(new EducationDtoValidator());
        RuleFor(x => x.TargetCountries).NotEmpty();
        RuleFor(x => x.EducationGoals).NotEmpty();
        RuleFor(x => x.CommunicationPreferences).NotNull();
    }

    private class EducationDtoValidator : AbstractValidator<EducationDto>
    {
        public EducationDtoValidator()
        {
            RuleFor(x => x.School).NotEmpty();
            RuleFor(x => x.Degree).NotEmpty();
            RuleFor(x => x.FieldOfStudy).NotEmpty();
            RuleFor(x => x.StartYear).NotEmpty();
        }
    }
}
