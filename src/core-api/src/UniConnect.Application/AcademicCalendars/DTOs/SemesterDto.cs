using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.DTOs;

public class SemesterDto : IMapFrom<Semester>
{
    public Guid Id { get; set; }
    public Guid AcademicYearId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public SemesterStatus Status { get; set; }
    public string StatusName => Status.ToString();
    public int Order { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public string AcademicYearName { get; set; } = string.Empty;
    public List<DeadlineDto> Deadlines { get; set; } = new List<DeadlineDto>();
    public List<SemesterProgramDto> Programs { get; set; } = new List<SemesterProgramDto>();
}
