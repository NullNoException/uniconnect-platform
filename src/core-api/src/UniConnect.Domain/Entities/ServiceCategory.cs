using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class ServiceCategory : BaseEntity
{
    public string CategoryName { get; set; } = string.Empty;
    public Guid? ParentCategoryId { get; set; }
    public string? Description { get; set; }
    public string? IconUrl { get; set; }
    public bool IsActive { get; set; } = true;
    public int DisplayOrder { get; set; }

    // Navigation properties
    public ServiceCategory? ParentCategory { get; set; }
    public ICollection<ServiceCategory> ChildCategories { get; private set; } = new List<ServiceCategory>();
    public ICollection<Service> Services { get; private set; } = new List<Service>();
}
