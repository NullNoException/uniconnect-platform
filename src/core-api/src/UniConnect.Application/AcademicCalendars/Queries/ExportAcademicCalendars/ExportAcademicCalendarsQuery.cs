using MediatR;
using Microsoft.EntityFrameworkCore;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Queries.ExportAcademicCalendars;

public record ExportAcademicCalendarsQuery(Guid UniversityId) : IRequest<byte[]>;

public class ExportAcademicCalendarsQueryHandler : IRequestHandler<ExportAcademicCalendarsQuery, byte[]>
{
    private readonly IApplicationDbContext _context;

    public ExportAcademicCalendarsQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<byte[]> Handle(ExportAcademicCalendarsQuery request, CancellationToken cancellationToken)
    {
        // Verify university exists
        var university = await _context.Universities
            .FirstOrDefaultAsync(u => u.Id == request.UniversityId, cancellationToken);

        if (university == null)
        {
            throw new NotFoundException(nameof(University), request.UniversityId);
        }

        // Get data for export
        var academicCalendars = await _context.AcademicCalendars
            .Where(ac => ac.UniversityId == request.UniversityId)
            .OrderBy(ac => ac.CreatedAt)
            .ToListAsync(cancellationToken);

        var academicYears = await _context.AcademicYears
            .Include(ay => ay.AcademicCalendar)
            .Where(ay => ay.AcademicCalendar.UniversityId == request.UniversityId)
            .OrderBy(ay => ay.AcademicCalendar.Name)
            .ThenBy(ay => ay.Year)
            .ToListAsync(cancellationToken);

        var semesters = await _context.Semesters
            .Include(s => s.AcademicYear)
            .ThenInclude(ay => ay.AcademicCalendar)
            .Where(s => s.AcademicYear.AcademicCalendar.UniversityId == request.UniversityId)
            .OrderBy(s => s.AcademicYear.AcademicCalendar.Name)
            .ThenBy(s => s.AcademicYear.Year)
            .ThenBy(s => s.Order)
            .ToListAsync(cancellationToken);

        var deadlines = await _context.Deadlines
            .Include(d => d.Semester)
            .ThenInclude(s => s.AcademicYear)
            .Where(d => d.Semester.AcademicYear.AcademicCalendar.UniversityId == request.UniversityId)
            .OrderBy(d => d.Semester.AcademicYear.AcademicCalendar.Name)
            .ThenBy(d => d.Semester.AcademicYear.Year)
            .ThenBy(d => d.Semester.Order)
            .ThenBy(d => d.Date)
            .ToListAsync(cancellationToken);

        // Create Excel workbook
        var workbook = new XSSFWorkbook();

        // Create Academic Calendars sheet
        var calendarSheet = workbook.CreateSheet("AcademicCalendars");
        var calendarHeader = calendarSheet.CreateRow(0);
        calendarHeader.CreateCell(0).SetCellValue("Name");
        calendarHeader.CreateCell(1).SetCellValue("Description");
        calendarHeader.CreateCell(2).SetCellValue("Start Date");
        calendarHeader.CreateCell(3).SetCellValue("End Date");
        calendarHeader.CreateCell(4).SetCellValue("Is Active");

        for (int i = 0; i < academicCalendars.Count; i++)
        {
            var calendar = academicCalendars[i];
            var row = calendarSheet.CreateRow(i + 1);
            row.CreateCell(0).SetCellValue(calendar.Name);
            row.CreateCell(1).SetCellValue(calendar.Description ?? string.Empty);

            var startDateCell = row.CreateCell(2);
            startDateCell.SetCellValue(calendar.StartDate);
            var endDateCell = row.CreateCell(3);
            endDateCell.SetCellValue(calendar.EndDate);

            row.CreateCell(4).SetCellValue(calendar.IsActive);
        }

        // Create Academic Years sheet
        var yearSheet = workbook.CreateSheet("AcademicYears");
        var yearHeader = yearSheet.CreateRow(0);
        yearHeader.CreateCell(0).SetCellValue("Academic Calendar");
        yearHeader.CreateCell(1).SetCellValue("Name");
        yearHeader.CreateCell(2).SetCellValue("Description");
        yearHeader.CreateCell(3).SetCellValue("Start Date");
        yearHeader.CreateCell(4).SetCellValue("End Date");
        yearHeader.CreateCell(5).SetCellValue("Year");
        yearHeader.CreateCell(6).SetCellValue("Is Active");

        for (int i = 0; i < academicYears.Count; i++)
        {
            var year = academicYears[i];
            var row = yearSheet.CreateRow(i + 1);
            row.CreateCell(0).SetCellValue(year.AcademicCalendar.Name);
            row.CreateCell(1).SetCellValue(year.Name);
            row.CreateCell(2).SetCellValue(year.Description ?? string.Empty);

            var startDateCell = row.CreateCell(3);
            startDateCell.SetCellValue(year.StartDate);
            var endDateCell = row.CreateCell(4);
            endDateCell.SetCellValue(year.EndDate);

            row.CreateCell(5).SetCellValue(year.Year);
            row.CreateCell(6).SetCellValue(year.IsActive);
        }

        // Create Semesters sheet
        var semesterSheet = workbook.CreateSheet("Semesters");
        var semesterHeader = semesterSheet.CreateRow(0);
        semesterHeader.CreateCell(0).SetCellValue("Academic Year");
        semesterHeader.CreateCell(1).SetCellValue("Academic Calendar");
        semesterHeader.CreateCell(2).SetCellValue("Name");
        semesterHeader.CreateCell(3).SetCellValue("Code");
        semesterHeader.CreateCell(4).SetCellValue("Description");
        semesterHeader.CreateCell(5).SetCellValue("Start Date");
        semesterHeader.CreateCell(6).SetCellValue("End Date");
        semesterHeader.CreateCell(7).SetCellValue("Status");
        semesterHeader.CreateCell(8).SetCellValue("Order");

        for (int i = 0; i < semesters.Count; i++)
        {
            var semester = semesters[i];
            var row = semesterSheet.CreateRow(i + 1);
            row.CreateCell(0).SetCellValue(semester.AcademicYear.Name);
            row.CreateCell(1).SetCellValue(semester.AcademicYear.AcademicCalendar.Name);
            row.CreateCell(2).SetCellValue(semester.Name);
            row.CreateCell(3).SetCellValue(semester.Code);
            row.CreateCell(4).SetCellValue(semester.Description ?? string.Empty);

            var startDateCell = row.CreateCell(5);
            startDateCell.SetCellValue(semester.StartDate);
            var endDateCell = row.CreateCell(6);
            endDateCell.SetCellValue(semester.EndDate);

            row.CreateCell(7).SetCellValue(semester.Status.ToString());
            row.CreateCell(8).SetCellValue(semester.Order);
        }

        // Create Deadlines sheet
        var deadlineSheet = workbook.CreateSheet("Deadlines");
        var deadlineHeader = deadlineSheet.CreateRow(0);
        deadlineHeader.CreateCell(0).SetCellValue("Semester Code");
        deadlineHeader.CreateCell(1).SetCellValue("Academic Year");
        deadlineHeader.CreateCell(2).SetCellValue("Name");
        deadlineHeader.CreateCell(3).SetCellValue("Description");
        deadlineHeader.CreateCell(4).SetCellValue("Date");
        deadlineHeader.CreateCell(5).SetCellValue("Type");
        deadlineHeader.CreateCell(6).SetCellValue("Is Active");
        deadlineHeader.CreateCell(7).SetCellValue("Send Reminder");
        deadlineHeader.CreateCell(8).SetCellValue("Reminder Days Before");

        for (int i = 0; i < deadlines.Count; i++)
        {
            var deadline = deadlines[i];
            var row = deadlineSheet.CreateRow(i + 1);
            row.CreateCell(0).SetCellValue(deadline.Semester.Code);
            row.CreateCell(1).SetCellValue(deadline.Semester.AcademicYear.Name);
            row.CreateCell(2).SetCellValue(deadline.Name);
            row.CreateCell(3).SetCellValue(deadline.Description ?? string.Empty);

            var dateCell = row.CreateCell(4);
            dateCell.SetCellValue(deadline.Date);

            row.CreateCell(5).SetCellValue(deadline.Type.ToString());
            row.CreateCell(6).SetCellValue(deadline.IsActive);
            row.CreateCell(7).SetCellValue(deadline.SendReminder);

            if (deadline.ReminderDaysBefore.HasValue)
            {
                row.CreateCell(8).SetCellValue(deadline.ReminderDaysBefore.Value);
            }
        }

        // Auto-size columns
        for (int i = 0; i < 9; i++)
        {
            calendarSheet.AutoSizeColumn(i);
            yearSheet.AutoSizeColumn(i);
            semesterSheet.AutoSizeColumn(i);
            deadlineSheet.AutoSizeColumn(i);
        }

        // Save to memory stream
        using (var memoryStream = new MemoryStream())
        {
            workbook.Write(memoryStream);
            return memoryStream.ToArray();
        }
    }
}
