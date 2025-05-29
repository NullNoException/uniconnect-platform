using System.ComponentModel.DataAnnotations;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Universities.DTOs;

public record CreateUniversityRequest
{
    [Required(ErrorMessage = "University name is required")]
    [StringLength(256, ErrorMessage = "University name cannot exceed 256 characters")]
    public string Name { get; init; } = string.Empty;

    [StringLength(2000, ErrorMessage = "Description cannot exceed 2000 characters")]
    public string? Description { get; init; }

    [Required(ErrorMessage = "Country is required")]
    public Guid CountryId { get; init; }

    [Url(ErrorMessage = "Website must be a valid URL")]
    public string? Website { get; init; }

    [EmailAddress(ErrorMessage = "Email must be a valid email address")]
    public string? Email { get; init; }

    [Phone(ErrorMessage = "Phone must be a valid phone number")]
    public string? Phone { get; init; }

    [Range(1800, 2030, ErrorMessage = "Established year must be between 1800 and 2030")]
    public int EstablishedYear { get; init; }

    [StringLength(50, ErrorMessage = "Type cannot exceed 50 characters")]
    public string? Type { get; init; }

    [StringLength(100, ErrorMessage = "Accreditation body cannot exceed 100 characters")]
    public string? AccreditationBody { get; init; }

    public DateTime? AccreditationDate { get; init; }

    [Range(0, 10000, ErrorMessage = "Ranking must be between 0 and 10000")]
    public decimal? Ranking { get; init; }

    // Address information
    public CreateUniversityAddressRequest? Address { get; init; }

    // Contact information
    public List<CreateUniversityContactRequest> Contacts { get; init; } = new();
}

public record CreateUniversityAddressRequest
{
    [Required(ErrorMessage = "Address type is required")]
    [StringLength(50, ErrorMessage = "Address type cannot exceed 50 characters")]
    public string AddressType { get; init; } = "Main Campus";

    [StringLength(200, ErrorMessage = "Street cannot exceed 200 characters")]
    public string? Street { get; init; }

    [StringLength(100, ErrorMessage = "City cannot exceed 100 characters")]
    public string? City { get; init; }

    [StringLength(100, ErrorMessage = "State cannot exceed 100 characters")]
    public string? State { get; init; }

    [StringLength(20, ErrorMessage = "Postal code cannot exceed 20 characters")]
    public string? PostalCode { get; init; }

    [Required(ErrorMessage = "Country is required")]
    public Guid CountryId { get; init; }

    [Range(-90, 90, ErrorMessage = "Latitude must be between -90 and 90")]
    public double? Latitude { get; init; }

    [Range(-180, 180, ErrorMessage = "Longitude must be between -180 and 180")]
    public double? Longitude { get; init; }

    public bool IsPrimary { get; init; } = true;
}

public record CreateUniversityContactRequest
{
    [Required(ErrorMessage = "Contact type is required")]
    [StringLength(50, ErrorMessage = "Contact type cannot exceed 50 characters")]
    public string ContactType { get; init; } = string.Empty;

    [StringLength(100, ErrorMessage = "Name cannot exceed 100 characters")]
    public string? Name { get; init; }

    [EmailAddress(ErrorMessage = "Email must be a valid email address")]
    public string? Email { get; init; }

    [Phone(ErrorMessage = "Phone must be a valid phone number")]
    public string? Phone { get; init; }

    [StringLength(100, ErrorMessage = "Department cannot exceed 100 characters")]
    public string? Department { get; init; }

    public bool IsPrimary { get; init; } = false;
}

public record UpdateUniversityRequest
{
    [Required(ErrorMessage = "University ID is required")]
    public Guid Id { get; init; }

    [Required(ErrorMessage = "University name is required")]
    [StringLength(256, ErrorMessage = "University name cannot exceed 256 characters")]
    public string Name { get; init; } = string.Empty;

    [StringLength(2000, ErrorMessage = "Description cannot exceed 2000 characters")]
    public string? Description { get; init; }

    [Required(ErrorMessage = "Country is required")]
    public Guid CountryId { get; init; }

    [Url(ErrorMessage = "Website must be a valid URL")]
    public string? Website { get; init; }

    [EmailAddress(ErrorMessage = "Email must be a valid email address")]
    public string? Email { get; init; }

    [Phone(ErrorMessage = "Phone must be a valid phone number")]
    public string? Phone { get; init; }

    [Range(1800, 2030, ErrorMessage = "Established year must be between 1800 and 2030")]
    public int EstablishedYear { get; init; }

    [StringLength(50, ErrorMessage = "Type cannot exceed 50 characters")]
    public string? Type { get; init; }

    [StringLength(100, ErrorMessage = "Accreditation body cannot exceed 100 characters")]
    public string? AccreditationBody { get; init; }

    public DateTime? AccreditationDate { get; init; }

    [Range(0, 10000, ErrorMessage = "Ranking must be between 0 and 10000")]
    public decimal? Ranking { get; init; }

    public bool IsActive { get; init; } = true;
}
