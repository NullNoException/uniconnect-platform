using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Queries.GetAllUniversities;

public class GetAllUniversitiesQueryHandler : IRequestHandler<GetAllUniversitiesQuery, UniversitySearchResponse>
{
    private readonly IApplicationDbContext _context;

    public GetAllUniversitiesQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<UniversitySearchResponse> Handle(GetAllUniversitiesQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Universities
            .Include(u => u.Country)
            .Include(u => u.AcademicPrograms.Where(p => !p.IsDeleted))
            .AsQueryable();

        if (!request.IncludeDeleted)
        {
            query = query.Where(u => !u.IsDeleted);
        }

        // Get total count
        var totalCount = await query.CountAsync(cancellationToken);

        // Apply pagination and projection
        var universities = await query
            .OrderBy(u => u.Name)
            .Skip((request.Page - 1) * request.PageSize)
            .Take(request.PageSize)
            .Select(u => new UniversitySummaryDto
            {
                Id = u.Id,
                Name = u.Name,
                CountryName = u.Country.CountryName,
                LogoUrl = u.LogoUrl,
                Status = u.Status,
                AccreditationStatus = u.AccreditationStatus,
                EstablishedYear = u.EstablishedYear,
                Type = u.Type,
                Ranking = u.Ranking,
                ProgramCount = u.AcademicPrograms.Count,
                CreatedAt = u.CreatedAt
            })
            .ToListAsync(cancellationToken);

        return new UniversitySearchResponse
        {
            Universities = universities,
            TotalCount = totalCount,
            Page = request.Page,
            PageSize = request.PageSize,
            TotalPages = (int)Math.Ceiling((double)totalCount / request.PageSize)
        };
    }
}
