using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Queries.FinancialManagement;

public record GetProviderEarningsQuery : IRequest<ProviderEarningsDto>
{
    public Guid ProviderId { get; init; }
    public DateTime? DateFrom { get; init; }
    public DateTime? DateTo { get; init; }
    public bool IncludeProjections { get; init; } = false;
}
