using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Queries.GetSemesters;

public class GetSemestersRequest
{
    public Guid? AcademicYearId { get; set; }
    public Guid? AcademicCalendarId { get; set; }
    public Guid? UniversityId { get; set; }
    public SemesterStatus? Status { get; set; }
    public bool? Current { get; set; } // To get only the current semester(s)
    public bool IncludeDeadlines { get; set; } = false;
    public bool IncludePrograms { get; set; } = false;
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}
