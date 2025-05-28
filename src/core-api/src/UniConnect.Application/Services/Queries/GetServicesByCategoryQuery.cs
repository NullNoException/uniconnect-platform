using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Services.Queries;

public record GetServicesByCategoryQuery(Guid CategoryId) : IRequest<IEnumerable<ServiceDto>>;

public class GetServicesByCategoryQueryHandler : IRequestHandler<GetServicesByCategoryQuery, IEnumerable<ServiceDto>>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly ILogger<GetServicesByCategoryQueryHandler> _logger;

    public GetServicesByCategoryQueryHandler(IRepository<Service> serviceRepository, ILogger<GetServicesByCategoryQueryHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _logger = logger;
    }

    public async Task<IEnumerable<ServiceDto>> Handle(GetServicesByCategoryQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting services for category {CategoryId}", request.CategoryId);

        var services = await _serviceRepository.FindAsync(
            s => s.CategoryId == request.CategoryId,
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
