using System.ComponentModel.DataAnnotations;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Users.Commands;
using UniConnect.Application.Users.DTOs;
using UniConnect.Application.Users.Queries;

namespace UniConnect.API.Controllers;

public class UsersController : ApiControllerBase
{
    private readonly IMediator _mediator;

    public UsersController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Registers a new user
    /// </summary>
    /// <param name="command">User registration details</param>
    /// <returns>The created user</returns>
    [HttpPost("register")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<UserDto>> Register(RegisterUserCommand command)
    {
        return HandleResult(await _mediator.Send(command));
    }

    /// <summary>
    /// Gets a user by ID
    /// </summary>
    /// <param name="id">User ID</param>
    /// <returns>The user details</returns>
    [Authorize]
    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<UserDto>> GetById(Guid id)
    {
        return HandleResult(await _mediator.Send(new GetUserByIdQuery(id)));
    }

    /// <summary>
    /// Gets a paginated list of users
    /// </summary>
    /// <param name="query">Pagination parameters</param>
    /// <returns>Paginated list of users</returns>
    [Authorize(Roles = "Admin")]
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public async Task<ActionResult<PaginatedResponse<UserDto>>> GetUsers([FromQuery] GetUsersWithPaginationQuery query)
    {
        return HandlePaginatedResult(await _mediator.Send(query));
    }
}
