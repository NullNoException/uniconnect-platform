namespace UniConnect.Application.AcademicCalendars.Queries.GetAcademicYearsByCalendarId;

public class GetAcademicYearsByCalendarIdRequest
{
    public bool? IsActive { get; set; }
    public int? Year { get; set; }
    public string? SearchTerm { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? OrderBy { get; set; }
}
