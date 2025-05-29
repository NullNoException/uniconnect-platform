using FluentValidation;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Commands.UpdateUniversity;

public class UpdateUniversityValidator : AbstractValidator<UpdateUniversityRequest>
{
    public UpdateUniversityValidator()
    {
        RuleFor(x => x.Id)
            .NotEmpty().WithMessage("University ID is required");

        RuleFor(x => x.Name)
            .NotEmpty().WithMessage("University name is required")
            .MaximumLength(256).WithMessage("University name cannot exceed 256 characters");

        RuleFor(x => x.Description)
            .MaximumLength(2000).WithMessage("Description cannot exceed 2000 characters")
            .When(x => !string.IsNullOrEmpty(x.Description));

        RuleFor(x => x.CountryId)
            .NotEmpty().WithMessage("Country is required");

        RuleFor(x => x.Website)
            .Must(BeValidUrl).WithMessage("Website must be a valid URL")
            .When(x => !string.IsNullOrEmpty(x.Website));

        RuleFor(x => x.Email)
            .EmailAddress().WithMessage("Email must be a valid email address")
            .When(x => !string.IsNullOrEmpty(x.Email));

        RuleFor(x => x.EstablishedYear)
            .InclusiveBetween(1800, 2030).WithMessage("Established year must be between 1800 and 2030")
            .When(x => x.EstablishedYear > 0);

        RuleFor(x => x.Type)
            .MaximumLength(50).WithMessage("Type cannot exceed 50 characters")
            .When(x => !string.IsNullOrEmpty(x.Type));

        RuleFor(x => x.Ranking)
            .GreaterThanOrEqualTo(0).WithMessage("Ranking must be greater than or equal to 0")
            .LessThanOrEqualTo(10000).WithMessage("Ranking must be less than or equal to 10000")
            .When(x => x.Ranking.HasValue);
    }

    private static bool BeValidUrl(string? url)
    {
        if (string.IsNullOrEmpty(url)) return true;
        return Uri.TryCreate(url, UriKind.Absolute, out var uriResult)
               && (uriResult.Scheme == Uri.UriSchemeHttp || uriResult.Scheme == Uri.UriSchemeHttps);
    }
}
