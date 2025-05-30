using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Commands.UpdateAcademicCalendar;

public record UpdateAcademicCalendarCommand(Guid Id, UpdateAcademicCalendarRequest Request) : IRequest<AcademicCalendarDto>;

public class UpdateAcademicCalendarCommandHandler : IRequestHandler<UpdateAcademicCalendarCommand, AcademicCalendarDto>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public UpdateAcademicCalendarCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<AcademicCalendarDto> Handle(UpdateAcademicCalendarCommand request, CancellationToken cancellationToken)
    {
        var academicCalendar = await _context.AcademicCalendars
            .Include(ac => ac.University)
            .FirstOrDefaultAsync(ac => ac.Id == request.Id, cancellationToken);

        if (academicCalendar == null)
        {
            throw new NotFoundException(nameof(AcademicCalendar), request.Id);
        }

        // Validate dates
        if (request.Request.StartDate >= request.Request.EndDate)
        {
            throw new ValidationException("EndDate", "End date must be after start date");
        }

        // Update properties
        academicCalendar.Name = request.Request.Name;
        academicCalendar.Description = request.Request.Description;
        academicCalendar.IsActive = request.Request.IsActive;
        academicCalendar.StartDate = request.Request.StartDate;
        academicCalendar.EndDate = request.Request.EndDate;
        academicCalendar.UpdatedBy = _currentUserService.UserId;
        academicCalendar.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync(cancellationToken);

        var result = _mapper.Map<AcademicCalendarDto>(academicCalendar);
        result.UniversityName = academicCalendar.University.Name;

        return result;
    }
}
