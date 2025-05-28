using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Services.Queries;

public record GetServiceByIdQuery(Guid ServiceId) : IRequest<ServiceDto?>;

public class GetServiceByIdQueryHandler : IRequestHandler<GetServiceByIdQuery, ServiceDto?>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly ILogger<GetServiceByIdQueryHandler> _logger;

    public GetServiceByIdQueryHandler(IRepository<Service> serviceRepository, ILogger<GetServiceByIdQueryHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _logger = logger;
    }

    public async Task<ServiceDto?> Handle(GetServiceByIdQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting service with ID {ServiceId}", request.ServiceId);

        var service = await _serviceRepository.GetByIdAsync(request.ServiceId);

        if (service == null)
        {
            _logger.LogWarning("Service with ID {ServiceId} not found", request.ServiceId);
            return null;
        }

        return MapToDto(service);
    }

    private static ServiceDto MapToDto(Service service)
    {
        return new ServiceDto
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
        };
    }
}
