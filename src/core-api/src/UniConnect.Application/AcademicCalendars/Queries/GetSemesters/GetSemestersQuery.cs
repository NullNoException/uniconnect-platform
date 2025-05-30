using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Mappings;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Queries.GetSemesters;

public record GetSemestersQuery(GetSemestersRequest Request) : IRequest<PaginatedList<SemesterDto>>;

public class GetSemestersQueryHandler : IRequestHandler<GetSemestersQuery, PaginatedList<SemesterDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetSemestersQueryHandler(
        IApplicationDbContext context,
        IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<PaginatedList<SemesterDto>> Handle(GetSemestersQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Semesters
            .Include(s => s.AcademicYear)
            .ThenInclude(ay => ay.AcademicCalendar)
            .AsQueryable();

        // Apply filters
        if (request.Request.AcademicYearId.HasValue)
        {
            query = query.Where(s => s.AcademicYearId == request.Request.AcademicYearId.Value);
        }

        if (request.Request.AcademicCalendarId.HasValue)
        {
            query = query.Where(s => s.AcademicYear.AcademicCalendarId == request.Request.AcademicCalendarId.Value);
        }

        if (request.Request.UniversityId.HasValue)
        {
            query = query.Where(s => s.AcademicYear.AcademicCalendar.UniversityId == request.Request.UniversityId.Value);
        }

        if (request.Request.Status.HasValue)
        {
            query = query.Where(s => s.Status == request.Request.Status.Value);
        }

        if (request.Request.Current.HasValue && request.Request.Current.Value)
        {
            var today = DateTime.UtcNow.Date;
            query = query.Where(s => s.Status == SemesterStatus.Active ||
                                    (s.StartDate <= today && s.EndDate >= today));
        }

        // Include relationships based on request
        if (request.Request.IncludeDeadlines)
        {
            query = query.Include(s => s.Deadlines);
        }

        if (request.Request.IncludePrograms)
        {
            query = query.Include(s => s.AvailablePrograms);
        }

        // Order by academic year and then by semester order
        query = query.OrderBy(s => s.AcademicYear.StartDate)
                     .ThenBy(s => s.Order);

        // Project to DTO and paginate
        return await query
            .ProjectTo<SemesterDto>(_mapper.ConfigurationProvider)
            .PaginatedListAsync(request.Request.PageNumber, request.Request.PageSize);
    }
}
