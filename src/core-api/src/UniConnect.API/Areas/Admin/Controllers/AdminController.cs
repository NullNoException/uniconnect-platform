using System.Security.Claims;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using UniConnect.API.Common;
using UniConnect.Application.Admin.Commands.Financial;
using UniConnect.Application.Admin.Commands.ProviderManagement;
using UniConnect.Application.Admin.Commands.ServiceManagement;
using UniConnect.Application.Admin.Commands.SystemManagement;
using UniConnect.Application.Admin.DTOs;
using UniConnect.Application.Admin.Queries.Analytics;
using UniConnect.Application.Admin.Queries.ProviderManagement;
using UniConnect.Application.Common.Models;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Application.Services.DTOs;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.API.Areas.Admin.Controllers;

// DTOs for requests
public record ManageUniversityDataRequest
{
    public Guid? UniversityId { get; init; }
    public UniversityDataOperation Action { get; init; }
    public string? UniversityName { get; init; }
    public string? UniversityCode { get; init; }
    public string? Country { get; init; }
    public string? State { get; init; }
    public string? City { get; init; }
    public string? Website { get; init; }
    public string? LogoUrl { get; init; }
    public bool? IsActive { get; init; }
    public Dictionary<string, object>? UniversityData { get; init; }
}

/// <summary>
/// Comprehensive Admin Controller for UniConnect Platform
/// Consolidates all administrative use cases into a single API controller
/// </summary>
[Area("Admin")]
[Route("api/admin/v1")]
[Authorize(Roles = "Admin,Administrator,SuperAdmin")]
public class AdminController : AreaControllerBase
{
    private readonly IMediator _mediator;
    private readonly ILogger<AdminController> _logger;

    public AdminController(IMediator mediator, ILogger<AdminController> logger)
    {
        _mediator = mediator;
        _logger = logger;
    }

    #region Provider Management

