namespace UniConnect.Application.AcademicCalendars.Queries.GetAcademicCalendars;

public class GetAcademicCalendarsRequest
{
    public Guid? UniversityId { get; set; }
    public bool? IsActive { get; set; }
    public string? SearchTerm { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? OrderBy { get; set; }
}
