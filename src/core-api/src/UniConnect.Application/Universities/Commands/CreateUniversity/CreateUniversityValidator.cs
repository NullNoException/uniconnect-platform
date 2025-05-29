using FluentValidation;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Commands.CreateUniversity;

public class CreateUniversityValidator : AbstractValidator<CreateUniversityRequest>
{
    public CreateUniversityValidator()
    {
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

        // Validate address if provided
        RuleFor(x => x.Address)
            .SetValidator(new CreateUniversityAddressValidator()!)
            .When(x => x.Address != null);

        // Validate contacts
        RuleForEach(x => x.Contacts)
            .SetValidator(new CreateUniversityContactValidator());

        // Ensure at least one primary contact if contacts are provided
        RuleFor(x => x.Contacts)
            .Must(contacts => contacts.Count == 0 || contacts.Any(c => c.IsPrimary))
            .WithMessage("At least one contact must be marked as primary when contacts are provided");
    }

    private static bool BeValidUrl(string? url)
    {
        if (string.IsNullOrEmpty(url)) return true;
        return Uri.TryCreate(url, UriKind.Absolute, out var uriResult)
               && (uriResult.Scheme == Uri.UriSchemeHttp || uriResult.Scheme == Uri.UriSchemeHttps);
    }
}

public class CreateUniversityAddressValidator : AbstractValidator<CreateUniversityAddressRequest>
{
    public CreateUniversityAddressValidator()
    {
        RuleFor(x => x.AddressType)
            .NotEmpty().WithMessage("Address type is required")
            .MaximumLength(50).WithMessage("Address type cannot exceed 50 characters");

        RuleFor(x => x.Street)
            .MaximumLength(200).WithMessage("Street cannot exceed 200 characters")
            .When(x => !string.IsNullOrEmpty(x.Street));

        RuleFor(x => x.City)
            .MaximumLength(100).WithMessage("City cannot exceed 100 characters")
            .When(x => !string.IsNullOrEmpty(x.City));

        RuleFor(x => x.State)
            .MaximumLength(100).WithMessage("State cannot exceed 100 characters")
            .When(x => !string.IsNullOrEmpty(x.State));

        RuleFor(x => x.PostalCode)
            .MaximumLength(20).WithMessage("Postal code cannot exceed 20 characters")
            .When(x => !string.IsNullOrEmpty(x.PostalCode));

        RuleFor(x => x.CountryId)
            .NotEmpty().WithMessage("Country is required");

        RuleFor(x => x.Latitude)
            .InclusiveBetween(-90, 90).WithMessage("Latitude must be between -90 and 90")
            .When(x => x.Latitude.HasValue);

        RuleFor(x => x.Longitude)
            .InclusiveBetween(-180, 180).WithMessage("Longitude must be between -180 and 180")
            .When(x => x.Longitude.HasValue);
    }
}

public class CreateUniversityContactValidator : AbstractValidator<CreateUniversityContactRequest>
{
    public CreateUniversityContactValidator()
    {
        RuleFor(x => x.ContactType)
            .NotEmpty().WithMessage("Contact type is required")
            .MaximumLength(50).WithMessage("Contact type cannot exceed 50 characters");

        RuleFor(x => x.Name)
            .MaximumLength(100).WithMessage("Name cannot exceed 100 characters")
            .When(x => !string.IsNullOrEmpty(x.Name));

        RuleFor(x => x.Email)
            .EmailAddress().WithMessage("Email must be a valid email address")
            .When(x => !string.IsNullOrEmpty(x.Email));

        RuleFor(x => x.Department)
            .MaximumLength(100).WithMessage("Department cannot exceed 100 characters")
            .When(x => !string.IsNullOrEmpty(x.Department));

        // At least email or phone must be provided
        RuleFor(x => x)
            .Must(x => !string.IsNullOrEmpty(x.Email) || !string.IsNullOrEmpty(x.Phone))
            .WithMessage("Either email or phone must be provided");
    }
}
