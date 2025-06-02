using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class University : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public string? Description { get; set; }
    public Guid CountryId { get; set; }
    public Guid? AddressId { get; set; }
    public string? Website { get; set; }
    public string? LogoUrl { get; set; }
    public string? Email { get; set; }
    public string? Phone { get; set; }
    public UniversityStatus Status { get; set; } = UniversityStatus.PendingReview;
    public AccreditationStatus AccreditationStatus { get; set; } = AccreditationStatus.NotAccredited;
    public string? AccreditationBody { get; set; }
    public DateTime? AccreditationDate { get; set; }
    public string? RejectionReason { get; set; }
    public Guid? ReviewedByUserId { get; set; }
    public DateTime? ReviewedAt { get; set; }
    public bool IsActive { get; set; } = true;
    public int EstablishedYear { get; set; }
    public string? Type { get; set; } // Public, Private, etc.
    public decimal? Ranking { get; set; }

    // Navigation properties
    public Country Country { get; set; } = null!;
    public Address? Address { get; set; }
    public User? ReviewedByUser { get; set; }
    public ICollection<Student> Students { get; private set; } = new List<Student>();
    public ICollection<AcademicProgram> AcademicPrograms { get; private set; } = new List<AcademicProgram>();
    public ICollection<UniversityContact> Contacts { get; private set; } = new List<UniversityContact>();
    public ICollection<UniversityAddress> Addresses { get; private set; } = new List<UniversityAddress>();
    public ICollection<AcademicCalendar> AcademicCalendars { get; private set; } = new List<AcademicCalendar>();
}
