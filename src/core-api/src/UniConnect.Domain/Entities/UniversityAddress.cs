using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class UniversityAddress : BaseEntity
{
    public Guid UniversityId { get; set; }
    public string AddressType { get; set; } = string.Empty; // Main Campus, Branch, Administrative, etc.
    public string? Street { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? PostalCode { get; set; }
    public Guid CountryId { get; set; }
    public double? Latitude { get; set; }
    public double? Longitude { get; set; }
    public bool IsPrimary { get; set; } = false;
    public bool IsActive { get; set; } = true;

    // Navigation properties
    public University University { get; set; } = null!;
    public Country Country { get; set; } = null!;
}
