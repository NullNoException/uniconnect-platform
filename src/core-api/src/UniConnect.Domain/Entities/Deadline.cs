using UniConnect.Domain.Common;
using UniConnect.Domain.Enums;

namespace UniConnect.Domain.Entities;

public class Deadline : BaseEntity
{
    public Guid SemesterId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime Date { get; set; }
    public DeadlineType Type { get; set; }
    public bool IsActive { get; set; } = true;
    public bool SendReminder { get; set; } = false;
    public int? ReminderDaysBefore { get; set; }

    // Navigation properties
    public Semester Semester { get; set; } = null!;
}
