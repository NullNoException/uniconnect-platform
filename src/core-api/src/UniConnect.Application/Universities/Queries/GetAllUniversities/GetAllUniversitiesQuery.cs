using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Queries.GetAllUniversities;

public record GetAllUniversitiesQuery(
    int Page = 1,
    int PageSize = 20,
    bool IncludeDeleted = false
) : IRequest<UniversitySearchResponse>;
