using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Commands.UpdateUniversity;

public record UpdateUniversityCommand(UpdateUniversityRequest Request) : IRequest<UniversityDto>;
