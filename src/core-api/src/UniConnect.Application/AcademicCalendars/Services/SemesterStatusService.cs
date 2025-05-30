using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Services;

public class SemesterStatusService : ISemesterStatusService
{
    private readonly IApplicationDbContext _context;
    private readonly ILogger<SemesterStatusService> _logger;
    private readonly IDateTime _dateTime;

    public SemesterStatusService(
        IApplicationDbContext context,
        ILogger<SemesterStatusService> logger,
        IDateTime dateTime)
    {
        _context = context;
        _logger = logger;
        _dateTime = dateTime;
    }

    public async Task UpdateSemesterStatusesAsync(CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Starting automatic semester status update");

        var today = _dateTime.UtcNow.Date; // Use UTC dates for PostgreSQL compatibility
        int updatedCount = 0;

        try
        {
            // Get all semesters that need status updates
            var semestersToUpdate = await _context.Semesters
                .Where(s =>
                    // Upcoming semesters that should be Active
                    (s.Status == SemesterStatus.Upcoming && s.StartDate <= today && s.EndDate >= today) ||
                    // Active semesters that should be Inactive
                    (s.Status == SemesterStatus.Active && s.EndDate < today) ||
                    // Handle edge cases: any upcoming semester with end date in the past
                    (s.Status == SemesterStatus.Upcoming && s.EndDate < today))
                .ToListAsync(cancellationToken);

            foreach (var semester in semestersToUpdate)
            {
                SemesterStatus oldStatus = semester.Status;
                SemesterStatus newStatus;

                // Determine the new status based on dates
                if (semester.EndDate < today)
                {
                    newStatus = SemesterStatus.Inactive;
                }
                else if (semester.StartDate <= today && semester.EndDate >= today)
                {
                    newStatus = SemesterStatus.Active;
                }
                else
                {
                    // This shouldn't happen based on our query, but just in case
                    newStatus = semester.Status;
                }

                // Only update if status actually changed
                if (oldStatus != newStatus)
                {
                    semester.Status = newStatus;
                    semester.UpdatedAt = _dateTime.UtcNow; // Use UTC dates for PostgreSQL compatibility
                    semester.UpdatedBy = "System"; // Indicate automated update
                    updatedCount++;

                    _logger.LogInformation(
                        "Updated semester {SemesterId} status from {OldStatus} to {NewStatus}",
                        semester.Id, oldStatus, newStatus);
                }
            }

            // Save changes if any updates were made
            if (updatedCount > 0)
            {
                await _context.SaveChangesAsync(cancellationToken);
                _logger.LogInformation("Updated {Count} semester statuses", updatedCount);
            }
            else
            {
                _logger.LogInformation("No semester statuses needed updating");
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating semester statuses");
            throw;
        }

        return;
    }
}
