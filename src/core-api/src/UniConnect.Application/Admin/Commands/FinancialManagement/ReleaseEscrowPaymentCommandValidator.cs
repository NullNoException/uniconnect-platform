using FluentValidation;

namespace UniConnect.Application.Admin.Commands.FinancialManagement;

public class ReleaseEscrowPaymentCommandValidator : AbstractValidator<ReleaseEscrowPaymentCommand>
{
    public ReleaseEscrowPaymentCommandValidator()
    {
        RuleFor(x => x.TransactionId)
            .NotEmpty()
            .WithMessage("Transaction ID is required");

        RuleFor(x => x.AdminId)
            .NotEmpty()
            .WithMessage("Admin ID is required");

        RuleFor(x => x.ReleaseNotes)
            .MaximumLength(1000)
            .When(x => !string.IsNullOrEmpty(x.ReleaseNotes))
            .WithMessage("Release notes must not exceed 1000 characters");
    }
}
