using MediatR;
using UniConnect.Application.Common.Models;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Users.Commands;

public record RegisterUserCommand : IRequest<Result<DTOs.UserDto>>
{
    public string Email { get; init; } = string.Empty;
    public string Password { get; init; } = string.Empty;
    public string ConfirmPassword { get; init; } = string.Empty;
    public UserType UserType { get; init; }
    public string FirstName { get; init; } = string.Empty;
    public string LastName { get; init; } = string.Empty;
    public string? PhoneNumber { get; init; }
    public string? PreferredLanguage { get; init; }
}
