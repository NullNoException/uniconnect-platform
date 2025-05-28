using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Services.Queries;

public record GetServicesByProviderQuery(Guid ProviderId) : IRequest<IEnumerable<ServiceDto>>;

public class GetServicesByProviderQueryHandler : IRequestHandler<GetServicesByProviderQuery, IEnumerable<ServiceDto>>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly ILogger<GetServicesByProviderQueryHandler> _logger;

    public GetServicesByProviderQueryHandler(IRepository<Service> serviceRepository, ILogger<GetServicesByProviderQueryHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _logger = logger;
    }

    public async Task<IEnumerable<ServiceDto>> Handle(GetServicesByProviderQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting services for provider {ProviderId}", request.ProviderId);

        var services = await _serviceRepository.FindAsync(
            s => s.ProviderId == request.ProviderId,
            cancellationToken);

        var orderedServices = services.OrderBy(s => s.ServiceName).ToList();

        return orderedServices.Select(service => new ServiceDto
        {
            Id = service.Id,
            ServiceName = service.ServiceName,
            Description = service.Description,
            ProviderId = service.ProviderId,
            CategoryId = service.CategoryId,
            BasePrice = service.BasePrice,
            CurrencyId = service.CurrencyId,
            EstimatedDeliveryDays = service.EstimatedDeliveryDays,
            IsActive = service.IsActive,
            CreatedAt = service.CreatedAt,
            UpdatedAt = service.UpdatedAt
        });
    }
}
