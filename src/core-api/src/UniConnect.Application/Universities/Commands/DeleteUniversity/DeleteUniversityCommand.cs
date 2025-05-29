using MediatR;

namespace UniConnect.Application.Universities.Commands.DeleteUniversity;

public record DeleteUniversityCommand(Guid Id) : IRequest<bool>;
