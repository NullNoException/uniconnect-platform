using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Admin.Commands.FinancialManagement;

public class ManageRefundDisputeCommandHandler : IRequestHandler<ManageRefundDisputeCommand, TransactionDto>
{
    private readonly IRepository<Transaction> _transactionRepository;
    private readonly ILogger<ManageRefundDisputeCommandHandler> _logger;

    public ManageRefundDisputeCommandHandler(
        IRepository<Transaction> transactionRepository,
        ILogger<ManageRefundDisputeCommandHandler> logger)
    {
        _transactionRepository = transactionRepository;
        _logger = logger;
    }

    public async Task<TransactionDto> Handle(ManageRefundDisputeCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Admin {AdminId} managing refund/dispute for transaction {TransactionId} with action {Action}",
            request.AdminId, request.TransactionId, request.Action);

        var transaction = await _transactionRepository.GetByIdAsync(request.TransactionId, cancellationToken);
        if (transaction == null)
            throw new InvalidOperationException($"Transaction with ID {request.TransactionId} not found");

        switch (request.Action)
        {
            case RefundDisputeAction.ApproveRefund:
                await ProcessRefund(transaction, transaction.Amount, request.Resolution, request.Notes);
                break;

            case RefundDisputeAction.RejectRefund:
                transaction.Status = TransactionStatus.Completed;
                transaction.Notes = $"Refund rejected: {request.Resolution}. {request.Notes}";
                break;

            case RefundDisputeAction.PartialRefund:
                if (!request.RefundAmount.HasValue)
                    throw new ArgumentException("Refund amount is required for partial refunds");
                await ProcessRefund(transaction, request.RefundAmount.Value, request.Resolution, request.Notes);
                break;

            case RefundDisputeAction.ResolveDispute:
                transaction.Status = TransactionStatus.Completed;
                transaction.Notes = $"Dispute resolved: {request.Resolution}. {request.Notes}";
                break;

            case RefundDisputeAction.EscalateDispute:
                transaction.Status = TransactionStatus.Disputed;
                transaction.Notes = $"Dispute escalated: {request.Resolution}. {request.Notes}";
                break;

            default:
                throw new ArgumentException($"Unknown action: {request.Action}");
        }

        transaction.ProcessedDate = DateTime.UtcNow;
        await _transactionRepository.UpdateAsync(transaction, cancellationToken);

        _logger.LogInformation("Successfully processed {Action} for transaction {TransactionId}",
            request.Action, request.TransactionId);

        return new TransactionDto
        {
            Id = transaction.Id,
            RequestId = transaction.RequestId,
            ServiceRequestId = transaction.RequestId, // Using RequestId as ServiceRequestId
            StudentId = transaction.Request?.StudentId,
            ProviderId = transaction.Request?.Service?.ProviderId,
            Amount = transaction.Amount,
            Currency = transaction.Currency?.CurrencyCode ?? "USD",
            CurrencyCode = transaction.Currency?.CurrencyCode ?? "USD",
            TransactionType = transaction.TransactionType,
            Status = transaction.Status.ToString(),
            PaymentMethod = transaction.PaymentMethod?.MethodType ?? "Unknown",
            ProcessedDate = transaction.ProcessedDate,
            Notes = transaction.Notes,
            CreatedAt = transaction.CreatedAt,
            TransactionDate = transaction.CreatedAt
        };
    }

    private static Task ProcessRefund(Transaction transaction, decimal refundAmount, string resolution, string? notes)
    {
        if (refundAmount > transaction.Amount)
            throw new ArgumentException("Refund amount cannot exceed original transaction amount");

        transaction.Status = TransactionStatus.Refunded;
        transaction.Notes = $"Refunded ${refundAmount:F2}: {resolution}. {notes}";

        // In a real implementation, you would also create a refund transaction record
        // and integrate with payment processor to actually process the refund
        return Task.CompletedTask;
    }
}
