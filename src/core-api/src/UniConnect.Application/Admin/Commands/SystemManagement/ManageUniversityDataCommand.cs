using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Admin.Commands.SystemManagement;

/// <summary>
/// Command to manage university data
/// UC-3.4.2: Admin Manage University Data
/// </summary>
public class ManageUniversityDataCommand : IRequest<UniversityDto>
{
    public Guid AdminId { get; set; }
    public UniversityDataOperation Operation { get; set; }
    public Guid? UniversityId { get; set; }
    public string? UniversityName { get; set; }
    public string? UniversityCode { get; set; }
    public string? Country { get; set; }
    public string? State { get; set; }
    public string? City { get; set; }
    public string? Website { get; set; }
    public string? LogoUrl { get; set; }
    public bool? IsActive { get; set; }
}

public enum UniversityDataOperation
{
    Create,
    Update,
    Delete,
    Activate,
    Deactivate
}
