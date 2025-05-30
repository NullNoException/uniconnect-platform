using FluentValidation;

namespace UniConnect.Application.Providers.Commands.VerifyProvider;

public class VerifyProviderCommandValidator : AbstractValidator<VerifyProviderCommand>
{
    public VerifyProviderCommandValidator()
    {
        RuleFor(x => x.ProviderId).NotEmpty();
        RuleFor(x => x.VerifiedByAdminId).NotEmpty();
    }
}
