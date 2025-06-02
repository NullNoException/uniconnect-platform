using MediatR;
using UniConnect.Application.Services.DTOs;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Admin.Commands.ServiceManagement;

/// <summary>
/// Command to approve or reject a service listing
/// UC-3.2.1: Admin Approve Service Listing
/// </summary>
public record ApproveServiceListingCommand : IRequest<ServiceDto>
{
    public Guid ServiceId { get; init; }
    public ServiceApprovalStatus Status { get; init; }
    public string? ApprovalNotes { get; init; }
    public string? RejectionReason { get; init; }
    public Guid AdminId { get; init; }
}

public record ApproveServiceListingRequest
{
    public ServiceApprovalStatus Status { get; init; }
    public string? ApprovalNotes { get; init; }
    public string? RejectionReason { get; init; }
}