    /// <summary>
    /// Verify or reject a provider application
    /// UC-3.1.1: Admin Verify Provider
    /// </summary>
    /// <param name="providerId">The provider ID to verify</param>
    /// <param name="request">Verification details</param>
    /// <returns>Updated provider information</returns>
    [HttpPost("providers/{providerId:guid}/verify")]
    [ProducesResponseType(typeof(ProviderDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ProviderDto>> VerifyProvider(
        Guid providerId,
        [FromBody] VerifyProviderRequest request)
    {
        _logger.LogInformation("Admin {AdminId} verifying provider {ProviderId} with status {Status}",
            GetCurrentUserId(), providerId, request.Status);

        var command = new VerifyProviderCommand
        {
            ProviderId = providerId,
            Status = request.Status,
            VerificationNotes = request.VerificationNotes,
            RejectionReason = request.RejectionReason,
            AdminId = GetCurrentUserId()
        };

        var result = await _mediator.Send(command);
        return Ok(result);
    }

    /// <summary>
    /// Get provider performance metrics
    /// UC-3.1.2: Admin Monitor Provider Performance
    /// </summary>
    /// <param name="providerId">Optional provider ID to filter by specific provider</param>
    /// <param name="dateFrom">Start date for performance metrics</param>
    /// <param name="dateTo">End date for performance metrics</param>
    /// <param name="pageNumber">Page number for pagination</param>
    /// <param name="pageSize">Page size for pagination</param>
    /// <returns>Paginated list of provider performance data</returns>
    [HttpGet("providers/performance")]
    [ProducesResponseType(typeof(PaginatedResponse<ProviderPerformanceDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<PaginatedResponse<ProviderPerformanceDto>>> GetProviderPerformance(
        [FromQuery] Guid? providerId = null,
        [FromQuery] DateTime? dateFrom = null,
        [FromQuery] DateTime? dateTo = null,
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        _logger.LogInformation("Admin {AdminId} requesting provider performance metrics", GetCurrentUserId());

        var query = new GetProviderPerformanceQuery
        {
            ProviderId = providerId,
            DateFrom = dateFrom,
            DateTo = dateTo,
            Page = pageNumber,
            PageSize = pageSize
        };

        var result = await _mediator.Send(query);
        return HandlePaginatedResult<ProviderPerformanceDto>(result);
    }

    #endregion

    #region Service Management

    /// <summary>
    /// Approve or reject a service listing
    /// UC-3.2.1: Admin Approve Service Listing
    /// </summary>
    /// <param name="serviceId">The service ID to approve</param>
    /// <param name="request">Approval details</param>
    /// <returns>Updated service information</returns>
    [HttpPost("services/{serviceId:guid}/approve")]
    [ProducesResponseType(typeof(ServiceDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ServiceDto>> ApproveServiceListing(
        Guid serviceId,
        [FromBody] ApproveServiceListingRequest request)
    {
        _logger.LogInformation("Admin {AdminId} approving service {ServiceId} with status {Status}",
            GetCurrentUserId(), serviceId, request.Status);

        var command = new ApproveServiceListingCommand
        {
            ServiceId = serviceId,
            Status = request.Status,
            ApprovalNotes = request.ApprovalNotes,
            RejectionReason = request.RejectionReason,
            AdminId = GetCurrentUserId()
        };

        var result = await _mediator.Send(command);
        return Ok(result);
    }

    /// <summary>
    /// Manage service categories (create, update, deactivate)
    /// UC-3.2.2: Admin Manage Service Categories
    /// </summary>
    /// <param name="request">Service category management details</param>
    /// <returns>Updated service category information</returns>
    [HttpPost("service-categories/manage")]
    [ProducesResponseType(typeof(ServiceCategoryDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ServiceCategoryDto>> ManageServiceCategory(
        [FromBody] ManageServiceCategoryRequest request)
    {
        _logger.LogInformation("Admin {AdminId} managing service category with operation {Operation}",
            GetCurrentUserId(), request.Operation);

        var command = new ManageServiceCategoryCommand
        {
            CategoryName = request.CategoryName,
            Description = request.Description,
            IconUrl = request.IconUrl,
            IsActive = request.IsActive,
            SortOrder = request.SortOrder,
            Operation = request.Operation,
            AdminId = GetCurrentUserId()
        };

        var result = await _mediator.Send(command);
        return Ok(result);
    }

    #endregion

    #region Financial Management

    /// <summary>
    /// Release escrow payment to provider
    /// UC-3.3.1: Admin Release Escrow Payment
    /// </summary>
    /// <param name="transactionId">The transaction ID for escrow release</param>
    /// <param name="request">Escrow release details</param>
    /// <returns>Transaction update confirmation</returns>
    [HttpPost("transactions/{transactionId:guid}/release-escrow")]
    [ProducesResponseType(typeof(UniConnect.Application.Admin.DTOs.TransactionDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<UniConnect.Application.Admin.DTOs.TransactionDto>> ReleaseEscrowPayment(
        Guid transactionId,
        [FromBody] ReleaseEscrowPaymentRequest request)
    {
        _logger.LogInformation("Admin {AdminId} releasing escrow payment for transaction {TransactionId}",
            GetCurrentUserId(), transactionId);

        var command = new ReleaseEscrowPaymentCommand
        {
            TransactionId = transactionId,
            ReleaseAmount = request.ReleaseAmount,
            ReleaseReason = request.ReleaseReason,
            AdminNotes = request.AdminNotes,
            AdminId = GetCurrentUserId()
        };

        var result = await _mediator.Send(command);
        return Ok(result);
    }

    /// <summary>
    /// Manage refund disputes
    /// UC-3.3.2: Admin Manage Refund Disputes
    /// </summary>
    /// <param name="disputeId">The dispute ID to manage</param>
    /// <param name="request">Dispute resolution details</param>
    /// <returns>Dispute resolution confirmation</returns>
    [HttpPost("disputes/{disputeId:guid}/resolve")]
    [ProducesResponseType(typeof(RefundDisputeDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<RefundDisputeDto>> ManageRefundDispute(
        Guid disputeId,
        [FromBody] ManageRefundDisputeRequest request)
    {
        _logger.LogInformation("Admin {AdminId} resolving dispute {DisputeId} with decision {Decision}",
            GetCurrentUserId(), disputeId, request.Decision);

        var command = new ManageRefundDisputeCommand
        {
            DisputeId = disputeId,
            Decision = request.Decision,
            ResolutionNotes = request.ResolutionNotes,
            RefundAmount = request.RefundAmount,
            AdminId = GetCurrentUserId()
        };

        var result = await _mediator.Send(command);
        return Ok(result);
    }

    #endregion

    #region System Management

    /// <summary>
    /// Configure platform settings
    /// UC-3.4.1: Admin Configure Platform Settings
    /// </summary>
    /// <param name="request">Platform settings configuration</param>
    /// <returns>Updated platform settings</returns>
    [HttpPost("platform-settings/configure")]
    [ProducesResponseType(typeof(UniConnect.Application.Admin.DTOs.PlatformSettingsDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<UniConnect.Application.Admin.DTOs.PlatformSettingsDto>> ConfigurePlatformSettings(
        [FromBody] ConfigurePlatformSettingsRequest request)
    {
        _logger.LogInformation("Admin {AdminId} configuring platform settings", GetCurrentUserId());

        var command = new ConfigurePlatformSettingsCommand
        {
            Settings = request.Settings,
            AdminId = GetCurrentUserId()
        };

        var result = await _mediator.Send(command);
        return Ok(result);
    }

    /// <summary>
    /// Get system analytics and reports
    /// UC-3.4.2: Admin Get System Analytics
    /// </summary>
    /// <param name="reportType">Type of analytics report to generate</param>
    /// <param name="dateFrom">Start date for analytics</param>
    /// <param name="dateTo">End date for analytics</param>
    /// <returns>System analytics data</returns>
    [HttpGet("analytics/{reportType}")]
    [ProducesResponseType(typeof(SystemAnalyticsDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<SystemAnalyticsDto>> GetSystemAnalytics(
        string reportType,
        [FromQuery] DateTime? dateFrom = null,
        [FromQuery] DateTime? dateTo = null)
    {
        _logger.LogInformation("Admin {AdminId} requesting system analytics report {ReportType}",
            GetCurrentUserId(), reportType);

        var query = new GetSystemAnalyticsQuery
        {
            ReportType = reportType,
            DateFrom = dateFrom,
            DateTo = dateTo
        };

        var result = await _mediator.Send(query);
        return Ok(result);
    }

    #endregion

    #region University Data Management

    /// <summary>
    /// Manage university data (create, update, verify)
    /// UC-3.5.1: Admin Manage University Data
    /// </summary>
    /// <param name="request">University data management details</param>
    /// <returns>Updated university information</returns>
    [HttpPost("universities/manage")]
    [ProducesResponseType(typeof(UniversityDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<UniversityDto>> ManageUniversityData(
        [FromBody] ManageUniversityDataRequest request)
    {
        _logger.LogInformation("Admin {AdminId} managing university data with action {Action}",
            GetCurrentUserId(), request.Action);

        var command = new ManageUniversityDataCommand
        {
            UniversityId = request.UniversityId,
            Operation = request.Action,
            UniversityName = request.UniversityName,
            UniversityCode = request.UniversityCode,
            Country = request.Country,
            State = request.State,
            City = request.City,
            Website = request.Website,
            LogoUrl = request.LogoUrl,
            IsActive = request.IsActive,
            AdminId = GetCurrentUserId()
        };

        var result = await _mediator.Send(command);
        return Ok(result);
    }

    #endregion

    #region Helper Methods

    /// <summary>
    /// Gets the current authenticated user ID from claims
    /// </summary>
    /// <returns>The current user's ID</returns>
    private Guid GetCurrentUserId()
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        return Guid.TryParse(userIdClaim, out var userId) ? userId : Guid.Empty;
    }

    #endregion
}
