using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.DTOs;

public class DeadlineDto : IMapFrom<Deadline>
{
    public Guid Id { get; set; }
    public Guid SemesterId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime Date { get; set; }
    public DeadlineType Type { get; set; }
    public string TypeName => Type.ToString();
    public bool IsActive { get; set; }
    public bool SendReminder { get; set; }
    public int? ReminderDaysBefore { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public string SemesterName { get; set; } = string.Empty;
}
