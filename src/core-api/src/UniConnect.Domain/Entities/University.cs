using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class University : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public Guid CountryId { get; set; }
    public Guid? AddressId { get; set; }
    public string? Website { get; set; }

    // Navigation properties
    public Country Country { get; set; } = null!;
    public Address? Address { get; set; }
    public ICollection<Student> Students { get; private set; } = new List<Student>();
}
