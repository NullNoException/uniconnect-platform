using System.ComponentModel.DataAnnotations;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterDeadlines;

public class UpdateSemesterDeadlinesRequest
{
    [Required]
    public Guid SemesterId { get; set; }

    [Required]
    public List<DeadlineRequest> Deadlines { get; set; } = new List<DeadlineRequest>();
}

public class DeadlineRequest
{
    public Guid? Id { get; set; } // Null for new deadlines, provided for updates

    [Required]
    public string Name { get; set; } = string.Empty;

    [Required]
    public string Description { get; set; } = string.Empty;

    [Required]
    public DeadlineType Type { get; set; }

    [Required]
    public DateTime Date { get; set; }

    public bool DeleteExisting { get; set; } = false; // Set to true to delete an existing deadline
}
