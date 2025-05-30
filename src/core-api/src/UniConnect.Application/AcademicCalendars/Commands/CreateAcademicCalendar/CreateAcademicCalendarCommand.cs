using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Mappings;
using AutoMapper;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Commands.CreateAcademicCalendar;

public record CreateAcademicCalendarCommand(CreateAcademicCalendarRequest Request) : IRequest<AcademicCalendarDto>;

public class CreateAcademicCalendarCommandHandler : IRequestHandler<CreateAcademicCalendarCommand, AcademicCalendarDto>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public CreateAcademicCalendarCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<AcademicCalendarDto> Handle(CreateAcademicCalendarCommand request, CancellationToken cancellationToken)
    {
        // Verify university exists
        var university = await _context.Universities
            .FirstOrDefaultAsync(u => u.Id == request.Request.UniversityId, cancellationToken);

        if (university == null)
        {
            throw new NotFoundException(nameof(University), request.Request.UniversityId);
        }

        // Validate dates
        if (request.Request.StartDate >= request.Request.EndDate)
        {
            throw new ValidationException("EndDate", "End date must be after start date");
        }

        // Create academic calendar
        var academicCalendar = new AcademicCalendar
        {
            UniversityId = request.Request.UniversityId,
            Name = request.Request.Name,
            Description = request.Request.Description,
            IsActive = request.Request.IsActive,
            StartDate = request.Request.StartDate,
            EndDate = request.Request.EndDate,
            CreatedBy = _currentUserService.UserId,
            CreatedAt = DateTime.UtcNow
        };

        await _context.AcademicCalendars.AddAsync(academicCalendar, cancellationToken);
        await _context.SaveChangesAsync(cancellationToken);

        // Return DTO with university name
        var result = _mapper.Map<AcademicCalendarDto>(academicCalendar);
        result.UniversityName = university.Name;

        return result;
    }
}
