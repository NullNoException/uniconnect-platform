using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Queries.GetAcademicCalendarById;

public record GetAcademicCalendarByIdQuery(Guid Id) : IRequest<AcademicCalendarDto>;

public class GetAcademicCalendarByIdQueryHandler : IRequestHandler<GetAcademicCalendarByIdQuery, AcademicCalendarDto>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetAcademicCalendarByIdQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<AcademicCalendarDto> Handle(GetAcademicCalendarByIdQuery request, CancellationToken cancellationToken)
    {
        var academicCalendar = await _context.AcademicCalendars
            .Include(ac => ac.University)
            .Include(ac => ac.AcademicYears)
            .FirstOrDefaultAsync(ac => ac.Id == request.Id, cancellationToken);

        if (academicCalendar == null)
        {
            throw new NotFoundException(nameof(AcademicCalendar), request.Id);
        }

        var result = _mapper.Map<AcademicCalendarDto>(academicCalendar);
        result.UniversityName = academicCalendar.University.Name;

        return result;
    }
}
