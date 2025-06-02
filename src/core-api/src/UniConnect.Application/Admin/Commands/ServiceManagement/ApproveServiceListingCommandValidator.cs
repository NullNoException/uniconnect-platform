using FluentValidation;

namespace UniConnect.Application.Admin.Commands.ServiceManagement;

public class ApproveServiceListingCommandValidator : AbstractValidator<ApproveServiceListingCommand>
{
    public ApproveServiceListingCommandValidator()
    {
        RuleFor(x => x.ServiceId)
            .NotEmpty()
            .WithMessage("Service ID is required");

        RuleFor(x => x.Status)
            .IsInEnum()
            .WithMessage("Valid approval status is required");

        RuleFor(x => x.AdminId)
            .NotEmpty()
            .WithMessage("Admin ID is required");

        RuleFor(x => x.RejectionReason)
            .NotEmpty()
            .When(x => x.Status == Domain.Enums.ServiceApprovalStatus.Rejected)
            .WithMessage("Rejection reason is required when rejecting a service");

        RuleFor(x => x.ApprovalNotes)
            .MaximumLength(1000)
            .WithMessage("Approval notes cannot exceed 1000 characters");

        RuleFor(x => x.RejectionReason)
            .MaximumLength(500)
            .WithMessage("Rejection reason cannot exceed 500 characters");
    }
}
