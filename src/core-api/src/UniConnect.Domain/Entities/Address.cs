using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Address : BaseEntity
{
    public Guid EntityId { get; set; }
    public string EntityType { get; set; } = string.Empty;
    public string AddressLine1 { get; set; } = string.Empty;
    public string? AddressLine2 { get; set; }
    public string City { get; set; } = string.Empty;
    public string? StateProvince { get; set; }
    public string PostalCode { get; set; } = string.Empty;
    public Guid CountryId { get; set; }
    public bool IsDefault { get; set; }

    // Navigation property
    public Country Country { get; set; } = null!;

    // Formatted address computed property
    public string FormattedAddress => $"{AddressLine1}, {(string.IsNullOrEmpty(AddressLine2) ? "" : AddressLine2 + ", ")}{City}, {StateProvince}, {PostalCode}";
}
