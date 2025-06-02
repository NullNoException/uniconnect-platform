using MediatR;
using UniConnect.Application.Admin.DTOs;

namespace UniConnect.Application.Admin.Queries.Analytics;

/// <summary>
/// Query to get system analytics data
/// </summary>
public class GetSystemAnalyticsQuery : IRequest<SystemAnalyticsDto>
{
    public string ReportType { get; set; } = string.Empty;
    public DateTime? DateFrom { get; set; }
    public DateTime? DateTo { get; set; }
}
