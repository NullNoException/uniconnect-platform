using FluentValidation;

namespace UniConnect.Application.Providers.Commands.ApplicationManagement;

public class RequestApplicationRevisionCommandValidator : AbstractValidator<RequestApplicationRevisionCommand>
{
    public RequestApplicationRevisionCommandValidator()
    {
        RuleFor(x => x.ApplicationId)
            .NotEmpty()
            .WithMessage("Application ID is required");

        RuleFor(x => x.ProviderId)
            .NotEmpty()
            .WithMessage("Provider ID is required");

        RuleFor(x => x.RevisionReason)
            .NotEmpty()
            .WithMessage("Revision reason is required")
            .MaximumLength(2000)
            .WithMessage("Revision reason cannot exceed 2000 characters");

        RuleForEach(x => x.DocumentRevisions)
            .SetValidator(new DocumentRevisionRequestValidator());
    }
}

public class DocumentRevisionRequestValidator : AbstractValidator<DocumentRevisionRequest>
{
    public DocumentRevisionRequestValidator()
    {
        RuleFor(x => x.DocumentId)
            .NotEmpty()
            .WithMessage("Document ID is required");

        RuleFor(x => x.RevisionNotes)
            .NotEmpty()
            .WithMessage("Revision notes are required for each document")
            .MaximumLength(1000)
            .WithMessage("Revision notes cannot exceed 1000 characters");
    }
}
