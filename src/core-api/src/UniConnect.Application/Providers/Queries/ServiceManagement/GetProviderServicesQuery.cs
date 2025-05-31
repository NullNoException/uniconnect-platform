using MediatR;
using UniConnect.Application.Services.DTOs;

namespace UniConnect.Application.Providers.Queries.ServiceManagement;

public record GetProviderServicesQuery : IRequest<List<ServiceDto>>
{
    public Guid ProviderId { get; init; }
    public bool? IsActive { get; init; }
    public Guid? CategoryId { get; init; }
}
