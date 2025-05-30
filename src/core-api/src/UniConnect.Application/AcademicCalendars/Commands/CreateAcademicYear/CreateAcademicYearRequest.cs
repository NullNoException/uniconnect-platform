using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.AcademicCalendars.Commands.CreateAcademicYear;

public class CreateAcademicYearRequest
{
    [Required]
    public Guid AcademicCalendarId { get; set; }

    [Required]
    [StringLength(256, MinimumLength = 2)]
    public string Name { get; set; } = string.Empty;

    [StringLength(2000)]
    public string? Description { get; set; }

    [Required]
    public DateTime StartDate { get; set; }

    [Required]
    public DateTime EndDate { get; set; }

    public bool IsActive { get; set; } = true;

    [Required]
    [Range(1900, 2100)]
    public int Year { get; set; }
}
