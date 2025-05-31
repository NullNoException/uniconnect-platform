using FluentValidation;

namespace UniConnect.Application.Providers.Commands.StaffAccountManagement;

public class UpdateProviderStaffCommandValidator : AbstractValidator<UpdateProviderStaffCommand>
{
    public UpdateProviderStaffCommandValidator()
    {
        RuleFor(x => x.StaffId)
            .NotEmpty()
            .WithMessage("Staff ID is required");

        RuleFor(x => x.ProviderId)
            .NotEmpty()
            .WithMessage("Provider ID is required");

        RuleFor(x => x.FirstName)
            .MaximumLength(50)
            .When(x => !string.IsNullOrEmpty(x.FirstName))
            .WithMessage("First name must not exceed 50 characters");

        RuleFor(x => x.LastName)
            .MaximumLength(50)
            .When(x => !string.IsNullOrEmpty(x.LastName))
            .WithMessage("Last name must not exceed 50 characters");

        RuleFor(x => x.Role)
            .MaximumLength(100)
            .When(x => !string.IsNullOrEmpty(x.Role))
            .WithMessage("Role must not exceed 100 characters");

        RuleFor(x => x.Department)
            .MaximumLength(100)
            .When(x => !string.IsNullOrEmpty(x.Department))
            .WithMessage("Department must not exceed 100 characters");

        RuleFor(x => x.PhoneNumber)
            .Matches(@"^\+?[1-9]\d{1,14}$")
            .When(x => !string.IsNullOrEmpty(x.PhoneNumber))
            .WithMessage("Phone number must be in valid international format");

        RuleFor(x => x.Permissions)
            .Must(permissions => permissions == null || permissions.All(p => !string.IsNullOrWhiteSpace(p)))
            .WithMessage("All permissions must be valid non-empty strings");
    }
}
