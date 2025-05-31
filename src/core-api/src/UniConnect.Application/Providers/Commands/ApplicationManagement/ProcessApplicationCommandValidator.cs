using FluentValidation;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Providers.Commands.ApplicationManagement;

public class ProcessApplicationCommandValidator : AbstractValidator<ProcessApplicationCommand>
{
    public ProcessApplicationCommandValidator()
    {
        RuleFor(x => x.ApplicationId)
            .NotEmpty()
            .WithMessage("Application ID is required");

        RuleFor(x => x.ProviderId)
            .NotEmpty()
            .WithMessage("Provider ID is required");

        RuleFor(x => x.NewStatus)
            .IsInEnum()
            .WithMessage("Valid status is required");

        RuleFor(x => x.Notes)
            .MaximumLength(2000)
            .WithMessage("Notes cannot exceed 2000 characters");

        RuleFor(x => x.CancellationReason)
            .NotEmpty()
            .WithMessage("Cancellation reason is required when cancelling")
            .When(x => x.NewStatus == ServiceRequestStatus.Cancelled);

        RuleFor(x => x.CancellationReason)
            .MaximumLength(1000)
            .WithMessage("Cancellation reason cannot exceed 1000 characters")
            .When(x => !string.IsNullOrEmpty(x.CancellationReason));

        RuleFor(x => x.CompletionDate)
            .NotEmpty()
            .WithMessage("Completion date is required when marking as completed")
            .When(x => x.NewStatus == ServiceRequestStatus.Completed);

        RuleFor(x => x.CompletionDate)
            .LessThanOrEqualTo(DateTime.UtcNow)
            .WithMessage("Completion date cannot be in the future")
            .When(x => x.CompletionDate.HasValue);
    }
}
