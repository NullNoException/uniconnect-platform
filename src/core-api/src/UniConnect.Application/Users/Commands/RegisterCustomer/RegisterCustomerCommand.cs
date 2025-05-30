using MediatR;

namespace UniConnect.Application.Users.Commands.RegisterCustomer;

public record RegisterCustomerCommand(
    string Email,
    string Password,
    string ConfirmPassword,
    string FirstName,
    string LastName,
    string PhoneNumber,
    string PreferredLanguage,
    bool AgreeToTerms
) : IRequest<Guid>;
