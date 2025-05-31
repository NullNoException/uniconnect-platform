using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Queries.FinancialManagement;

public class GetProviderEarningsQueryHandler : IRequestHandler<GetProviderEarningsQuery, ProviderEarningsDto>
{
    private readonly IRepository<Transaction> _transactionRepository;
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly ILogger<GetProviderEarningsQueryHandler> _logger;

    public GetProviderEarningsQueryHandler(
        IRepository<Transaction> transactionRepository,
        IRepository<ServiceProvider> providerRepository,
        ILogger<GetProviderEarningsQueryHandler> logger)
    {
        _transactionRepository = transactionRepository;
        _providerRepository = providerRepository;
        _logger = logger;
    }

    public async Task<ProviderEarningsDto> Handle(GetProviderEarningsQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting earnings for provider {ProviderId}", request.ProviderId);

        // Verify provider exists
        var provider = await _providerRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        // Get all transactions for the provider - basic filtering without includes
        var allTransactions = await _transactionRepository.GetAllAsync(cancellationToken);
        var transactions = allTransactions.Where(t =>
            (!request.DateFrom.HasValue || t.CreatedAt >= request.DateFrom.Value) &&
            (!request.DateTo.HasValue || t.CreatedAt <= request.DateTo.Value))
            .ToList();

        var now = DateTime.UtcNow;
        var thisMonthStart = new DateTime(now.Year, now.Month, 1);
        var lastMonthStart = thisMonthStart.AddMonths(-1);
        var lastMonthEnd = thisMonthStart.AddDays(-1);

        // Calculate earnings
        var completedTransactions = transactions.Where(t => t.Status == "Completed" || t.Status == "Released").ToList();
        var totalEarnings = completedTransactions.Sum(t => t.ProviderAmount);

        var pendingTransactions = transactions.Where(t => t.Status == "Pending" || t.Status == "Escrowed").ToList();
        var pendingEarnings = pendingTransactions.Sum(t => t.ProviderAmount);

        var availableTransactions = completedTransactions.Where(t => t.Status == "Released").ToList();
        var availableForWithdrawal = availableTransactions.Sum(t => t.ProviderAmount);

        var thisMonthEarnings = completedTransactions
            .Where(t => t.CreatedAt >= thisMonthStart)
            .Sum(t => t.ProviderAmount);

        var lastMonthEarnings = completedTransactions
            .Where(t => t.CreatedAt >= lastMonthStart && t.CreatedAt <= lastMonthEnd)
            .Sum(t => t.ProviderAmount);

        // Calculate earnings breakdown by service
        var earningsBreakdown = completedTransactions
            .GroupBy(t => new { t.Request.Service.Id, t.Request.Service.ServiceName })
            .Select(g => new EarningsBreakdownDto
            {
                ServiceId = g.Key.Id,
                ServiceName = g.Key.ServiceName,
                TotalEarnings = g.Sum(t => t.ProviderAmount),
                CompletedRequests = g.Count(),
                AverageOrderValue = g.Any() ? g.Average(t => t.ProviderAmount) : 0
            })
            .OrderByDescending(e => e.TotalEarnings)
            .ToList();

        // Get recent transactions
        var recentTransactions = transactions
            .OrderByDescending(t => t.CreatedAt)
            .Take(10)
            .Select(t => new TransactionDto
            {
                Id = t.Id,
                RequestId = t.RequestId,
                TransactionType = t.TransactionType,
                Amount = t.ProviderAmount,
                CurrencyCode = t.Currency.CurrencyCode,
                Status = t.Status,
                TransactionDate = t.CreatedAt,
                Description = $"Payment for {t.Request.Service.ServiceName}",
                ServiceName = t.Request.Service.ServiceName,
                StudentName = t.Request.Student.User.Profile != null ?
                    $"{t.Request.Student.User.Profile.FirstName} {t.Request.Student.User.Profile.LastName}" :
                    t.Request.Student.User.Email
            })
            .ToList();

        return new ProviderEarningsDto
        {
            ProviderId = request.ProviderId,
            TotalEarnings = totalEarnings,
            PendingEarnings = pendingEarnings,
            AvailableForWithdrawal = availableForWithdrawal,
            ThisMonthEarnings = thisMonthEarnings,
            LastMonthEarnings = lastMonthEarnings,
            EarningsBreakdown = earningsBreakdown,
            RecentTransactions = recentTransactions
        };
    }
}
