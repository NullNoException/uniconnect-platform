using AutoMapper;
using MediatR;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Models;
using UniConnect.Application.Users.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Users.Queries;

public class GetUserByIdQueryHandler : IRequestHandler<GetUserByIdQuery, Result<UserDto>>
{
    private readonly IRepository<User> _userRepository;
    private readonly IMapper _mapper;

    public GetUserByIdQueryHandler(IRepository<User> userRepository, IMapper mapper)
    {
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<Result<UserDto>> Handle(GetUserByIdQuery request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(request.UserId, cancellationToken);

        if (user == null)
        {
            throw new NotFoundException(nameof(User), request.UserId);
        }

        var userDto = _mapper.Map<UserDto>(user);

        return Result<UserDto>.Success(userDto);
    }
}
