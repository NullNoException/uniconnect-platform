using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.DTOs;

public class AcademicYearDto : IMapFrom<AcademicYear>
{
    public Guid Id { get; set; }
    public Guid AcademicCalendarId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public bool IsActive { get; set; }
    public int Year { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public string AcademicCalendarName { get; set; } = string.Empty;
}
