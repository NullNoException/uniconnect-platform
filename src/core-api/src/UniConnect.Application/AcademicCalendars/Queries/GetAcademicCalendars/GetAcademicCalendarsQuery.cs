using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Mappings;
using UniConnect.Application.Common.Models;

namespace UniConnect.Application.AcademicCalendars.Queries.GetAcademicCalendars;

public record GetAcademicCalendarsQuery(GetAcademicCalendarsRequest Request) : IRequest<PaginatedList<AcademicCalendarDto>>;

public class GetAcademicCalendarsQueryHandler : IRequestHandler<GetAcademicCalendarsQuery, PaginatedList<AcademicCalendarDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetAcademicCalendarsQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<PaginatedList<AcademicCalendarDto>> Handle(GetAcademicCalendarsQuery request, CancellationToken cancellationToken)
    {
        var query = _context.AcademicCalendars
            .Include(ac => ac.University)
            .AsQueryable();

        // Apply filters
        if (request.Request.UniversityId.HasValue)
        {
            query = query.Where(ac => ac.UniversityId == request.Request.UniversityId.Value);
        }

        if (request.Request.IsActive.HasValue)
        {
            query = query.Where(ac => ac.IsActive == request.Request.IsActive.Value);
        }

        if (!string.IsNullOrWhiteSpace(request.Request.SearchTerm))
        {
            var searchTerm = request.Request.SearchTerm.ToLower();
            query = query.Where(ac => ac.Name.ToLower().Contains(searchTerm) ||
                                     (ac.Description != null && ac.Description.ToLower().Contains(searchTerm)));
        }

        // Apply ordering
        query = request.Request.OrderBy?.ToLower() switch
        {
            "name_asc" => query.OrderBy(ac => ac.Name),
            "name_desc" => query.OrderByDescending(ac => ac.Name),
            "startdate_asc" => query.OrderBy(ac => ac.StartDate),
            "startdate_desc" => query.OrderByDescending(ac => ac.StartDate),
            "createdat_asc" => query.OrderBy(ac => ac.CreatedAt),
            "createdat_desc" => query.OrderByDescending(ac => ac.CreatedAt),
            _ => query.OrderByDescending(ac => ac.CreatedAt) // Default sorting
        };

        var academicCalendars = await query
            .ProjectTo<AcademicCalendarDto>(_mapper.ConfigurationProvider)
            .PaginatedListAsync(request.Request.PageNumber, request.Request.PageSize, cancellationToken);

        // Set university names (projection might not handle this well)
        foreach (var calendar in academicCalendars.Items)
        {
            var university = await _context.Universities.FirstOrDefaultAsync(u => u.Id == calendar.UniversityId, cancellationToken);
            if (university != null)
            {
                calendar.UniversityName = university.Name;
            }
        }

        return academicCalendars;
    }
}
