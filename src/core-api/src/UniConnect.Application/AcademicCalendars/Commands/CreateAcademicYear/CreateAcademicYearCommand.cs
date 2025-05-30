using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Commands.CreateAcademicYear;

public record CreateAcademicYearCommand(CreateAcademicYearRequest Request) : IRequest<AcademicYearDto>;

public class CreateAcademicYearCommandHandler : IRequestHandler<CreateAcademicYearCommand, AcademicYearDto>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public CreateAcademicYearCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<AcademicYearDto> Handle(CreateAcademicYearCommand request, CancellationToken cancellationToken)
    {
        // Verify academic calendar exists
        var academicCalendar = await _context.AcademicCalendars
            .FirstOrDefaultAsync(ac => ac.Id == request.Request.AcademicCalendarId, cancellationToken);

        if (academicCalendar == null)
        {
            throw new NotFoundException(nameof(AcademicCalendar), request.Request.AcademicCalendarId);
        }

        // Validate dates
        if (request.Request.StartDate >= request.Request.EndDate)
        {
            throw new ValidationException("EndDate", "End date must be after start date");
        }

        // Validate dates are within academic calendar range
        if (request.Request.StartDate < academicCalendar.StartDate || request.Request.EndDate > academicCalendar.EndDate)
        {
            throw new ValidationException("DateRange", "Academic year dates must be within the academic calendar date range");
        }

        // Create academic year
        var academicYear = new AcademicYear
        {
            AcademicCalendarId = request.Request.AcademicCalendarId,
            Name = request.Request.Name,
            Description = request.Request.Description,
            StartDate = request.Request.StartDate,
            EndDate = request.Request.EndDate,
            IsActive = request.Request.IsActive,
            Year = request.Request.Year,
            CreatedBy = _currentUserService.UserId,
            CreatedAt = DateTime.UtcNow
        };

        await _context.AcademicYears.AddAsync(academicYear, cancellationToken);
        await _context.SaveChangesAsync(cancellationToken);

        // Return DTO with academic calendar name
        var result = _mapper.Map<AcademicYearDto>(academicYear);
        result.AcademicCalendarName = academicCalendar.Name;

        return result;
    }
}
