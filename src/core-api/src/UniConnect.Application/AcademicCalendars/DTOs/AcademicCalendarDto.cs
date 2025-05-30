using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.DTOs;

public class AcademicCalendarDto : IMapFrom<AcademicCalendar>
{
    public Guid Id { get; set; }
    public Guid UniversityId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public bool IsActive { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public string UniversityName { get; set; } = string.Empty;
}
