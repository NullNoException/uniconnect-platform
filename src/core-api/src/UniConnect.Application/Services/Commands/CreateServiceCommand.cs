using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;
using DomainServiceProvider = UniConnect.Domain.Entities.ServiceProvider;

namespace UniConnect.Application.Services.Commands;

public record CreateServiceCommand : IRequest<Guid>
{
    public string ServiceName { get; init; } = string.Empty;
    public string Description { get; init; } = string.Empty;
    // Requirements is not directly part of the Service entity now
    public string Requirements { get; init; } = string.Empty;
    public Guid ProviderId { get; init; }
    public Guid CategoryId { get; init; }
    public bool IsActive { get; init; } = true;
}

public class CreateServiceCommandHandler : IRequestHandler<CreateServiceCommand, Guid>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly IRepository<ServiceProvider> _serviceProviderRepository;
    private readonly IRepository<ServiceCategory> _categoryRepository;
    private readonly ISearchService _searchService;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ITracingService _tracingService;
    private readonly ILogger<CreateServiceCommandHandler> _logger;

    public CreateServiceCommandHandler(
        IRepository<Service> serviceRepository,
        IRepository<ServiceProvider> serviceProviderRepository,
        IRepository<ServiceCategory> categoryRepository,
        ISearchService searchService,
        IUnitOfWork unitOfWork,
        ITracingService tracingService,
        ILogger<CreateServiceCommandHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _serviceProviderRepository = serviceProviderRepository;
        _categoryRepository = categoryRepository;
        _searchService = searchService;
        _unitOfWork = unitOfWork;
        _tracingService = tracingService;
        _logger = logger;
    }

    public async Task<Guid> Handle(CreateServiceCommand request, CancellationToken cancellationToken)
    {
        using var activity = _tracingService.StartActivity("CreateService", new Dictionary<string, object?>
        {
            ["service.name"] = request.ServiceName,
            ["service.provider_id"] = request.ProviderId,
            ["service.category_id"] = request.CategoryId
        });

        // Validate service provider exists
        var provider = await _serviceProviderRepository.GetByIdAsync(request.ProviderId);
        if (provider == null)
        {
            _logger.LogWarning("Service provider with ID {ProviderId} not found", request.ProviderId);
            throw new ArgumentException($"Service provider with ID {request.ProviderId} not found");
        }

        // Validate category exists
        var category = await _categoryRepository.GetByIdAsync(request.CategoryId);
        if (category == null)
        {
            _logger.LogWarning("Service category with ID {CategoryId} not found", request.CategoryId);
            throw new ArgumentException($"Service category with ID {request.CategoryId} not found");
        }

        _tracingService.AddActivityEvent("ValidationsCompleted");

        // Create new service
        var service = new Service
        {
            ServiceName = request.ServiceName,
            Description = request.Description,
            ProviderId = request.ProviderId,
            CategoryId = request.CategoryId,
            IsActive = request.IsActive,
            // Set the minimum price as 0 for now, it can be updated later
            BasePrice = 0,
            // For now, set currency ID with a placeholder - this would need proper handling
            CurrencyId = Guid.Empty
        };

        await _serviceRepository.AddAsync(service);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _tracingService.AddActivityEvent("ServiceCreated", new Dictionary<string, object?>
        {
            ["service.id"] = service.Id
        });

        // Index in MeiliSearch
        try
        {
            await _searchService.IndexServiceAsync(service, cancellationToken);
            _tracingService.AddActivityEvent("ServiceIndexed");
            _logger.LogInformation("Service {ServiceId} indexed in MeiliSearch", service.Id);
        }
        catch (Exception ex)
        {
            // Don't fail the whole operation if indexing fails
            _tracingService.RecordException(ex, new Dictionary<string, object?>
            {
                ["service.id"] = service.Id,
                ["operation"] = "meilisearch_indexing"
            });
            _logger.LogError(ex, "Failed to index service {ServiceId} in MeiliSearch", service.Id);
        }

        _logger.LogInformation("Created new service {ServiceId} for provider {ProviderId}",
            service.Id, service.ProviderId);

        return service.Id;
    }
}
