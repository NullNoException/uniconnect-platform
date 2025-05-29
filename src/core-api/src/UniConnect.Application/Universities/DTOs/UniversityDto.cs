using AutoMapper;
using UniConnect.Application.Common.Mappings;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Universities.DTOs;

public record UniversityDto : IMapFrom<University>
{
    public Guid Id { get; init; }
    public string Name { get; init; } = string.Empty;
    public string? Description { get; init; }
    public Guid CountryId { get; init; }
    public string CountryName { get; init; } = string.Empty;
    public string? Website { get; init; }
    public string? LogoUrl { get; init; }
    public string? Email { get; init; }
    public string? Phone { get; init; }
    public UniversityStatus Status { get; init; }
    public AccreditationStatus AccreditationStatus { get; init; }
    public string? AccreditationBody { get; init; }
    public DateTime? AccreditationDate { get; init; }
    public int EstablishedYear { get; init; }
    public string? Type { get; init; }
    public decimal? Ranking { get; init; }
    public bool IsActive { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime? UpdatedAt { get; init; }

    // Related data
    public List<UniversityContactDto> Contacts { get; init; } = new();
    public List<UniversityAddressDto> Addresses { get; init; } = new();
    public List<AcademicProgramDto> Programs { get; init; } = new();

    public void Mapping(Profile profile)
    {
        profile.CreateMap<University, UniversityDto>()
            .ForMember(d => d.CountryName, opt => opt.MapFrom(s => s.Country != null ? s.Country.CountryName : string.Empty))
            .ForMember(d => d.Contacts, opt => opt.MapFrom(s => s.Contacts ?? new List<UniversityContact>()))
            .ForMember(d => d.Addresses, opt => opt.MapFrom(s => s.Addresses ?? new List<UniversityAddress>()))
            .ForMember(d => d.Programs, opt => opt.MapFrom(s => s.AcademicPrograms ?? new List<AcademicProgram>()));
    }
}

public record UniversityContactDto : IMapFrom<UniversityContact>
{
    public Guid Id { get; init; }
    public string ContactType { get; init; } = string.Empty;
    public string? Name { get; init; }
    public string? Email { get; init; }
    public string? Phone { get; init; }
    public string? Department { get; init; }
    public bool IsPrimary { get; init; }
    public bool IsActive { get; init; }

    public void Mapping(Profile profile)
    {
        profile.CreateMap<UniversityContact, UniversityContactDto>();
    }
}

public record UniversityAddressDto : IMapFrom<UniversityAddress>
{
    public Guid Id { get; init; }
    public string AddressType { get; init; } = string.Empty;
    public string? Street { get; init; }
    public string? City { get; init; }
    public string? State { get; init; }
    public string? PostalCode { get; init; }
    public string CountryName { get; init; } = string.Empty;
    public double? Latitude { get; init; }
    public double? Longitude { get; init; }
    public bool IsPrimary { get; init; }
    public bool IsActive { get; init; }

    public void Mapping(Profile profile)
    {
        profile.CreateMap<UniversityAddress, UniversityAddressDto>()
            .ForMember(d => d.CountryName, opt => opt.MapFrom(s => s.Country != null ? s.Country.CountryName : string.Empty));
    }
}

public record AcademicProgramDto : IMapFrom<AcademicProgram>
{
    public Guid Id { get; init; }
    public string Name { get; init; } = string.Empty;
    public string? Description { get; init; }
    public string AcademicLevelName { get; init; } = string.Empty;
    public string? MajorName { get; init; }
    public int DurationInSemesters { get; init; }
    public decimal? BaseTuitionFee { get; init; }
    public string? CurrencyCode { get; init; }
    public ProgramStatus Status { get; init; }
    public string? Language { get; init; }
    public bool IsOnline { get; init; }
    public bool IsPartTime { get; init; }
    public DateTime? ApplicationDeadline { get; init; }
    public DateTime? StartDate { get; init; }

    public void Mapping(Profile profile)
    {
        profile.CreateMap<AcademicProgram, AcademicProgramDto>()
            .ForMember(d => d.AcademicLevelName, opt => opt.MapFrom(s => s.AcademicLevel != null ? s.AcademicLevel.Name : string.Empty))
            .ForMember(d => d.MajorName, opt => opt.MapFrom(s => s.Major != null ? s.Major.Name : null))
            .ForMember(d => d.CurrencyCode, opt => opt.MapFrom(s => s.Currency != null ? s.Currency.CurrencyCode : null));
    }
}
