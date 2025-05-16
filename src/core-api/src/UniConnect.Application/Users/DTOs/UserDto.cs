using AutoMapper;
using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Users.DTOs;

public class UserDto : IMapFrom<User>
{
    public Guid Id { get; set; }
    public string Email { get; set; } = string.Empty;
    public UserType UserType { get; set; }
    public UserStatus Status { get; set; }
    public DateTime? LastLoginDate { get; set; }
    public DateTime CreatedAt { get; set; }
    public UserProfileDto? Profile { get; set; }

    public void Mapping(Profile profile)
    {
        profile.CreateMap<User, UserDto>();
    }
}
