using MediatR;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Providers.Commands.ApplicationManagement;

public record ProcessApplicationCommand : IRequest<ServiceRequestDto>
{
    public Guid ApplicationId { get; init; }
    public Guid ProviderId { get; init; }
    public ServiceRequestStatus NewStatus { get; init; }
    public string? Notes { get; init; }
    public DateTime? CompletionDate { get; init; }
    public string? CancellationReason { get; init; }
}
