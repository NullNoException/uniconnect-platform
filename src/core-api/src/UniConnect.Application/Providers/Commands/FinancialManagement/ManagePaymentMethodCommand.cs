using MediatR;
using UniConnect.Application.Providers.DTOs;

namespace UniConnect.Application.Providers.Commands.FinancialManagement;

public record ManagePaymentMethodCommand : IRequest<PaymentMethodDto>
{
    public Guid? PaymentMethodId { get; init; } // null for create, set for update/delete
    public Guid ProviderId { get; init; }
    public string Operation { get; init; } = string.Empty; // "Create", "Update", "Delete", "SetDefault"
    public string? MethodType { get; init; } // "CreditCard", "BankAccount", "PayPal", etc.
    public string? AccountName { get; init; }
    public string? AccountNumber { get; init; }
    public string? BankName { get; init; }
    public string? PayPalEmail { get; init; }
    public DateTime? ExpiryDate { get; init; }
    public bool IsDefault { get; init; }
}
