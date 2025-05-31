using FluentValidation;
using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.ServiceManagement;

public record UpdateServiceListingCommand : IRequest<ServiceDto>
{
    public Guid ServiceId { get; init; }
    public Guid ProviderId { get; init; }
    public Guid CategoryId { get; init; }
    public string ServiceName { get; init; } = string.Empty;
    public string? Description { get; init; }
    public string? ShortDescription { get; init; }
    public decimal BasePrice { get; init; }
    public Guid CurrencyId { get; init; }
    public int? EstimatedDeliveryDays { get; init; }
    public string? ThumbnailUrl { get; init; }
    public bool IsActive { get; init; } = true;

    // Service Attributes
    public List<ServiceAttributeDto> Attributes { get; init; } = new();

    // Service Requirements
    public List<ServiceRequirementDto> Requirements { get; init; } = new();

    // Service Price Components
    public List<ServicePriceComponentDto> PriceComponents { get; init; } = new();
}

public class UpdateServiceListingCommandHandler : IRequestHandler<UpdateServiceListingCommand, ServiceDto>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly IRepository<ServiceProvider> _serviceProviderRepository;
    private readonly IRepository<ServiceCategory> _categoryRepository;
    private readonly IRepository<Currency> _currencyRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<UpdateServiceListingCommandHandler> _logger;

    public UpdateServiceListingCommandHandler(
        IRepository<Service> serviceRepository,
        IRepository<ServiceProvider> serviceProviderRepository,
        IRepository<ServiceCategory> categoryRepository,
        IRepository<Currency> currencyRepository,
        IUnitOfWork unitOfWork,
        ILogger<UpdateServiceListingCommandHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _serviceProviderRepository = serviceProviderRepository;
        _categoryRepository = categoryRepository;
        _currencyRepository = currencyRepository;
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<ServiceDto> Handle(UpdateServiceListingCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Updating service listing {ServiceId} for provider {ProviderId}",
            request.ServiceId, request.ProviderId);

        // Get existing service
        var service = await _serviceRepository.GetByIdAsync(request.ServiceId, cancellationToken);
        if (service == null)
        {
            throw new InvalidOperationException($"Service with ID {request.ServiceId} not found");
        }

        // Verify provider owns this service
        if (service.ProviderId != request.ProviderId)
        {
            throw new InvalidOperationException("Provider can only update their own services");
        }

        // Validate provider exists and is verified
        var provider = await _serviceProviderRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        if (provider.VerificationStatus != Domain.Enums.ProviderVerificationStatus.Verified)
        {
            throw new InvalidOperationException("Only verified providers can update service listings");
        }

        // Validate category exists
        var category = await _categoryRepository.GetByIdAsync(request.CategoryId, cancellationToken);
        if (category == null)
        {
            throw new InvalidOperationException($"Service category with ID {request.CategoryId} not found");
        }

        // Validate currency exists
        var currency = await _currencyRepository.GetByIdAsync(request.CurrencyId, cancellationToken);
        if (currency == null)
        {
            throw new InvalidOperationException($"Currency with ID {request.CurrencyId} not found");
        }

        // Update service properties
        service.CategoryId = request.CategoryId;
        service.ServiceName = request.ServiceName;
        service.Description = request.Description;
        service.ShortDescription = request.ShortDescription;
        service.BasePrice = request.BasePrice;
        service.CurrencyId = request.CurrencyId;
        service.EstimatedDeliveryDays = request.EstimatedDeliveryDays;
        service.ThumbnailUrl = request.ThumbnailUrl;
        service.IsActive = request.IsActive;

        // Clear existing attributes and add new ones
        service.Attributes.Clear();
        foreach (var attr in request.Attributes)
        {
            service.Attributes.Add(new ServiceAttribute
            {
                AttributeKey = attr.AttributeKey,
                AttributeValue = attr.AttributeValue
            });
        }

        // Clear existing requirements and add new ones
        service.Requirements.Clear();
        foreach (var req in request.Requirements)
        {
            service.Requirements.Add(new ServiceRequirement
            {
                RequirementName = req.RequirementName,
                RequirementDescription = req.RequirementDescription,
                IsMandatory = req.IsMandatory,
                DocumentTypeId = req.DocumentTypeId
            });
        }

        // Clear existing price components and add new ones
        service.PriceComponents.Clear();
        foreach (var comp in request.PriceComponents)
        {
            service.PriceComponents.Add(new ServicePriceComponent
            {
                ComponentName = comp.ComponentName,
                ComponentDescription = comp.ComponentDescription,
                Price = comp.Price,
                IsOptional = comp.IsOptional
            });
        }

        await _serviceRepository.UpdateAsync(service);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Updated service listing {ServiceId} for provider {ProviderId}",
            request.ServiceId, request.ProviderId);

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
