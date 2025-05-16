using AutoMapper;
using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.Users.DTOs;

public class UserProfileDto : IMapFrom<UserProfile>
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? PhoneNumber { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string? ProfilePictureUrl { get; set; }
    public string PreferredLanguage { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;

    public void Mapping(Profile profile)
    {
        profile.CreateMap<UserProfile, UserProfileDto>();
    }
}
