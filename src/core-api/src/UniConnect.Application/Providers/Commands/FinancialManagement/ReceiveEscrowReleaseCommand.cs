using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Commands.FinancialManagement;

public record ReceiveEscrowReleaseCommand : IRequest<EscrowReleaseDto>
{
    public Guid TransactionId { get; init; }
    public Guid ProviderId { get; init; }
    public string? ReleaseNotes { get; init; }
}
