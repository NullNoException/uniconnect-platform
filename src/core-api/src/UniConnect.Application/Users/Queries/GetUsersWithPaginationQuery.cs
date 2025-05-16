using MediatR;
using UniConnect.Application.Common.Models;

namespace UniConnect.Application.Users.Queries;

public record GetUsersWithPaginationQuery : IRequest<PaginatedList<DTOs.UserDto>>
{
    public int PageNumber { get; init; } = 1;
    public int PageSize { get; init; } = 10;
    public string? SearchString { get; init; }
    public string? SortBy { get; init; }
    public bool SortDescending { get; init; } = false;
}
