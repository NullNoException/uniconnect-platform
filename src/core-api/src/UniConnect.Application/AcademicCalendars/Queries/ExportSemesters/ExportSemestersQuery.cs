using MediatR;
using Microsoft.EntityFrameworkCore;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Queries.ExportSemesters;

public record ExportSemestersQuery(Guid? AcademicYearId = null, Guid? AcademicCalendarId = null) : IRequest<ExportSemestersResult>;

public class ExportSemestersQueryHandler : IRequestHandler<ExportSemestersQuery, ExportSemestersResult>
{
    private readonly IApplicationDbContext _context;
    private readonly IDateTime _dateTime;

    public ExportSemestersQueryHandler(IApplicationDbContext context, IDateTime dateTime)
    {
        _context = context;
        _dateTime = dateTime;
    }

    public async Task<ExportSemestersResult> Handle(ExportSemestersQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Semesters
            .Include(s => s.AcademicYear)
            .ThenInclude(ay => ay.AcademicCalendar)
            .ThenInclude(ac => ac.University)
            .Include(s => s.Deadlines)
            .Include(s => s.AvailablePrograms)
            .AsQueryable();

        // Apply filters
        if (request.AcademicYearId.HasValue)
        {
            query = query.Where(s => s.AcademicYearId == request.AcademicYearId.Value);
        }

        if (request.AcademicCalendarId.HasValue)
        {
            query = query.Where(s => s.AcademicYear.AcademicCalendarId == request.AcademicCalendarId.Value);
        }

        // Order by academic year, then by semester order
        var semesters = await query
            .OrderBy(s => s.AcademicYear.StartDate)
            .ThenBy(s => s.Order)
            .ToListAsync(cancellationToken);

        // Create Excel workbook
        var workbook = new XSSFWorkbook();
        var sheet = workbook.CreateSheet("Semesters");

        // Create header row
        var headerRow = sheet.CreateRow(0);
        var headers = new[]
        {
            "University", "Academic Calendar", "Academic Year", "Semester Name", "Semester Code",
            "Description", "Start Date", "End Date", "Status", "Order", "Programs Count", "Deadlines Count"
        };

        for (var i = 0; i < headers.Length; i++)
        {
            var cell = headerRow.CreateCell(i);
            cell.SetCellValue(headers[i]);

            // Apply styling to header
            var headerStyle = workbook.CreateCellStyle();
            var font = workbook.CreateFont();
            font.IsBold = true;
            headerStyle.SetFont(font);
            cell.CellStyle = headerStyle;
        }

        // Auto-size columns for header
        for (var i = 0; i < headers.Length; i++)
        {
            sheet.AutoSizeColumn(i);
        }

        // Add data rows
        var rowIndex = 1;
        foreach (var semester in semesters)
        {
            var row = sheet.CreateRow(rowIndex++);

            row.CreateCell(0).SetCellValue(semester.AcademicYear.AcademicCalendar.University.Name);
            row.CreateCell(1).SetCellValue(semester.AcademicYear.AcademicCalendar.Name);
            row.CreateCell(2).SetCellValue(semester.AcademicYear.Name);
            row.CreateCell(3).SetCellValue(semester.Name);
            row.CreateCell(4).SetCellValue(semester.Code);
            row.CreateCell(5).SetCellValue(semester.Description ?? string.Empty);

            // Format dates
            var dateStyle = workbook.CreateCellStyle();
            var format = workbook.CreateDataFormat();
            dateStyle.DataFormat = format.GetFormat("yyyy-mm-dd");

            var startDateCell = row.CreateCell(6);
            startDateCell.SetCellValue(semester.StartDate);
            startDateCell.CellStyle = dateStyle;

            var endDateCell = row.CreateCell(7);
            endDateCell.SetCellValue(semester.EndDate);
            endDateCell.CellStyle = dateStyle;

            row.CreateCell(8).SetCellValue(semester.Status.ToString());
            row.CreateCell(9).SetCellValue(semester.Order);
            row.CreateCell(10).SetCellValue(semester.AvailablePrograms.Count);
            row.CreateCell(11).SetCellValue(semester.Deadlines.Count);
        }

        // Auto-size columns for data
        for (var i = 0; i < headers.Length; i++)
        {
            sheet.AutoSizeColumn(i);
        }

        // Write to memory stream
        using var stream = new MemoryStream();
        workbook.Write(stream);
        stream.Position = 0;

        return new ExportSemestersResult
        {
            Content = stream.ToArray(),
            ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            FileName = $"Semesters_Export_{_dateTime.Now:yyyyMMdd_HHmmss}.xlsx"
        };
    }
}

public class ExportSemestersResult
{
    public byte[] Content { get; set; } = Array.Empty<byte>();
    public string ContentType { get; set; } = string.Empty;
    public string FileName { get; set; } = string.Empty;
}
