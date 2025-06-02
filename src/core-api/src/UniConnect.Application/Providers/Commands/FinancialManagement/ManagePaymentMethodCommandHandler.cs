using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.FinancialManagement;

public class ManagePaymentMethodCommandHandler : IRequestHandler<ManagePaymentMethodCommand, PaymentMethodDto>
{
    private readonly IRepository<PaymentMethod> _paymentMethodRepository;
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly IRepository<Transaction> _transactionRepository;
    private readonly ILogger<ManagePaymentMethodCommandHandler> _logger;

    public ManagePaymentMethodCommandHandler(
        IRepository<PaymentMethod> paymentMethodRepository,
        IRepository<ServiceProvider> providerRepository,
        IRepository<Transaction> transactionRepository,
        ILogger<ManagePaymentMethodCommandHandler> logger)
    {
        _paymentMethodRepository = paymentMethodRepository;
        _providerRepository = providerRepository;
        _transactionRepository = transactionRepository;
        _logger = logger;
    }

    public async Task<PaymentMethodDto> Handle(ManagePaymentMethodCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Managing payment method for provider {ProviderId}, operation: {Operation}",
            request.ProviderId, request.Operation);

        // Verify provider exists and get user ID
        var provider = await _providerRepository.GetByIdAsync(request.ProviderId, cancellationToken);

        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        switch (request.Operation.ToUpper())
        {
            case "CREATE":
                return await CreatePaymentMethodAsync(provider.UserId, request, cancellationToken);

            case "UPDATE":
                return await UpdatePaymentMethodAsync(provider.UserId, request, cancellationToken);

            case "DELETE":
                return await DeletePaymentMethodAsync(provider.UserId, request, cancellationToken);

            case "SETDEFAULT":
                return await SetDefaultPaymentMethodAsync(provider.UserId, request, cancellationToken);

            default:
                throw new ArgumentException($"Invalid operation: {request.Operation}");
        }
    }

    private async Task<PaymentMethodDto> CreatePaymentMethodAsync(Guid userId, ManagePaymentMethodCommand request, CancellationToken cancellationToken)
    {
        // If this is set as default, unset other default methods
        if (request.IsDefault)
        {
            await UnsetDefaultPaymentMethodsAsync(userId, cancellationToken);
        }

        var paymentMethod = new PaymentMethod
        {
            UserId = userId,
            MethodType = request.MethodType!,
            AccountName = request.AccountName!,
            MaskedAccountNumber = MaskAccountNumber(request.AccountNumber),
            ExpiryDate = request.ExpiryDate,
            IsDefault = request.IsDefault,
            PaymentGatewayCustomerId = null, // Would be set by payment processor integration
            PaymentGatewayToken = null // Would be set by payment processor integration
        };

        await _paymentMethodRepository.AddAsync(paymentMethod, cancellationToken);

        _logger.LogInformation("Created payment method {PaymentMethodId} for user {UserId}",
            paymentMethod.Id, userId);

        return MapToDto(paymentMethod, request);
    }

    private async Task<PaymentMethodDto> UpdatePaymentMethodAsync(Guid userId, ManagePaymentMethodCommand request, CancellationToken cancellationToken)
    {
        var paymentMethod = await _paymentMethodRepository.GetByIdAsync(request.PaymentMethodId!.Value, cancellationToken);

        if (paymentMethod == null || paymentMethod.UserId != userId)
        {
            throw new InvalidOperationException($"Payment method with ID {request.PaymentMethodId} not found or not owned by provider");
        }

        // If this is set as default, unset other default methods
        if (request.IsDefault && !paymentMethod.IsDefault)
        {
            await UnsetDefaultPaymentMethodsAsync(userId, cancellationToken);
        }

        // Update fields
        if (!string.IsNullOrEmpty(request.MethodType))
            paymentMethod.MethodType = request.MethodType;

        if (!string.IsNullOrEmpty(request.AccountName))
            paymentMethod.AccountName = request.AccountName;

        if (!string.IsNullOrEmpty(request.AccountNumber))
            paymentMethod.MaskedAccountNumber = MaskAccountNumber(request.AccountNumber);

        if (request.ExpiryDate.HasValue)
            paymentMethod.ExpiryDate = request.ExpiryDate;

        paymentMethod.IsDefault = request.IsDefault;

        await _paymentMethodRepository.UpdateAsync(paymentMethod, cancellationToken);

        _logger.LogInformation("Updated payment method {PaymentMethodId} for user {UserId}",
            paymentMethod.Id, userId);

        return MapToDto(paymentMethod, request);
    }

    private async Task<PaymentMethodDto> DeletePaymentMethodAsync(Guid userId, ManagePaymentMethodCommand request, CancellationToken cancellationToken)
    {
        var paymentMethod = await _paymentMethodRepository.GetByIdAsync(request.PaymentMethodId!.Value, cancellationToken);

        if (paymentMethod == null || paymentMethod.UserId != userId)
        {
            throw new InvalidOperationException($"Payment method with ID {request.PaymentMethodId} not found or not owned by provider");
        }

        // Check if there are any pending transactions using this payment method
        var allTransactions = await _transactionRepository.GetAllAsync(cancellationToken);
        var hasActiveTransactions = allTransactions.Any(t => t.PaymentMethodId == paymentMethod.Id &&
                                                            (t.Status == TransactionStatus.Pending || t.Status == TransactionStatus.Escrowed));

        if (hasActiveTransactions)
        {
            throw new InvalidOperationException("Cannot delete payment method with active transactions");
        }

        var dto = MapToDto(paymentMethod, request);

        await _paymentMethodRepository.DeleteAsync(paymentMethod, cancellationToken);

        _logger.LogInformation("Deleted payment method {PaymentMethodId} for user {UserId}",
            paymentMethod.Id, userId);

        return dto;
    }

    private async Task<PaymentMethodDto> SetDefaultPaymentMethodAsync(Guid userId, ManagePaymentMethodCommand request, CancellationToken cancellationToken)
    {
        var paymentMethod = await _paymentMethodRepository.GetByIdAsync(request.PaymentMethodId!.Value, cancellationToken);

        if (paymentMethod == null || paymentMethod.UserId != userId)
        {
            throw new InvalidOperationException($"Payment method with ID {request.PaymentMethodId} not found or not owned by provider");
        }

        // Unset other default methods
        await UnsetDefaultPaymentMethodsAsync(userId, cancellationToken);

        // Set this as default
        paymentMethod.IsDefault = true;
        await _paymentMethodRepository.UpdateAsync(paymentMethod, cancellationToken);

        _logger.LogInformation("Set payment method {PaymentMethodId} as default for user {UserId}",
            paymentMethod.Id, userId);

        return MapToDto(paymentMethod, request);
    }

    private async Task UnsetDefaultPaymentMethodsAsync(Guid userId, CancellationToken cancellationToken)
    {
        var allMethods = await _paymentMethodRepository.GetAllAsync(cancellationToken);
        var defaultMethods = allMethods.Where(pm => pm.UserId == userId && pm.IsDefault).ToList();

        foreach (var method in defaultMethods)
        {
            method.IsDefault = false;
            await _paymentMethodRepository.UpdateAsync(method, cancellationToken);
        }
    }

    private static string? MaskAccountNumber(string? accountNumber)
    {
        if (string.IsNullOrEmpty(accountNumber) || accountNumber.Length <= 4)
            return accountNumber;

        return "****" + accountNumber.Substring(accountNumber.Length - 4);
    }

    private static PaymentMethodDto MapToDto(PaymentMethod paymentMethod, ManagePaymentMethodCommand request)
    {
        return new PaymentMethodDto
        {
            Id = paymentMethod.Id,
            MethodType = paymentMethod.MethodType,
            AccountNumber = paymentMethod.MaskedAccountNumber,
            BankName = request.BankName,
            PayPalEmail = request.PayPalEmail,
            IsDefault = paymentMethod.IsDefault,
            IsActive = true,
            CreatedAt = paymentMethod.CreatedAt
        };
    }
}
