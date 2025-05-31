using FluentValidation;
using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.ServiceManagement;

public record CreateServiceListingCommand : IRequest<ServiceDto>
{
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

public record ServiceAttributeDto
{
    public string AttributeKey { get; init; } = string.Empty;
    public string AttributeValue { get; init; } = string.Empty;
}

public record ServiceRequirementDto
{
    public string RequirementName { get; init; } = string.Empty;
    public string? RequirementDescription { get; init; }
    public bool IsMandatory { get; init; }
    public Guid? DocumentTypeId { get; init; }
}

public record ServicePriceComponentDto
{
    public string ComponentName { get; init; } = string.Empty;
    public string? ComponentDescription { get; init; }
    public decimal Price { get; init; }
    public bool IsOptional { get; init; }
}

public class CreateServiceListingCommandHandler : IRequestHandler<CreateServiceListingCommand, ServiceDto>
{
    private readonly IRepository<Service> _serviceRepository;
    private readonly IRepository<ServiceProvider> _serviceProviderRepository;
    private readonly IRepository<ServiceCategory> _categoryRepository;
    private readonly IRepository<Currency> _currencyRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ILogger<CreateServiceListingCommandHandler> _logger;

    public CreateServiceListingCommandHandler(
        IRepository<Service> serviceRepository,
        IRepository<ServiceProvider> serviceProviderRepository,
        IRepository<ServiceCategory> categoryRepository,
        IRepository<Currency> currencyRepository,
        IUnitOfWork unitOfWork,
        ILogger<CreateServiceListingCommandHandler> logger)
    {
        _serviceRepository = serviceRepository;
        _serviceProviderRepository = serviceProviderRepository;
        _categoryRepository = categoryRepository;
        _currencyRepository = currencyRepository;
        _unitOfWork = unitOfWork;
        _logger = logger;
    }

    public async Task<ServiceDto> Handle(CreateServiceListingCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Creating service listing for provider {ProviderId}", request.ProviderId);

        // Validate provider exists and is verified
        var provider = await _serviceProviderRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        if (provider.VerificationStatus != Domain.Enums.ProviderVerificationStatus.Verified)
        {
            throw new InvalidOperationException("Only verified providers can create service listings");
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

        // Create service
        var service = new Service
        {
            ProviderId = request.ProviderId,
            CategoryId = request.CategoryId,
            ServiceName = request.ServiceName,
            Description = request.Description,
            ShortDescription = request.ShortDescription,
            BasePrice = request.BasePrice,
            CurrencyId = request.CurrencyId,
            EstimatedDeliveryDays = request.EstimatedDeliveryDays,
            ThumbnailUrl = request.ThumbnailUrl,
            IsActive = request.IsActive
        };

        // Add attributes
        foreach (var attr in request.Attributes)
        {
            service.Attributes.Add(new ServiceAttribute
            {
                AttributeKey = attr.AttributeKey,
                AttributeValue = attr.AttributeValue
            });
        }

        // Add requirements
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

        // Add price components
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

        await _serviceRepository.AddAsync(service);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Created service listing {ServiceId} for provider {ProviderId}",
            service.Id, request.ProviderId);

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
