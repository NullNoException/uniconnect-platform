using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;
using UniConnect.Domain.Services;

namespace UniConnect.Application.Providers.Commands.FinancialManagement;

public class ReceiveEscrowReleaseCommandHandler : IRequestHandler<ReceiveEscrowReleaseCommand, EscrowReleaseDto>
{
    private readonly IRepository<Transaction> _transactionRepository;
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly IPaymentService _paymentService;
    private readonly ILogger<ReceiveEscrowReleaseCommandHandler> _logger;

    public ReceiveEscrowReleaseCommandHandler(
        IRepository<Transaction> transactionRepository,
        IRepository<ServiceProvider> providerRepository,
        IPaymentService paymentService,
        ILogger<ReceiveEscrowReleaseCommandHandler> logger)
    {
        _transactionRepository = transactionRepository;
        _providerRepository = providerRepository;
        _paymentService = paymentService;
        _logger = logger;
    }

    public async Task<EscrowReleaseDto> Handle(ReceiveEscrowReleaseCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Processing escrow release for transaction {TransactionId} by provider {ProviderId}",
            request.TransactionId, request.ProviderId);

        // Verify provider exists
        var provider = await _providerRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        // Get transaction
        var transaction = await _transactionRepository.GetByIdAsync(request.TransactionId, cancellationToken);

        if (transaction == null)
        {
            throw new InvalidOperationException($"Transaction with ID {request.TransactionId} not found");
        }

        // Verify the transaction belongs to this provider
        if (transaction.Request.Service.ProviderId != request.ProviderId)
        {
            throw new InvalidOperationException("Transaction does not belong to the specified provider");
        }

        // Validate transaction is in correct state for escrow release
        if (transaction.Status != "Escrowed")
        {
            throw new InvalidOperationException($"Transaction is not in escrow status. Current status: {transaction.Status}");
        }

        // Validate the service request is completed
        if (transaction.Request.RequestStatus != ServiceRequestStatus.Completed)
        {
            throw new InvalidOperationException("Cannot release escrow for incomplete service request");
        }

        // Check if escrow release date has passed (if set)
        if (transaction.EscrowReleaseDate.HasValue && transaction.EscrowReleaseDate > DateTime.UtcNow)
        {
            throw new InvalidOperationException($"Escrow release date has not been reached yet. Release date: {transaction.EscrowReleaseDate}");
        }

        try
        {
            // Process escrow release through payment service
            var releaseSuccess = await _paymentService.ReleaseEscrowAsync(
                transaction.PaymentGatewayTransactionId ?? transaction.Id.ToString(),
                cancellationToken);

            if (!releaseSuccess)
            {
                throw new InvalidOperationException("Failed to release escrow through payment processor");
            }

            // Update transaction status
            transaction.Status = "Released";
            transaction.EscrowReleaseDate = DateTime.UtcNow;

            await _transactionRepository.UpdateAsync(transaction, cancellationToken);

            _logger.LogInformation("Successfully released escrow for transaction {TransactionId}, amount: {Amount} {Currency}",
                transaction.Id, transaction.ProviderAmount, transaction.Currency.CurrencyCode);

            return new EscrowReleaseDto
            {
                TransactionId = transaction.Id,
                RequestId = transaction.RequestId,
                Amount = transaction.ProviderAmount,
                CurrencyCode = transaction.Currency.CurrencyCode,
                ReleaseDate = transaction.EscrowReleaseDate.Value,
                ServiceName = transaction.Request.Service.ServiceName,
                StudentName = transaction.Request.Student.User.Profile != null ?
                    $"{transaction.Request.Student.User.Profile.FirstName} {transaction.Request.Student.User.Profile.LastName}" :
                    transaction.Request.Student.User.Email
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to release escrow for transaction {TransactionId}", request.TransactionId);
            throw new InvalidOperationException($"Failed to release escrow: {ex.Message}");
        }
    }
}
