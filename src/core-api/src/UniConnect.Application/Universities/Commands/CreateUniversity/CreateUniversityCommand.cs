using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Commands.CreateUniversity;

public record CreateUniversityCommand(CreateUniversityRequest Request) : IRequest<UniversityDto>;
