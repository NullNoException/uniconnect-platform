using FluentValidation;

namespace UniConnect.Application.Users.Commands;

public class RegisterUserCommandValidator : AbstractValidator<RegisterUserCommand>
{
    public RegisterUserCommandValidator()
    {
        RuleFor(v => v.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("Email is not valid.");

        RuleFor(v => v.Password)
            .NotEmpty().WithMessage("Password is required.")
            .MinimumLength(8).WithMessage("Password must be at least 8 characters.")
            .Matches("[A-Z]").WithMessage("Password must contain at least one uppercase letter.")
            .Matches("[a-z]").WithMessage("Password must contain at least one lowercase letter.")
            .Matches("[0-9]").WithMessage("Password must contain at least one number.")
            .Matches("[^a-zA-Z0-9]").WithMessage("Password must contain at least one special character.");

        RuleFor(v => v.ConfirmPassword)
            .Equal(v => v.Password).WithMessage("Passwords do not match.");

        RuleFor(v => v.FirstName)
            .NotEmpty().WithMessage("First name is required.")
            .MaximumLength(50).WithMessage("First name cannot exceed 50 characters.");

        RuleFor(v => v.LastName)
            .NotEmpty().WithMessage("Last name is required.")
            .MaximumLength(50).WithMessage("Last name cannot exceed 50 characters.");

        RuleFor(v => v.UserType)
            .IsInEnum().WithMessage("Invalid user type.");

        RuleFor(v => v.PhoneNumber)
            .Matches(@"^\+?[0-9\s\-\(\)]+$").WithMessage("Phone number is not valid.")
            .When(v => !string.IsNullOrEmpty(v.PhoneNumber));

        RuleFor(v => v.PreferredLanguage)
            .MaximumLength(10).WithMessage("Preferred language code cannot exceed 10 characters.");
    }
}
