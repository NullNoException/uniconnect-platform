using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Common.Mappings;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Queries.GetAcademicYearsByCalendarId;

public record GetAcademicYearsByCalendarIdQuery(Guid CalendarId, GetAcademicYearsByCalendarIdRequest Request)
    : IRequest<PaginatedList<AcademicYearDto>>;

public class GetAcademicYearsByCalendarIdQueryHandler
    : IRequestHandler<GetAcademicYearsByCalendarIdQuery, PaginatedList<AcademicYearDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetAcademicYearsByCalendarIdQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<PaginatedList<AcademicYearDto>> Handle(
        GetAcademicYearsByCalendarIdQuery request, CancellationToken cancellationToken)
    {
        // Verify academic calendar exists
        var academicCalendar = await _context.AcademicCalendars
            .FirstOrDefaultAsync(ac => ac.Id == request.CalendarId, cancellationToken);

        if (academicCalendar == null)
        {
            throw new NotFoundException(nameof(AcademicCalendar), request.CalendarId);
        }

        var query = _context.AcademicYears
            .Include(ay => ay.AcademicCalendar)
            .Where(ay => ay.AcademicCalendarId == request.CalendarId)
            .AsQueryable();

        // Apply filters
        if (request.Request.IsActive.HasValue)
        {
            query = query.Where(ay => ay.IsActive == request.Request.IsActive.Value);
        }

        if (request.Request.Year.HasValue)
        {
            query = query.Where(ay => ay.Year == request.Request.Year.Value);
        }

        if (!string.IsNullOrWhiteSpace(request.Request.SearchTerm))
        {
            var searchTerm = request.Request.SearchTerm.ToLower();
            query = query.Where(ay => ay.Name.ToLower().Contains(searchTerm) ||
                                    (ay.Description != null && ay.Description.ToLower().Contains(searchTerm)));
        }

        // Apply ordering
        query = request.Request.OrderBy?.ToLower() switch
        {
            "name_asc" => query.OrderBy(ay => ay.Name),
            "name_desc" => query.OrderByDescending(ay => ay.Name),
            "year_asc" => query.OrderBy(ay => ay.Year),
            "year_desc" => query.OrderByDescending(ay => ay.Year),
            "startdate_asc" => query.OrderBy(ay => ay.StartDate),
            "startdate_desc" => query.OrderByDescending(ay => ay.StartDate),
            "createdat_asc" => query.OrderBy(ay => ay.CreatedAt),
            "createdat_desc" => query.OrderByDescending(ay => ay.CreatedAt),
            _ => query.OrderBy(ay => ay.Year).ThenBy(ay => ay.StartDate) // Default sorting
        };

        var academicYears = await query
            .ProjectTo<AcademicYearDto>(_mapper.ConfigurationProvider)
            .PaginatedListAsync(request.Request.PageNumber, request.Request.PageSize, cancellationToken);

        // Set academic calendar name
        foreach (var year in academicYears.Items)
        {
            year.AcademicCalendarName = academicCalendar.Name;
        }

        return academicYears;
    }
}
