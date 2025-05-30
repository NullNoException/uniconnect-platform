using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Commands.DeleteAcademicCalendar;

public record DeleteAcademicCalendarCommand(Guid Id) : IRequest<bool>;

public class DeleteAcademicCalendarCommandHandler : IRequestHandler<DeleteAcademicCalendarCommand, bool>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;

    public DeleteAcademicCalendarCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService)
    {
        _context = context;
        _currentUserService = currentUserService;
    }

    public async Task<bool> Handle(DeleteAcademicCalendarCommand request, CancellationToken cancellationToken)
    {
        var academicCalendar = await _context.AcademicCalendars
            .Include(ac => ac.AcademicYears)
            .FirstOrDefaultAsync(ac => ac.Id == request.Id, cancellationToken);

        if (academicCalendar == null)
        {
            throw new NotFoundException(nameof(AcademicCalendar), request.Id);
        }

        // Check if there are any academic years
        if (academicCalendar.AcademicYears.Any())
        {
            throw new ValidationException("HasRelatedData", $"Cannot delete academic calendar with ID {request.Id} because it has associated academic years.");
        }

        // Set as deleted (soft delete)
        academicCalendar.IsDeleted = true;
        academicCalendar.UpdatedBy = _currentUserService.UserId;
        academicCalendar.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync(cancellationToken);

        return true;
    }
}
