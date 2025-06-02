using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Admin.Commands.ServiceManagement;

public class ManageServiceCategoryCommandHandler : IRequestHandler<ManageServiceCategoryCommand, ServiceCategoryDto>
{
    private readonly IRepository<ServiceCategory> _categoryRepository;
    private readonly ILogger<ManageServiceCategoryCommandHandler> _logger;

    public ManageServiceCategoryCommandHandler(
        IRepository<ServiceCategory> categoryRepository,
        ILogger<ManageServiceCategoryCommandHandler> logger)
    {
        _categoryRepository = categoryRepository;
        _logger = logger;
    }

    public async Task<ServiceCategoryDto> Handle(ManageServiceCategoryCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Managing service category with operation {Operation}", request.Operation);

        ServiceCategory category;

        switch (request.Operation)
        {
            case ServiceCategoryOperation.Create:
                category = new ServiceCategory
                {
                    CategoryName = request.CategoryName,
                    Description = request.Description,
                    IconUrl = request.IconUrl,
                    IsActive = request.IsActive,
                    DisplayOrder = request.SortOrder
                };
                await _categoryRepository.AddAsync(category, cancellationToken);
                _logger.LogInformation("Created new service category: {CategoryName}", request.CategoryName);
                break;

            case ServiceCategoryOperation.Update:
                if (!request.CategoryId.HasValue)
                    throw new ArgumentException("CategoryId is required for update operation");

                var retrievedCategory = await _categoryRepository.GetByIdAsync(request.CategoryId.Value, cancellationToken);
                if (retrievedCategory == null)
                    throw new InvalidOperationException($"Service category with ID {request.CategoryId} not found");
                category = retrievedCategory;

                category.CategoryName = request.CategoryName;
                category.Description = request.Description;
                category.IconUrl = request.IconUrl;
                category.IsActive = request.IsActive;
                category.DisplayOrder = request.SortOrder;

                await _categoryRepository.UpdateAsync(category, cancellationToken);
                _logger.LogInformation("Updated service category: {CategoryId}", request.CategoryId);
                break;

            case ServiceCategoryOperation.Delete:
                if (!request.CategoryId.HasValue)
                    throw new ArgumentException("CategoryId is required for delete operation");

                var existingCategory = await _categoryRepository.GetByIdAsync(request.CategoryId.Value, cancellationToken) ?? throw new InvalidOperationException($"Service category with ID {request.CategoryId} not found");
                category = existingCategory;

                await _categoryRepository.DeleteAsync(category, cancellationToken);
                _logger.LogInformation("Deleted service category: {CategoryId}", request.CategoryId);
                break;

            case ServiceCategoryOperation.Activate:
                if (!request.CategoryId.HasValue)
                    throw new ArgumentException("CategoryId is required for activate operation");

                category = await _categoryRepository.GetByIdAsync(request.CategoryId.Value, cancellationToken) ??
                    throw new InvalidOperationException($"Service category with ID {request.CategoryId} not found");

                category.IsActive = true;
                await _categoryRepository.UpdateAsync(category, cancellationToken);
                _logger.LogInformation("Activated service category: {CategoryId}", request.CategoryId);
                break;

            case ServiceCategoryOperation.Deactivate:
                if (!request.CategoryId.HasValue)
                    throw new ArgumentException("CategoryId is required for deactivate operation");

                category = await _categoryRepository.GetByIdAsync(request.CategoryId.Value, cancellationToken) ?? throw new InvalidOperationException($"Service category with ID {request.CategoryId} not found");
                category.IsActive = false;
                await _categoryRepository.UpdateAsync(category, cancellationToken);
                _logger.LogInformation("Deactivated service category: {CategoryId}", request.CategoryId);
                break;

            default:
                throw new ArgumentException($"Unknown operation: {request.Operation}");
        }

        return new ServiceCategoryDto
        {
            Id = category.Id,
            CategoryName = category.CategoryName,
            Description = category.Description,
            IconUrl = category.IconUrl,
            IsActive = category.IsActive,
            DisplayOrder = category.DisplayOrder,
            CreatedAt = category.CreatedAt,
            UpdatedAt = category.UpdatedAt
        };
    }
}
