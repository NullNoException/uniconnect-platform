using System;
using System.Collections.Generic;

namespace UniConnect.Application.Admin.DTOs
{
    /// <summary>
    /// DTO for system analytics and metrics
    /// </summary>
    public class SystemAnalyticsDto
    {
        /// <summary>
        /// Overall platform statistics
        /// </summary>
        public PlatformStats Platform { get; set; }

        /// <summary>
        /// User activity metrics
        /// </summary>
        public UserMetrics Users { get; set; }

        /// <summary>
        /// Financial transaction metrics
        /// </summary>
        public FinancialMetrics Financial { get; set; }

        /// <summary>
        /// Service usage analytics
        /// </summary>
        public ServiceMetrics Services { get; set; }

        /// <summary>
        /// System performance metrics
        /// </summary>
        public PerformanceMetrics Performance { get; set; }

        /// <summary>
        /// Search and discovery analytics
        /// </summary>
        public SearchMetrics Search { get; set; }

        /// <summary>
        /// Date range for the analytics data
        /// </summary>
        public DateTime FromDate { get; set; }

        /// <summary>
        /// End date for the analytics data
        /// </summary>
        public DateTime ToDate { get; set; }

        /// <summary>
        /// When the analytics were generated
        /// </summary>
        public DateTime GeneratedAt { get; set; }

        public SystemAnalyticsDto()
        {
            Platform = new PlatformStats();
            Users = new UserMetrics();
            Financial = new FinancialMetrics();
            Services = new ServiceMetrics();
            Performance = new PerformanceMetrics();
            Search = new SearchMetrics();
        }
    }

    /// <summary>
    /// Platform-wide statistics
    /// </summary>
    public class PlatformStats
    {
        public int TotalUsers { get; set; }
        public int ActiveProviders { get; set; }
        public int PendingProviders { get; set; }
        public int TotalServices { get; set; }
        public int ActiveServices { get; set; }
        public int TotalTransactions { get; set; }
        public decimal TotalRevenue { get; set; }
        public double AverageRating { get; set; }
        public int TotalReviews { get; set; }
    }

    /// <summary>
    /// User activity and engagement metrics
    /// </summary>
    public class UserMetrics
    {
        public int NewUsersToday { get; set; }
        public int NewUsersThisWeek { get; set; }
        public int NewUsersThisMonth { get; set; }
        public int ActiveUsersToday { get; set; }
        public int ActiveUsersThisWeek { get; set; }
        public int ActiveUsersThisMonth { get; set; }
        public double RetentionRate { get; set; }
        public double EngagementRate { get; set; }
        public List<DailyUserActivity> DailyActivity { get; set; }

        public UserMetrics()
        {
            DailyActivity = new List<DailyUserActivity>();
        }
    }

    /// <summary>
    /// Financial transaction analytics
    /// </summary>
    public class FinancialMetrics
    {
        public decimal TotalVolumeToday { get; set; }
        public decimal TotalVolumeThisWeek { get; set; }
        public decimal TotalVolumeThisMonth { get; set; }
        public decimal AverageTransactionValue { get; set; }
        public int PendingPayments { get; set; }
        public int CompletedTransactions { get; set; }
        public int RefundRequests { get; set; }
        public int DisputesCases { get; set; }
        public decimal PlatformFees { get; set; }
        public List<DailyRevenue> DailyRevenue { get; set; }

        public FinancialMetrics()
        {
            DailyRevenue = new List<DailyRevenue>();
        }
    }

    /// <summary>
    /// Service usage and performance metrics
    /// </summary>
    public class ServiceMetrics
    {
        public int TotalBookings { get; set; }
        public int BookingsToday { get; set; }
        public int BookingsThisWeek { get; set; }
        public int BookingsThisMonth { get; set; }
        public double AverageCompletionTime { get; set; }
        public double ServiceSuccessRate { get; set; }
        public List<PopularService> TopServices { get; set; }
        public List<ServiceCategoryStats> CategoryStats { get; set; }

        public ServiceMetrics()
        {
            TopServices = new List<PopularService>();
            CategoryStats = new List<ServiceCategoryStats>();
        }
    }

    /// <summary>
    /// System performance and technical metrics
    /// </summary>
    public class PerformanceMetrics
    {
        public double AverageResponseTime { get; set; }
        public double SystemUptime { get; set; }
        public int ErrorCount { get; set; }
        public double ErrorRate { get; set; }
        public long DatabaseQueries { get; set; }
        public double CacheHitRate { get; set; }
        public long ApiRequests { get; set; }
        public List<EndpointUsage> TopEndpoints { get; set; }

        public PerformanceMetrics()
        {
            TopEndpoints = new List<EndpointUsage>();
        }
    }

    /// <summary>
    /// Search and discovery analytics
    /// </summary>
    public class SearchMetrics
    {
        public int TotalSearches { get; set; }
        public int SearchesToday { get; set; }
        public int SearchesThisWeek { get; set; }
        public double AverageSearchTime { get; set; }
        public double SearchSuccessRate { get; set; }
        public List<PopularSearchTerm> TopSearchTerms { get; set; }
        public List<SearchResultClick> ClickThroughRates { get; set; }

        public SearchMetrics()
        {
            TopSearchTerms = new List<PopularSearchTerm>();
            ClickThroughRates = new List<SearchResultClick>();
        }
    }

    /// <summary>
    /// Daily user activity data point
    /// </summary>
    public class DailyUserActivity
    {
        public DateTime Date { get; set; }
        public int ActiveUsers { get; set; }
        public int NewUsers { get; set; }
        public int Sessions { get; set; }
    }

    /// <summary>
    /// Daily revenue data point
    /// </summary>
    public class DailyRevenue
    {
        public DateTime Date { get; set; }
        public decimal Revenue { get; set; }
        public int TransactionCount { get; set; }
        public decimal AverageValue { get; set; }
    }

    /// <summary>
    /// Popular service information
    /// </summary>
    public class PopularService
    {
        public string ServiceName { get; set; } = string.Empty;
        public string Category { get; set; } = string.Empty;
        public int BookingCount { get; set; }
        public decimal Revenue { get; set; }
        public double Rating { get; set; }
    }

    /// <summary>
    /// Service category statistics
    /// </summary>
    public class ServiceCategoryStats
    {
        public string CategoryName { get; set; } = string.Empty;
        public int ServiceCount { get; set; }
        public int BookingCount { get; set; }
        public decimal Revenue { get; set; }
        public double AverageRating { get; set; }
    }

    /// <summary>
    /// API endpoint usage statistics
    /// </summary>
    public class EndpointUsage
    {
        public string Endpoint { get; set; } = string.Empty;
        public int RequestCount { get; set; }
        public double AverageResponseTime { get; set; }
        public double ErrorRate { get; set; }
    }

    /// <summary>
    /// Popular search term data
    /// </summary>
    public class PopularSearchTerm
    {
        public string Term { get; set; } = string.Empty;
        public int SearchCount { get; set; }
        public int ResultCount { get; set; }
        public double ClickThroughRate { get; set; }
    }

    /// <summary>
    /// Search result click tracking
    /// </summary>
    public class SearchResultClick
    {
        public string SearchTerm { get; set; } = string.Empty;
        public int Position { get; set; }
        public int Clicks { get; set; }
        public int Impressions { get; set; }
        public double ClickThroughRate { get; set; }
    }
}
