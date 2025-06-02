using MediatR;
using UniConnect.Application.Services.DTOs;

namespace UniConnect.Application.Admin.Commands.ServiceManagement;

/// <summary>
/// Command to manage service categories
/// UC-3.2.2: Admin Manage Service Categories
/// </summary>
public record ManageServiceCategoryCommand : IRequest<ServiceCategoryDto>
{
    public Guid? CategoryId { get; init; } // null for create, set for update
    public string CategoryName { get; init; } = string.Empty;
    public string? Description { get; init; }
    public string? IconUrl { get; init; }
    public bool IsActive { get; init; } = true;
    public int SortOrder { get; init; }
    public Guid AdminId { get; init; }
    public ServiceCategoryOperation Operation { get; init; }
}

public enum ServiceCategoryOperation
{
    Create,
    Update,
    Delete,
    Activate,
    Deactivate
}

public record ManageServiceCategoryRequest
{
    public string CategoryName { get; init; } = string.Empty;
    public string? Description { get; init; }
    public string? IconUrl { get; init; }
    public bool IsActive { get; init; } = true;
    public int SortOrder { get; init; }
    public ServiceCategoryOperation Operation { get; init; }
}
