using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Queries.SearchUniversities;

public record SearchUniversitiesQuery(UniversitySearchRequest Request) : IRequest<UniversitySearchResponse>;
