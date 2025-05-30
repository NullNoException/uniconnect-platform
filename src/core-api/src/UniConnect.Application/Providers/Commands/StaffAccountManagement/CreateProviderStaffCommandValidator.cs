using FluentValidation;

namespace UniConnect.Application.Providers.Commands.StaffAccountManagement;

public class CreateProviderStaffCommandValidator : AbstractValidator<CreateProviderStaffCommand>
{
    public CreateProviderStaffCommandValidator()
    {
        RuleFor(x => x.ProviderId).NotEmpty();
        RuleFor(x => x.Email).NotEmpty().EmailAddress();
        RuleFor(x => x.FirstName).NotEmpty();
        RuleFor(x => x.LastName).NotEmpty();
    }
}
