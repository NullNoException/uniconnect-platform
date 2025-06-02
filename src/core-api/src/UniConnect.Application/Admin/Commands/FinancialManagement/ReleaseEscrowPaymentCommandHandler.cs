using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Admin.Commands.FinancialManagement;

public class ReleaseEscrowPaymentCommandHandler : IRequestHandler<ReleaseEscrowPaymentCommand, TransactionDto>
{
    private readonly IRepository<Transaction> _transactionRepository;
    private readonly IRepository<ServiceRequest> _serviceRequestRepository;
    private readonly ILogger<ReleaseEscrowPaymentCommandHandler> _logger;

    public ReleaseEscrowPaymentCommandHandler(
        IRepository<Transaction> transactionRepository,
        IRepository<ServiceRequest> serviceRequestRepository,
        ILogger<ReleaseEscrowPaymentCommandHandler> logger)
    {
        _transactionRepository = transactionRepository;
        _serviceRequestRepository = serviceRequestRepository;
        _logger = logger;
    }

    public async Task<TransactionDto> Handle(ReleaseEscrowPaymentCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Admin {AdminId} releasing escrow payment for transaction {TransactionId}",
            request.AdminId, request.TransactionId);

        var transaction = await _transactionRepository.GetByIdAsync(request.TransactionId, cancellationToken);
        if (transaction == null)
            throw new InvalidOperationException($"Transaction with ID {request.TransactionId} not found");

        if (transaction.Status != TransactionStatus.Pending)
            throw new InvalidOperationException($"Cannot release payment for transaction with status {transaction.Status}");

        // Check if service request is completed or force release is enabled
        var serviceRequest = await _serviceRequestRepository.GetByIdAsync(transaction.ServiceRequestId, cancellationToken);
        if (serviceRequest == null)
            throw new InvalidOperationException($"Service request not found for transaction {request.TransactionId}");

        if (!request.ForceRelease && serviceRequest.RequestStatus != ServiceRequestStatus.Completed)
        {
            throw new InvalidOperationException("Cannot release escrow payment for incomplete service request. Use force release if necessary.");
        }

        // Update transaction status
        transaction.Status = TransactionStatus.Completed;
        transaction.ProcessedDate = DateTime.UtcNow;
        transaction.Notes = request.ReleaseNotes;

        await _transactionRepository.UpdateAsync(transaction, cancellationToken);

        _logger.LogInformation("Successfully released escrow payment for transaction {TransactionId}", request.TransactionId);

        return new TransactionDto
        {
            Id = transaction.Id,
            ServiceRequestId = transaction.ServiceRequestId,
            StudentId = transaction.StudentId,
            ProviderId = transaction.ProviderId,
            Amount = transaction.Amount,
            Currency = transaction.Currency?.CurrencySymbol ?? string.Empty,
            TransactionType = transaction.TransactionType,
            Status = transaction.Status.ToString(),
            PaymentMethod = transaction.PaymentMethod?.MethodType ?? string.Empty,
            ProcessedDate = transaction.ProcessedDate,
            Notes = transaction.Notes,
            CreatedAt = transaction.CreatedAt
        };
    }
}
