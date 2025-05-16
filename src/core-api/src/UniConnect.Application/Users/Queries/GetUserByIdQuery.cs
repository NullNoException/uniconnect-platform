using MediatR;
using UniConnect.Application.Common.Models;

namespace UniConnect.Application.Users.Queries;

public record GetUserByIdQuery(Guid UserId) : IRequest<Result<DTOs.UserDto>>;
