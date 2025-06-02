using FluentValidation;

namespace UniConnect.Application.Admin.Commands.FinancialManagement;

public class ManageRefundDisputeCommandValidator : AbstractValidator<ManageRefundDisputeCommand>
{
    public ManageRefundDisputeCommandValidator()
    {
        RuleFor(x => x.TransactionId)
            .NotEmpty()
            .WithMessage("Transaction ID is required");

        RuleFor(x => x.AdminId)
            .NotEmpty()
            .WithMessage("Admin ID is required");

        RuleFor(x => x.Action)
            .IsInEnum()
            .WithMessage("Invalid action specified");

        RuleFor(x => x.RefundAmount)
            .GreaterThan(0)
            .When(x => x.Action == RefundDisputeAction.PartialRefund)
            .WithMessage("Refund amount must be greater than zero for partial refunds");

        RuleFor(x => x.Resolution)
            .NotEmpty()
            .WithMessage("Resolution description is required")
            .MaximumLength(1000)
            .WithMessage("Resolution must not exceed 1000 characters");

        RuleFor(x => x.Notes)
            .MaximumLength(1000)
            .When(x => !string.IsNullOrEmpty(x.Notes))
            .WithMessage("Notes must not exceed 1000 characters");
    }
}
