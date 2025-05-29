using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Queries.SearchUniversities;

public class SearchUniversitiesQueryHandler : IRequestHandler<SearchUniversitiesQuery, UniversitySearchResponse>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public SearchUniversitiesQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<UniversitySearchResponse> Handle(SearchUniversitiesQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Universities
            .Include(u => u.Country)
            .Include(u => u.AcademicPrograms.Where(p => !p.IsDeleted))
            .Where(u => !u.IsDeleted);

        // Apply filters
        if (!string.IsNullOrEmpty(request.Request.Name))
        {
            query = query.Where(u => u.Name.Contains(request.Request.Name));
        }

        if (request.Request.CountryId.HasValue)
        {
            query = query.Where(u => u.CountryId == request.Request.CountryId.Value);
        }

        if (request.Request.Status.HasValue)
        {
            query = query.Where(u => u.Status == request.Request.Status.Value);
        }

        if (request.Request.AccreditationStatus.HasValue)
        {
            query = query.Where(u => u.AccreditationStatus == request.Request.AccreditationStatus.Value);
        }

        if (!string.IsNullOrEmpty(request.Request.Type))
        {
            query = query.Where(u => u.Type != null && u.Type.Contains(request.Request.Type));
        }

        if (request.Request.EstablishedYearFrom.HasValue)
        {
            query = query.Where(u => u.EstablishedYear >= request.Request.EstablishedYearFrom.Value);
        }

        if (request.Request.EstablishedYearTo.HasValue)
        {
            query = query.Where(u => u.EstablishedYear <= request.Request.EstablishedYearTo.Value);
        }

        if (request.Request.RankingFrom.HasValue)
        {
            query = query.Where(u => u.Ranking != null && u.Ranking >= request.Request.RankingFrom.Value);
        }

        if (request.Request.RankingTo.HasValue)
        {
            query = query.Where(u => u.Ranking != null && u.Ranking <= request.Request.RankingTo.Value);
        }

        if (request.Request.IsActive.HasValue)
        {
            query = query.Where(u => u.IsActive == request.Request.IsActive.Value);
        }

        // Apply sorting
        query = request.Request.SortBy?.ToLower() switch
        {
            "name" => request.Request.SortOrder?.ToLower() == "desc"
                ? query.OrderByDescending(u => u.Name)
                : query.OrderBy(u => u.Name),
            "establishedyear" => request.Request.SortOrder?.ToLower() == "desc"
                ? query.OrderByDescending(u => u.EstablishedYear)
                : query.OrderBy(u => u.EstablishedYear),
            "ranking" => request.Request.SortOrder?.ToLower() == "desc"
                ? query.OrderByDescending(u => u.Ranking)
                : query.OrderBy(u => u.Ranking),
            "createdat" => request.Request.SortOrder?.ToLower() == "desc"
                ? query.OrderByDescending(u => u.CreatedAt)
                : query.OrderBy(u => u.CreatedAt),
            _ => query.OrderBy(u => u.Name)
        };

        // Get total count
        var totalCount = await query.CountAsync(cancellationToken);

        // Apply pagination
        var universities = await query
            .Skip((request.Request.Page - 1) * request.Request.PageSize)
            .Take(request.Request.PageSize)
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
            Page = request.Request.Page,
            PageSize = request.Request.PageSize,
            TotalPages = (int)Math.Ceiling((double)totalCount / request.Request.PageSize)
        };
    }
}
