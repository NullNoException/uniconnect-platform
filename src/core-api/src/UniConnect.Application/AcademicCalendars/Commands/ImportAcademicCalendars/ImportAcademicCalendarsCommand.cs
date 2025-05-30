using System.Globalization;
using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Commands.ImportAcademicCalendars;

public record ImportAcademicCalendarsCommand(ImportAcademicCalendarsRequest Request) : IRequest<ImportResult>;

public class ImportAcademicCalendarsCommandHandler : IRequestHandler<ImportAcademicCalendarsCommand, ImportResult>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public ImportAcademicCalendarsCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<ImportResult> Handle(ImportAcademicCalendarsCommand request, CancellationToken cancellationToken)
    {
        var importResult = new ImportResult
        {
            TotalRecords = 0,
            SuccessCount = 0,
            ErrorCount = 0,
            Errors = new List<string>()
        };

        try
        {
            // Verify university exists
            var university = await _context.Universities
                .FirstOrDefaultAsync(u => u.Id == request.Request.UniversityId, cancellationToken);

            if (university == null)
            {
                throw new NotFoundException(nameof(University), request.Request.UniversityId);
            }

            using (var memoryStream = new MemoryStream(request.Request.FileContent))
            {
                IWorkbook workbook = new XSSFWorkbook(memoryStream);
                ISheet academicCalendarSheet = workbook.GetSheet("AcademicCalendars") ?? workbook.GetSheetAt(0);
                ISheet academicYearSheet = workbook.GetSheet("AcademicYears");
                ISheet semesterSheet = workbook.GetSheet("Semesters");
                ISheet deadlineSheet = workbook.GetSheet("Deadlines");

                if (academicCalendarSheet != null)
                {
                    var calendarImportResults = await ImportAcademicCalendars(academicCalendarSheet, university.Id, cancellationToken);
                    importResult.TotalRecords += calendarImportResults.TotalRecords;
                    importResult.SuccessCount += calendarImportResults.SuccessCount;
                    importResult.ErrorCount += calendarImportResults.ErrorCount;
                    importResult.Errors.AddRange(calendarImportResults.Errors);
                }
                else
                {
                    importResult.Errors.Add("AcademicCalendars sheet not found in the Excel file.");
                }

                if (academicYearSheet != null)
                {
                    var yearImportResults = await ImportAcademicYears(academicYearSheet, cancellationToken);
                    importResult.TotalRecords += yearImportResults.TotalRecords;
                    importResult.SuccessCount += yearImportResults.SuccessCount;
                    importResult.ErrorCount += yearImportResults.ErrorCount;
                    importResult.Errors.AddRange(yearImportResults.Errors);
                }

                if (semesterSheet != null)
                {
                    var semesterImportResults = await ImportSemesters(semesterSheet, cancellationToken);
                    importResult.TotalRecords += semesterImportResults.TotalRecords;
                    importResult.SuccessCount += semesterImportResults.SuccessCount;
                    importResult.ErrorCount += semesterImportResults.ErrorCount;
                    importResult.Errors.AddRange(semesterImportResults.Errors);
                }

                if (deadlineSheet != null)
                {
                    var deadlineImportResults = await ImportDeadlines(deadlineSheet, cancellationToken);
                    importResult.TotalRecords += deadlineImportResults.TotalRecords;
                    importResult.SuccessCount += deadlineImportResults.SuccessCount;
                    importResult.ErrorCount += deadlineImportResults.ErrorCount;
                    importResult.Errors.AddRange(deadlineImportResults.Errors);
                }
            }
        }
        catch (Exception ex)
        {
            importResult.ErrorCount++;
            importResult.Errors.Add($"Error processing import: {ex.Message}");
        }

        return importResult;
    }

    private async Task<ImportResult> ImportAcademicCalendars(ISheet sheet, Guid universityId, CancellationToken cancellationToken)
    {
        var result = new ImportResult
        {
            TotalRecords = 0,
            SuccessCount = 0,
            ErrorCount = 0,
            Errors = new List<string>()
        };

        // Skip header row
        for (int i = 1; i <= sheet.LastRowNum; i++)
        {
            var row = sheet.GetRow(i);
            if (row == null) continue;

            result.TotalRecords++;

            try
            {
                var name = row.GetCell(0)?.StringCellValue ?? string.Empty;
                var description = row.GetCell(1)?.StringCellValue;
                var startDateCell = row.GetCell(2);
                var endDateCell = row.GetCell(3);
                var isActiveCell = row.GetCell(4);

                if (string.IsNullOrWhiteSpace(name))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Name is required.");
                    continue;
                }

                if (startDateCell == null || endDateCell == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Start date and end date are required.");
                    continue;
                }

                DateTime startDate, endDate;

                if (!TryGetDateFromCell(startDateCell, out startDate))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid start date format.");
                    continue;
                }

                if (!TryGetDateFromCell(endDateCell, out endDate))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid end date format.");
                    continue;
                }

                if (startDate >= endDate)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: End date must be after start date.");
                    continue;
                }

                bool isActive = true;
                if (isActiveCell != null)
                {
                    if (isActiveCell.CellType == CellType.Boolean)
                    {
                        isActive = isActiveCell.BooleanCellValue;
                    }
                    else if (isActiveCell.CellType == CellType.String)
                    {
                        isActive = isActiveCell.StringCellValue.ToLower() == "true" ||
                                   isActiveCell.StringCellValue.ToLower() == "yes" ||
                                   isActiveCell.StringCellValue == "1";
                    }
                    else if (isActiveCell.CellType == CellType.Numeric)
                    {
                        isActive = isActiveCell.NumericCellValue > 0;
                    }
                }

                // Check if academic calendar with the same name already exists
                var existingCalendar = await _context.AcademicCalendars
                    .FirstOrDefaultAsync(ac => ac.UniversityId == universityId && ac.Name == name, cancellationToken);

                if (existingCalendar != null)
                {
                    // Update existing calendar
                    existingCalendar.Description = description;
                    existingCalendar.StartDate = startDate;
                    existingCalendar.EndDate = endDate;
                    existingCalendar.IsActive = isActive;
                    existingCalendar.UpdatedBy = _currentUserService.UserId;
                    existingCalendar.UpdatedAt = DateTime.UtcNow;
                }
                else
                {
                    // Create new calendar
                    var academicCalendar = new AcademicCalendar
                    {
                        UniversityId = universityId,
                        Name = name,
                        Description = description,
                        StartDate = startDate,
                        EndDate = endDate,
                        IsActive = isActive,
                        CreatedBy = _currentUserService.UserId,
                        CreatedAt = DateTime.UtcNow
                    };

                    await _context.AcademicCalendars.AddAsync(academicCalendar, cancellationToken);
                }

                result.SuccessCount++;
            }
            catch (Exception ex)
            {
                result.ErrorCount++;
                result.Errors.Add($"Row {i + 1}: {ex.Message}");
            }
        }

        await _context.SaveChangesAsync(cancellationToken);
        return result;
    }

    private async Task<ImportResult> ImportAcademicYears(ISheet sheet, CancellationToken cancellationToken)
    {
        var result = new ImportResult
        {
            TotalRecords = 0,
            SuccessCount = 0,
            ErrorCount = 0,
            Errors = new List<string>()
        };

        // Skip header row
        for (int i = 1; i <= sheet.LastRowNum; i++)
        {
            var row = sheet.GetRow(i);
            if (row == null) continue;

            result.TotalRecords++;

            try
            {
                var calendarName = row.GetCell(0)?.StringCellValue ?? string.Empty;
                var name = row.GetCell(1)?.StringCellValue ?? string.Empty;
                var description = row.GetCell(2)?.StringCellValue;
                var startDateCell = row.GetCell(3);
                var endDateCell = row.GetCell(4);
                var yearCell = row.GetCell(5);
                var isActiveCell = row.GetCell(6);

                if (string.IsNullOrWhiteSpace(calendarName) || string.IsNullOrWhiteSpace(name))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Calendar name and academic year name are required.");
                    continue;
                }

                // Find the academic calendar
                var academicCalendar = await _context.AcademicCalendars
                    .FirstOrDefaultAsync(ac => ac.Name == calendarName, cancellationToken);

                if (academicCalendar == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Academic calendar '{calendarName}' not found.");
                    continue;
                }

                if (startDateCell == null || endDateCell == null || yearCell == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Start date, end date, and year are required.");
                    continue;
                }

                DateTime startDate, endDate;

                if (!TryGetDateFromCell(startDateCell, out startDate))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid start date format.");
                    continue;
                }

                if (!TryGetDateFromCell(endDateCell, out endDate))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid end date format.");
                    continue;
                }

                if (startDate >= endDate)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: End date must be after start date.");
                    continue;
                }

                // Validate dates are within academic calendar range
                if (startDate < academicCalendar.StartDate || endDate > academicCalendar.EndDate)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Academic year dates must be within the academic calendar date range.");
                    continue;
                }

                int year;
                if (yearCell.CellType == CellType.Numeric)
                {
                    year = (int)yearCell.NumericCellValue;
                }
                else if (yearCell.CellType == CellType.String)
                {
                    if (!int.TryParse(yearCell.StringCellValue, out year))
                    {
                        result.ErrorCount++;
                        result.Errors.Add($"Row {i + 1}: Invalid year format.");
                        continue;
                    }
                }
                else
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid year format.");
                    continue;
                }

                bool isActive = true;
                if (isActiveCell != null)
                {
                    if (isActiveCell.CellType == CellType.Boolean)
                    {
                        isActive = isActiveCell.BooleanCellValue;
                    }
                    else if (isActiveCell.CellType == CellType.String)
                    {
                        isActive = isActiveCell.StringCellValue.ToLower() == "true" ||
                                   isActiveCell.StringCellValue.ToLower() == "yes" ||
                                   isActiveCell.StringCellValue == "1";
                    }
                    else if (isActiveCell.CellType == CellType.Numeric)
                    {
                        isActive = isActiveCell.NumericCellValue > 0;
                    }
                }

                // Check if academic year with the same name already exists for this calendar
                var existingYear = await _context.AcademicYears
                    .FirstOrDefaultAsync(ay => ay.AcademicCalendarId == academicCalendar.Id && ay.Name == name, cancellationToken);

                if (existingYear != null)
                {
                    // Update existing year
                    existingYear.Description = description;
                    existingYear.StartDate = startDate;
                    existingYear.EndDate = endDate;
                    existingYear.Year = year;
                    existingYear.IsActive = isActive;
                    existingYear.UpdatedBy = _currentUserService.UserId;
                    existingYear.UpdatedAt = DateTime.UtcNow;
                }
                else
                {
                    // Create new academic year
                    var academicYear = new AcademicYear
                    {
                        AcademicCalendarId = academicCalendar.Id,
                        Name = name,
                        Description = description,
                        StartDate = startDate,
                        EndDate = endDate,
                        Year = year,
                        IsActive = isActive,
                        CreatedBy = _currentUserService.UserId,
                        CreatedAt = DateTime.UtcNow
                    };

                    await _context.AcademicYears.AddAsync(academicYear, cancellationToken);
                }

                result.SuccessCount++;
            }
            catch (Exception ex)
            {
                result.ErrorCount++;
                result.Errors.Add($"Row {i + 1}: {ex.Message}");
            }
        }

        await _context.SaveChangesAsync(cancellationToken);
        return result;
    }

    private async Task<ImportResult> ImportSemesters(ISheet sheet, CancellationToken cancellationToken)
    {
        var result = new ImportResult
        {
            TotalRecords = 0,
            SuccessCount = 0,
            ErrorCount = 0,
            Errors = new List<string>()
        };

        // Skip header row
        for (int i = 1; i <= sheet.LastRowNum; i++)
        {
            var row = sheet.GetRow(i);
            if (row == null) continue;

            result.TotalRecords++;

            try
            {
                var yearName = row.GetCell(0)?.StringCellValue ?? string.Empty;
                var calendarName = row.GetCell(1)?.StringCellValue ?? string.Empty;
                var name = row.GetCell(2)?.StringCellValue ?? string.Empty;
                var code = row.GetCell(3)?.StringCellValue ?? string.Empty;
                var description = row.GetCell(4)?.StringCellValue;
                var startDateCell = row.GetCell(5);
                var endDateCell = row.GetCell(6);
                var statusCell = row.GetCell(7);
                var orderCell = row.GetCell(8);

                if (string.IsNullOrWhiteSpace(yearName) || string.IsNullOrWhiteSpace(calendarName) ||
                    string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(code))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Academic year name, calendar name, semester name, and code are required.");
                    continue;
                }

                // Find the academic calendar
                var academicCalendar = await _context.AcademicCalendars
                    .FirstOrDefaultAsync(ac => ac.Name == calendarName, cancellationToken);

                if (academicCalendar == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Academic calendar '{calendarName}' not found.");
                    continue;
                }

                // Find the academic year
                var academicYear = await _context.AcademicYears
                    .FirstOrDefaultAsync(ay => ay.AcademicCalendarId == academicCalendar.Id && ay.Name == yearName, cancellationToken);

                if (academicYear == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Academic year '{yearName}' not found for calendar '{calendarName}'.");
                    continue;
                }

                if (startDateCell == null || endDateCell == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Start date and end date are required.");
                    continue;
                }

                DateTime startDate, endDate;

                if (!TryGetDateFromCell(startDateCell, out startDate))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid start date format.");
                    continue;
                }

                if (!TryGetDateFromCell(endDateCell, out endDate))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid end date format.");
                    continue;
                }

                if (startDate >= endDate)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: End date must be after start date.");
                    continue;
                }

                // Validate dates are within academic year range
                if (startDate < academicYear.StartDate || endDate > academicYear.EndDate)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Semester dates must be within the academic year date range.");
                    continue;
                }

                // Parse status
                SemesterStatus status = SemesterStatus.Upcoming;
                if (statusCell != null)
                {
                    if (statusCell.CellType == CellType.String)
                    {
                        var statusString = statusCell.StringCellValue.Trim();
                        if (Enum.TryParse<SemesterStatus>(statusString, true, out var parsedStatus))
                        {
                            status = parsedStatus;
                        }
                        else
                        {
                            result.ErrorCount++;
                            result.Errors.Add($"Row {i + 1}: Invalid status value. Valid values are: Upcoming, Active, Inactive, Archived.");
                            continue;
                        }
                    }
                    else if (statusCell.CellType == CellType.Numeric)
                    {
                        var statusInt = (int)statusCell.NumericCellValue;
                        if (Enum.IsDefined(typeof(SemesterStatus), statusInt))
                        {
                            status = (SemesterStatus)statusInt;
                        }
                        else
                        {
                            result.ErrorCount++;
                            result.Errors.Add($"Row {i + 1}: Invalid status value. Valid values are: 1 (Upcoming), 2 (Active), 3 (Inactive), 4 (Archived).");
                            continue;
                        }
                    }
                }

                // Parse order
                int order = 1;
                if (orderCell != null)
                {
                    if (orderCell.CellType == CellType.Numeric)
                    {
                        order = (int)orderCell.NumericCellValue;
                    }
                    else if (orderCell.CellType == CellType.String)
                    {
                        if (!int.TryParse(orderCell.StringCellValue, out order))
                        {
                            result.ErrorCount++;
                            result.Errors.Add($"Row {i + 1}: Invalid order format.");
                            continue;
                        }
                    }
                }

                // Check if semester with the same code already exists for this academic year
                var existingSemester = await _context.Semesters
                    .FirstOrDefaultAsync(s => s.AcademicYearId == academicYear.Id && s.Code == code, cancellationToken);

                if (existingSemester != null)
                {
                    // Update existing semester
                    existingSemester.Name = name;
                    existingSemester.Description = description;
                    existingSemester.StartDate = startDate;
                    existingSemester.EndDate = endDate;
                    existingSemester.Status = status;
                    existingSemester.Order = order;
                    existingSemester.UpdatedBy = _currentUserService.UserId;
                    existingSemester.UpdatedAt = DateTime.UtcNow;
                }
                else
                {
                    // Create new semester
                    var semester = new Semester
                    {
                        AcademicYearId = academicYear.Id,
                        Name = name,
                        Code = code,
                        Description = description,
                        StartDate = startDate,
                        EndDate = endDate,
                        Status = status,
                        Order = order,
                        CreatedBy = _currentUserService.UserId,
                        CreatedAt = DateTime.UtcNow
                    };

                    await _context.Semesters.AddAsync(semester, cancellationToken);
                }

                result.SuccessCount++;
            }
            catch (Exception ex)
            {
                result.ErrorCount++;
                result.Errors.Add($"Row {i + 1}: {ex.Message}");
            }
        }

        await _context.SaveChangesAsync(cancellationToken);
        return result;
    }

    private async Task<ImportResult> ImportDeadlines(ISheet sheet, CancellationToken cancellationToken)
    {
        var result = new ImportResult
        {
            TotalRecords = 0,
            SuccessCount = 0,
            ErrorCount = 0,
            Errors = new List<string>()
        };

        // Skip header row
        for (int i = 1; i <= sheet.LastRowNum; i++)
        {
            var row = sheet.GetRow(i);
            if (row == null) continue;

            result.TotalRecords++;

            try
            {
                var semesterCode = row.GetCell(0)?.StringCellValue ?? string.Empty;
                var yearName = row.GetCell(1)?.StringCellValue ?? string.Empty;
                var name = row.GetCell(2)?.StringCellValue ?? string.Empty;
                var description = row.GetCell(3)?.StringCellValue;
                var dateCell = row.GetCell(4);
                var typeCell = row.GetCell(5);
                var isActiveCell = row.GetCell(6);
                var sendReminderCell = row.GetCell(7);
                var reminderDaysBeforeCell = row.GetCell(8);

                if (string.IsNullOrWhiteSpace(semesterCode) || string.IsNullOrWhiteSpace(yearName) || string.IsNullOrWhiteSpace(name))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Semester code, academic year name, and deadline name are required.");
                    continue;
                }

                // Find the semester
                var semester = await _context.Semesters
                    .Include(s => s.AcademicYear)
                    .FirstOrDefaultAsync(s => s.Code == semesterCode && s.AcademicYear.Name == yearName, cancellationToken);

                if (semester == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Semester with code '{semesterCode}' not found for academic year '{yearName}'.");
                    continue;
                }

                if (dateCell == null)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Date is required.");
                    continue;
                }

                DateTime date;

                if (!TryGetDateFromCell(dateCell, out date))
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Invalid date format.");
                    continue;
                }

                // Validate date is within semester range
                if (date < semester.StartDate || date > semester.EndDate)
                {
                    result.ErrorCount++;
                    result.Errors.Add($"Row {i + 1}: Deadline date must be within the semester date range.");
                    continue;
                }

                // Parse deadline type
                DeadlineType type = DeadlineType.Custom;
                if (typeCell != null)
                {
                    if (typeCell.CellType == CellType.String)
                    {
                        var typeString = typeCell.StringCellValue.Trim();
                        if (Enum.TryParse<DeadlineType>(typeString, true, out var parsedType))
                        {
                            type = parsedType;
                        }
                        else
                        {
                            result.ErrorCount++;
                            result.Errors.Add($"Row {i + 1}: Invalid deadline type value.");
                            continue;
                        }
                    }
                    else if (typeCell.CellType == CellType.Numeric)
                    {
                        var typeInt = (int)typeCell.NumericCellValue;
                        if (Enum.IsDefined(typeof(DeadlineType), typeInt))
                        {
                            type = (DeadlineType)typeInt;
                        }
                        else
                        {
                            result.ErrorCount++;
                            result.Errors.Add($"Row {i + 1}: Invalid deadline type value.");
                            continue;
                        }
                    }
                }

                bool isActive = true;
                if (isActiveCell != null)
                {
                    if (isActiveCell.CellType == CellType.Boolean)
                    {
                        isActive = isActiveCell.BooleanCellValue;
                    }
                    else if (isActiveCell.CellType == CellType.String)
                    {
                        isActive = isActiveCell.StringCellValue.ToLower() == "true" ||
                                   isActiveCell.StringCellValue.ToLower() == "yes" ||
                                   isActiveCell.StringCellValue == "1";
                    }
                    else if (isActiveCell.CellType == CellType.Numeric)
                    {
                        isActive = isActiveCell.NumericCellValue > 0;
                    }
                }

                bool sendReminder = false;
                if (sendReminderCell != null)
                {
                    if (sendReminderCell.CellType == CellType.Boolean)
                    {
                        sendReminder = sendReminderCell.BooleanCellValue;
                    }
                    else if (sendReminderCell.CellType == CellType.String)
                    {
                        sendReminder = sendReminderCell.StringCellValue.ToLower() == "true" ||
                                      sendReminderCell.StringCellValue.ToLower() == "yes" ||
                                      sendReminderCell.StringCellValue == "1";
                    }
                    else if (sendReminderCell.CellType == CellType.Numeric)
                    {
                        sendReminder = sendReminderCell.NumericCellValue > 0;
                    }
                }

                int? reminderDaysBefore = null;
                if (reminderDaysBeforeCell != null && sendReminder)
                {
                    if (reminderDaysBeforeCell.CellType == CellType.Numeric)
                    {
                        reminderDaysBefore = (int)reminderDaysBeforeCell.NumericCellValue;
                    }
                    else if (reminderDaysBeforeCell.CellType == CellType.String)
                    {
                        int days;
                        if (int.TryParse(reminderDaysBeforeCell.StringCellValue, out days))
                        {
                            reminderDaysBefore = days;
                        }
                    }
                }

                // Check if deadline with the same name already exists for this semester
                var existingDeadline = await _context.Deadlines
                    .FirstOrDefaultAsync(d => d.SemesterId == semester.Id && d.Name == name, cancellationToken);

                if (existingDeadline != null)
                {
                    // Update existing deadline
                    existingDeadline.Description = description;
                    existingDeadline.Date = date;
                    existingDeadline.Type = type;
                    existingDeadline.IsActive = isActive;
                    existingDeadline.SendReminder = sendReminder;
                    existingDeadline.ReminderDaysBefore = reminderDaysBefore;
                    existingDeadline.UpdatedBy = _currentUserService.UserId;
                    existingDeadline.UpdatedAt = DateTime.UtcNow;
                }
                else
                {
                    // Create new deadline
                    var deadline = new Deadline
                    {
                        SemesterId = semester.Id,
                        Name = name,
                        Description = description,
                        Date = date,
                        Type = type,
                        IsActive = isActive,
                        SendReminder = sendReminder,
                        ReminderDaysBefore = reminderDaysBefore,
                        CreatedBy = _currentUserService.UserId,
                        CreatedAt = DateTime.UtcNow
                    };

                    await _context.Deadlines.AddAsync(deadline, cancellationToken);
                }

                result.SuccessCount++;
            }
            catch (Exception ex)
            {
                result.ErrorCount++;
                result.Errors.Add($"Row {i + 1}: {ex.Message}");
            }
        }

        await _context.SaveChangesAsync(cancellationToken);
        return result;
    }

    private bool TryGetDateFromCell(ICell cell, out DateTime date)
    {
        date = DateTime.MinValue;

        if (cell == null)
            return false;

        try
        {
            if (cell.CellType == CellType.Numeric && DateUtil.IsCellDateFormatted(cell))
            {
                date = cell.DateCellValue ?? DateTime.MinValue;
                return true;
            }
            else if (cell.CellType == CellType.String)
            {
                string dateStr = cell.StringCellValue.Trim();

                // Try different date formats
                string[] formats = new string[]
                {
                    "yyyy-MM-dd", "MM/dd/yyyy", "dd/MM/yyyy", "yyyy/MM/dd",
                    "dd-MM-yyyy", "MM-dd-yyyy", "yyyy.MM.dd", "dd.MM.yyyy", "MM.dd.yyyy"
                };

                if (DateTime.TryParseExact(dateStr, formats, CultureInfo.InvariantCulture,
                    DateTimeStyles.None, out date))
                {
                    return true;
                }

                if (DateTime.TryParse(dateStr, out date))
                {
                    return true;
                }
            }
        }
        catch
        {
            return false;
        }

        return false;
    }
}
