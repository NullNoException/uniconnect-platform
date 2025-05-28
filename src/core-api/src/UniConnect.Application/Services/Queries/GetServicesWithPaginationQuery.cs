using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Models;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Services.Queries;

public class GetServicesWithPaginationQuery : IRequest<PaginatedList<ServiceDto>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public bool? ActiveOnly { get; set; }
}

public class GetServicesWithPaginationQueryHandler : IRequestHandler<GetServicesWithPaginationQuery, PaginatedList<ServiceDto>>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly ILogger<GetServicesWithPaginationQueryHandler> _logger;

    public GetServicesWithPaginationQueryHandler(IRepository<Service> serviceRepository, ILogger<GetServicesWithPaginationQueryHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _logger = logger;
    }

    public async Task<PaginatedList<ServiceDto>> Handle(GetServicesWithPaginationQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting paginated services: Page={PageNumber}, Size={PageSize}, ActiveOnly={ActiveOnly}",
            request.PageNumber, request.PageSize, request.ActiveOnly);

        // Get all services or only active ones based on the request
        IReadOnlyList<Service> services;
        if (request.ActiveOnly.HasValue && request.ActiveOnly.Value)
        {
            services = await _serviceRepository.FindAsync(s => s.IsActive, cancellationToken);
        }
        else
        {
            services = await _serviceRepository.GetAllAsync(cancellationToken);
        }

        // Apply ordering
        var orderedServices = services.OrderByDescending(s => s.CreatedAt).ToList();

        // Calculate pagination
        var totalCount = orderedServices.Count;
        var pageSize = request.PageSize;
        var pageNumber = request.PageNumber;

        // Get the current page of items
        var items = orderedServices
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToList();

        var serviceDtos = items.Select(service => new ServiceDto
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
        }).ToList();

        return new PaginatedList<ServiceDto>(serviceDtos, totalCount, request.PageNumber, request.PageSize);
    }
}
