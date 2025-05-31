using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Commands.ApplicationManagement;

public record RequestApplicationRevisionCommand : IRequest<ServiceRequestDto>
{
    public Guid ApplicationId { get; init; }
    public Guid ProviderId { get; init; }
    public string RevisionReason { get; init; } = string.Empty;
    public List<DocumentRevisionRequest> DocumentRevisions { get; init; } = new();
}

public record DocumentRevisionRequest
{
    public Guid DocumentId { get; init; }
    public string RevisionNotes { get; init; } = string.Empty;
}
