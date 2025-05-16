using AutoMapper;
using MediatR;
using System.Linq.Expressions;
using UniConnect.Application.Common.Models;
using UniConnect.Application.Users.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Users.Queries;

public class GetUsersWithPaginationQueryHandler : IRequestHandler<GetUsersWithPaginationQuery, PaginatedList<UserDto>>
{
    private readonly IRepository<User> _userRepository;
    private readonly IMapper _mapper;

    public GetUsersWithPaginationQueryHandler(IRepository<User> userRepository, IMapper mapper)
    {
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<PaginatedList<UserDto>> Handle(GetUsersWithPaginationQuery request, CancellationToken cancellationToken)
    {
        // Start with all users
        IReadOnlyList<User> users;

        // Apply search if provided
        if (!string.IsNullOrEmpty(request.SearchString))
        {
            users = await _userRepository.FindAsync(
                u => u.Email.Contains(request.SearchString) ||
                     (u.Profile != null && (
                         u.Profile.FirstName.Contains(request.SearchString) ||
                         u.Profile.LastName.Contains(request.SearchString)
                     )),
                cancellationToken);
        }
        else
        {
            users = await _userRepository.GetAllAsync(cancellationToken);
        }

        // Apply sorting
        IOrderedEnumerable<User> orderedUsers;
        if (!string.IsNullOrEmpty(request.SortBy))
        {
            switch (request.SortBy.ToLower())
            {
                case "email":
                    orderedUsers = request.SortDescending
                        ? users.OrderByDescending(u => u.Email)
                        : users.OrderBy(u => u.Email);
                    break;
                case "createdat":
                    orderedUsers = request.SortDescending
                        ? users.OrderByDescending(u => u.CreatedAt)
                        : users.OrderBy(u => u.CreatedAt);
                    break;
                case "lastlogin":
                    orderedUsers = request.SortDescending
                        ? users.OrderByDescending(u => u.LastLoginDate)
                        : users.OrderBy(u => u.LastLoginDate);
                    break;
                case "status":
                    orderedUsers = request.SortDescending
                        ? users.OrderByDescending(u => u.Status)
                        : users.OrderBy(u => u.Status);
                    break;
                case "name":
                    orderedUsers = request.SortDescending
                        ? users.OrderByDescending(u => u.Profile != null ? u.Profile.LastName : string.Empty)
                        : users.OrderBy(u => u.Profile != null ? u.Profile.LastName : string.Empty);
                    break;
                default:
                    orderedUsers = users.OrderBy(u => u.Email);
                    break;
            }
        }
        else
        {
            orderedUsers = users.OrderByDescending(u => u.CreatedAt);
        }

        // Apply pagination and map to DTOs
        var paginatedUsers = orderedUsers
            .Skip((request.PageNumber - 1) * request.PageSize)
            .Take(request.PageSize)
            .ToList();

        var userDtos = _mapper.Map<List<UserDto>>(paginatedUsers);

        return new PaginatedList<UserDto>(
            userDtos,
            users.Count,
            request.PageNumber,
            request.PageSize);
    }
}
