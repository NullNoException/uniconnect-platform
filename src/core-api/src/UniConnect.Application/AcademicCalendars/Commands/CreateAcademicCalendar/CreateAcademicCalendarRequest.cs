using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.AcademicCalendars.Commands.CreateAcademicCalendar;

public class CreateAcademicCalendarRequest
{
    [Required]
    public Guid UniversityId { get; set; }

    [Required]
    [StringLength(256, MinimumLength = 2)]
    public string Name { get; set; } = string.Empty;

    [StringLength(2000)]
    public string? Description { get; set; }

    public bool IsActive { get; set; } = true;

    [Required]
    public DateTime StartDate { get; set; }

    [Required]
    public DateTime EndDate { get; set; }
}
