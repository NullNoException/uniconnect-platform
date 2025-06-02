using MediatR;
using UniConnect.Application.Admin.DTOs;

namespace UniConnect.Application.Admin.Commands.Financial;

/// <summary>
/// Command to manage refund dispute
/// </summary>
public class ManageRefundDisputeCommand : IRequest<RefundDisputeDto>
{
    public Guid DisputeId { get; set; }
    public string Decision { get; set; } = string.Empty;
    public string? ResolutionNotes { get; set; }
    public decimal? RefundAmount { get; set; }
    public Guid AdminId { get; set; }
}

/// <summary>
/// Request DTO for managing refund dispute
/// </summary>
public class ManageRefundDisputeRequest
{
    public string Decision { get; set; } = string.Empty;
    public string? ResolutionNotes { get; set; }
    public decimal? RefundAmount { get; set; }
}
