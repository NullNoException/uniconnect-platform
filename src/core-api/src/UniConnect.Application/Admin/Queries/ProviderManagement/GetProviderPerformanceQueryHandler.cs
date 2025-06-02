using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Models;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Admin.Queries.ProviderManagement;

public class GetProviderPerformanceQueryHandler : IRequestHandler<GetProviderPerformanceQuery, PaginatedList<ProviderPerformanceDto>>
{
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly IRepository<Service> _serviceRepository;
    private readonly IRepository<ServiceRequest> _serviceRequestRepository;
    private readonly ILogger<GetProviderPerformanceQueryHandler> _logger;

    public GetProviderPerformanceQueryHandler(
        IRepository<ServiceProvider> providerRepository,
        IRepository<Service> serviceRepository,
        IRepository<ServiceRequest> serviceRequestRepository,
        ILogger<GetProviderPerformanceQueryHandler> logger)
    {
        _providerRepository = providerRepository;
        _serviceRepository = serviceRepository;
        _serviceRequestRepository = serviceRequestRepository;
        _logger = logger;
    }

    public async Task<PaginatedList<ProviderPerformanceDto>> Handle(GetProviderPerformanceQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting provider performance metrics for date range {DateFrom} to {DateTo}",
            request.DateFrom, request.DateTo);

        var allProviders = await _providerRepository.GetAllAsync();
        var providers = allProviders.AsQueryable();

        // Apply provider filter
        if (request.ProviderId.HasValue)
        {
            providers = providers.Where(sp => sp.Id == request.ProviderId.Value);
        }

        // Apply date filters
        if (request.DateFrom.HasValue)
        {
            providers = providers.Where(p => p.CreatedAt >= request.DateFrom.Value);
        }

        if (request.DateTo.HasValue)
        {
            providers = providers.Where(p => p.CreatedAt <= request.DateTo.Value);
        }

        var providerList = providers.ToList();
        var allServices = await _serviceRepository.GetAllAsync();
        var allServiceRequests = await _serviceRequestRepository.GetAllAsync();

        var performanceList = new List<ProviderPerformanceDto>();

        foreach (var provider in providerList)
        {
            var providerServices = allServices.Where(s => s.ProviderId == provider.Id).ToList();
            var providerRequests = allServiceRequests.Where(sr => providerServices.Any(s => s.Id == sr.ServiceId)).ToList();

            var lastActivityDate = provider.UpdatedAt ?? provider.CreatedAt;
            if (providerRequests.Any())
            {
                var latestRequestDate = providerRequests.Max(r => r.UpdatedAt ?? r.CreatedAt);
                if (latestRequestDate > lastActivityDate)
                {
                    lastActivityDate = latestRequestDate;
                }
            }

            var performanceDto = new ProviderPerformanceDto
            {
                ProviderId = provider.Id,
                CompanyName = provider.CompanyName,
                ContactEmail = provider.ContactEmail ?? string.Empty,
                VerificationStatus = provider.VerificationStatus,
                TotalServices = providerServices.Count,
                ActiveServices = providerServices.Count(s => s.IsActive),
                TotalApplications = providerRequests.Count,
                CompletedApplications = providerRequests.Count(sr => sr.RequestStatus == ServiceRequestStatus.Completed),
                PendingApplications = providerRequests.Count(sr => sr.RequestStatus == ServiceRequestStatus.Submitted ||
                                                                    sr.RequestStatus == ServiceRequestStatus.InReview ||
                                                                    sr.RequestStatus == ServiceRequestStatus.InProgress),
                CancelledApplications = providerRequests.Count(sr => sr.RequestStatus == ServiceRequestStatus.Cancelled),
                AverageCompletionTime = providerRequests.Any(sr => sr.RequestStatus == ServiceRequestStatus.Completed) ?
                    providerRequests.Where(sr => sr.RequestStatus == ServiceRequestStatus.Completed)
                        .Average(sr => (DateTime.Now - sr.CreatedAt).TotalDays) : 0,
                TotalRevenue = providerRequests.Where(sr => sr.RequestStatus == ServiceRequestStatus.Completed)
                    .Sum(sr => providerServices.First(s => s.Id == sr.ServiceId).BasePrice),
                LastActivityDate = lastActivityDate,
                CreatedAt = provider.CreatedAt
            };

            performanceList.Add(performanceDto);
        }

        // Apply sorting
        var sortedPerformance = request.SortBy?.ToLower() switch
        {
            "companyname" => request.SortOrder?.ToLower() == "desc"
                ? performanceList.OrderByDescending(p => p.CompanyName).ToList()
                : performanceList.OrderBy(p => p.CompanyName).ToList(),
            "totalservices" => request.SortOrder?.ToLower() == "desc"
                ? performanceList.OrderByDescending(p => p.TotalServices).ToList()
                : performanceList.OrderBy(p => p.TotalServices).ToList(),
            "totalapplications" => request.SortOrder?.ToLower() == "desc"
                ? performanceList.OrderByDescending(p => p.TotalApplications).ToList()
                : performanceList.OrderBy(p => p.TotalApplications).ToList(),
            "completedapplications" => request.SortOrder?.ToLower() == "desc"
                ? performanceList.OrderByDescending(p => p.CompletedApplications).ToList()
                : performanceList.OrderBy(p => p.CompletedApplications).ToList(),
            "totalrevenue" => request.SortOrder?.ToLower() == "desc"
                ? performanceList.OrderByDescending(p => p.TotalRevenue).ToList()
                : performanceList.OrderBy(p => p.TotalRevenue).ToList(),
            "lastactivitydate" => request.SortOrder?.ToLower() == "desc"
                ? performanceList.OrderByDescending(p => p.LastActivityDate).ToList()
                : performanceList.OrderBy(p => p.LastActivityDate).ToList(),
            _ => performanceList.OrderBy(p => p.CompanyName).ToList()
        };

        var totalCount = sortedPerformance.Count;
        var pagedResults = sortedPerformance
            .Skip((request.Page - 1) * request.PageSize)
            .Take(request.PageSize)
            .ToList();

        return new PaginatedList<ProviderPerformanceDto>(pagedResults, totalCount, request.Page, request.PageSize);
    }
}
