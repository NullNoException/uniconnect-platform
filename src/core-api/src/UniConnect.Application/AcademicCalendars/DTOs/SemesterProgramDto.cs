using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.DTOs;

public class SemesterProgramDto : IMapFrom<SemesterProgram>
{
    public Guid Id { get; set; }
    public Guid SemesterId { get; set; }
    public Guid AcademicProgramId { get; set; }
    public bool IsActive { get; set; }
    public int AvailableSeats { get; set; }
    public string? Notes { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public string SemesterName { get; set; } = string.Empty;
    public string ProgramName { get; set; } = string.Empty;
    public string ProgramCode { get; set; } = string.Empty;
    public string AcademicLevelName { get; set; } = string.Empty;
    public string? MajorName { get; set; }
    public decimal? TuitionFee { get; set; }
    public string? CurrencyCode { get; set; }
}
