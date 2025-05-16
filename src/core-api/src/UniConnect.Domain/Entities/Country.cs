using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Country : BaseEntity
{
    public string CountryName { get; set; } = string.Empty;
    public string CountryCode { get; set; } = string.Empty;
    public string? PhoneCode { get; set; }
    public string? Currency { get; set; }

    // Navigation properties
    public ICollection<University> Universities { get; private set; } = new List<University>();
    public ICollection<Address> Addresses { get; private set; } = new List<Address>();
}
