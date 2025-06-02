using FluentValidation;

namespace UniConnect.Application.Admin.Commands.ProviderManagement;

public class VerifyProviderCommandValidator : AbstractValidator<VerifyProviderCommand>
{
    public VerifyProviderCommandValidator()
    {
        RuleFor(x => x.ProviderId)
            .NotEmpty()
            .WithMessage("Provider ID is required");

        RuleFor(x => x.Status)
            .IsInEnum()
            .WithMessage("Valid verification status is required");

        RuleFor(x => x.AdminId)
            .NotEmpty()
            .WithMessage("Admin ID is required");

        RuleFor(x => x.RejectionReason)
            .NotEmpty()
            .When(x => x.Status == Domain.Enums.ProviderVerificationStatus.Rejected)
            .WithMessage("Rejection reason is required when rejecting a provider");

        RuleFor(x => x.VerificationNotes)
            .MaximumLength(1000)
            .WithMessage("Verification notes cannot exceed 1000 characters");

        RuleFor(x => x.RejectionReason)
            .MaximumLength(500)
            .WithMessage("Rejection reason cannot exceed 500 characters");
    }
}
