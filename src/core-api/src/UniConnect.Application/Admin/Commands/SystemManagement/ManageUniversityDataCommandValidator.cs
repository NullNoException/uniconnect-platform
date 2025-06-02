using FluentValidation;

namespace UniConnect.Application.Admin.Commands.SystemManagement;

public class ManageUniversityDataCommandValidator : AbstractValidator<ManageUniversityDataCommand>
{
    public ManageUniversityDataCommandValidator()
    {
        RuleFor(x => x.AdminId)
            .NotEmpty()
            .WithMessage("Admin ID is required");

        RuleFor(x => x.UniversityName)
            .NotEmpty()
            .When(x => x.Operation == UniversityDataOperation.Create || x.Operation == UniversityDataOperation.Update)
            .WithMessage("University name is required for create and update operations")
            .MaximumLength(200)
            .WithMessage("University name must not exceed 200 characters");

        RuleFor(x => x.UniversityCode)
            .MaximumLength(20)
            .When(x => !string.IsNullOrEmpty(x.UniversityCode))
            .WithMessage("University code must not exceed 20 characters");

        RuleFor(x => x.Country)
            .MaximumLength(100)
            .When(x => !string.IsNullOrEmpty(x.Country))
            .WithMessage("Country must not exceed 100 characters");

        RuleFor(x => x.State)
            .MaximumLength(100)
            .When(x => !string.IsNullOrEmpty(x.State))
            .WithMessage("State must not exceed 100 characters");

        RuleFor(x => x.City)
            .MaximumLength(100)
            .When(x => !string.IsNullOrEmpty(x.City))
            .WithMessage("City must not exceed 100 characters");

        RuleFor(x => x.Website)
            .Must(BeValidUrl)
            .When(x => !string.IsNullOrEmpty(x.Website))
            .WithMessage("Website must be a valid URL");

        RuleFor(x => x.UniversityId)
            .NotEmpty()
            .When(x => x.Operation != UniversityDataOperation.Create)
            .WithMessage("University ID is required for update, delete, activate, and deactivate operations");

        RuleFor(x => x.Operation)
            .IsInEnum()
            .WithMessage("Invalid operation specified");
    }

    private bool BeValidUrl(string? url)
    {
        return string.IsNullOrEmpty(url) || Uri.TryCreate(url, UriKind.Absolute, out _);
    }
}
