using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Queries.GetUniversityById;

public record GetUniversityByIdQuery(Guid Id) : IRequest<UniversityDto?>;
