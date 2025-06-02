using System.ComponentModel.DataAnnotations;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Admin.Commands.SystemManagement;

/// <summary>
/// Request for managing university data
/// </summary>
public class ManageUniversityDataRequest
{
    /// <summary>
    /// ID of the university to manage (required for update, delete, activate, deactivate operations)
    /// </summary>
    public Guid? UniversityId { get; init; }

    /// <summary>
    /// Operation to perform on the university data
    /// </summary>
    [Required]
    public UniversityDataOperation Action { get; init; }

    /// <summary>
    /// University name (required for create operation)
    /// </summary>
    public string? UniversityName { get; init; }

    /// <summary>
    /// University code (required for create operation)
    /// </summary>
    public string? UniversityCode { get; init; }

    /// <summary>
    /// Country identifier (required for create operation)
    /// </summary>
    public string? Country { get; init; }

    /// <summary>
    /// State or province
    /// </summary>
    public string? State { get; init; }

    /// <summary>
    /// City
    /// </summary>
    public string? City { get; init; }

    /// <summary>
    /// University website URL
    /// </summary>
    public string? Website { get; init; }

    /// <summary>
    /// URL to university logo
    /// </summary>
    public string? LogoUrl { get; init; }

    /// <summary>
    /// Whether the university is active
    /// </summary>
    public bool? IsActive { get; init; }
}
