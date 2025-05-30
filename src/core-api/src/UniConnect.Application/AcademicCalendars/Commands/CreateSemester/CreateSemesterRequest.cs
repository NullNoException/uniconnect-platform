using System.ComponentModel.DataAnnotations;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Commands.CreateSemester;

public class CreateSemesterRequest
{
    [Required]
    public Guid AcademicYearId { get; set; }

    [Required]
    [StringLength(256, MinimumLength = 2)]
    public string Name { get; set; } = string.Empty;

    [Required]
    [StringLength(50, MinimumLength = 1)]
    public string Code { get; set; } = string.Empty;

    [StringLength(2000)]
    public string? Description { get; set; }

    [Required]
    public DateTime StartDate { get; set; }

    [Required]
    public DateTime EndDate { get; set; }

    public SemesterStatus Status { get; set; } = SemesterStatus.Upcoming;

    [Required]
    public int Order { get; set; }
}
