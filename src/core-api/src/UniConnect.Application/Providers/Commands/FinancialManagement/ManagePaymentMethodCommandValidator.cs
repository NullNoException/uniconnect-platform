using FluentValidation;

namespace UniConnect.Application.Providers.Commands.FinancialManagement;

public class ManagePaymentMethodCommandValidator : AbstractValidator<ManagePaymentMethodCommand>
{
    public ManagePaymentMethodCommandValidator()
    {
        RuleFor(x => x.ProviderId)
            .NotEmpty()
            .WithMessage("Provider ID is required");

        RuleFor(x => x.Operation)
            .NotEmpty()
            .Must(op => new[] { "Create", "Update", "Delete", "SetDefault" }.Contains(op))
            .WithMessage("Operation must be one of: Create, Update, Delete, SetDefault");

        // For update, delete, and set default operations, PaymentMethodId is required
        RuleFor(x => x.PaymentMethodId)
            .NotEmpty()
            .When(x => x.Operation == "Update" || x.Operation == "Delete" || x.Operation == "SetDefault")
            .WithMessage("Payment Method ID is required for update, delete, and set default operations");

        // For create and update operations, validate payment method details
        When(x => x.Operation == "Create" || x.Operation == "Update", () =>
        {
            RuleFor(x => x.MethodType)
                .NotEmpty()
                .Must(type => new[] { "CreditCard", "BankAccount", "PayPal", "DebitCard", "WireTransfer" }.Contains(type))
                .WithMessage("Method type must be one of: CreditCard, BankAccount, PayPal, DebitCard, WireTransfer");

            RuleFor(x => x.AccountName)
                .NotEmpty()
                .MaximumLength(100)
                .WithMessage("Account name is required and must not exceed 100 characters");

            // Conditional validation based on method type
            RuleFor(x => x.AccountNumber)
                .NotEmpty()
                .When(x => x.MethodType == "CreditCard" || x.MethodType == "DebitCard" || x.MethodType == "BankAccount")
                .WithMessage("Account number is required for card and bank account methods");

            RuleFor(x => x.BankName)
                .NotEmpty()
                .When(x => x.MethodType == "BankAccount" || x.MethodType == "WireTransfer")
                .WithMessage("Bank name is required for bank account and wire transfer methods");

            RuleFor(x => x.PayPalEmail)
                .NotEmpty()
                .EmailAddress()
                .When(x => x.MethodType == "PayPal")
                .WithMessage("Valid PayPal email is required for PayPal payment method");

            RuleFor(x => x.ExpiryDate)
                .GreaterThan(DateTime.UtcNow)
                .When(x => x.ExpiryDate.HasValue && (x.MethodType == "CreditCard" || x.MethodType == "DebitCard"))
                .WithMessage("Expiry date must be in the future for card payment methods");
        });
    }
}
