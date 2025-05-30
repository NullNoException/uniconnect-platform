using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterPrograms;

public class UpdateSemesterProgramsRequest
{
    [Required]
    public Guid SemesterId { get; set; }

    [Required]
    public List<SemesterProgramRequest> Programs { get; set; } = new List<SemesterProgramRequest>();
}

public class SemesterProgramRequest
{
    [Required]
    public Guid ProgramId { get; set; }

    public bool IsActive { get; set; } = true;

    public bool RemoveFromSemester { get; set; } = false;
}
