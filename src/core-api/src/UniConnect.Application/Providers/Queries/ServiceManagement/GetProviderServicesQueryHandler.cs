using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Queries.ServiceManagement;

public class GetProviderServicesQueryHandler : IRequestHandler<GetProviderServicesQuery, List<ServiceDto>>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly ILogger<GetProviderServicesQueryHandler> _logger;

    public GetProviderServicesQueryHandler(
        IRepository<Service> serviceRepository,
        ILogger<GetProviderServicesQueryHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _logger = logger;
    }

    public async Task<List<ServiceDto>> Handle(GetProviderServicesQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting services for provider {ProviderId}", request.ProviderId);

        var allServices = await _serviceRepository.GetAllAsync(cancellationToken);
        var services = allServices.Where(s => s.ProviderId == request.ProviderId &&
                                             (!request.IsActive.HasValue || s.IsActive == request.IsActive.Value) &&
                                             (!request.CategoryId.HasValue || s.CategoryId == request.CategoryId.Value))
                                 .ToList();

        return services.Select(s => new ServiceDto
        {
            Id = s.Id,
            ServiceName = s.ServiceName,
            Description = s.Description,
            ProviderId = s.ProviderId,
            CategoryId = s.CategoryId,
            BasePrice = s.BasePrice,
            CurrencyId = s.CurrencyId,
            EstimatedDeliveryDays = s.EstimatedDeliveryDays,
            IsActive = s.IsActive,
            CreatedAt = s.CreatedAt,
            UpdatedAt = s.UpdatedAt
        }).ToList();
    }
}
