using System.ComponentModel.DataAnnotations;

namespace UniConnect.Application.AcademicCalendars.Commands.ImportAcademicCalendars;

public class ImportAcademicCalendarsRequest
{
    [Required]
    public Guid UniversityId { get; set; }

    [Required]
    public byte[] FileContent { get; set; } = Array.Empty<byte>();
}
