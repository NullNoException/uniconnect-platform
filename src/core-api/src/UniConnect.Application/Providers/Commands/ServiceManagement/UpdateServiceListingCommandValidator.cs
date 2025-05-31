using FluentValidation;

namespace UniConnect.Application.Providers.Commands.ServiceManagement;

public class UpdateServiceListingCommandValidator : AbstractValidator<UpdateServiceListingCommand>
{
    public UpdateServiceListingCommandValidator()
    {
        RuleFor(x => x.ServiceId)
            .NotEmpty()
            .WithMessage("Service ID is required");

        RuleFor(x => x.ProviderId)
            .NotEmpty()
            .WithMessage("Provider ID is required");

        RuleFor(x => x.CategoryId)
            .NotEmpty()
            .WithMessage("Category ID is required");

        RuleFor(x => x.ServiceName)
            .NotEmpty()
            .WithMessage("Service name is required")
            .MaximumLength(256)
            .WithMessage("Service name cannot exceed 256 characters");

        RuleFor(x => x.Description)
            .MaximumLength(2000)
            .WithMessage("Description cannot exceed 2000 characters");

        RuleFor(x => x.ShortDescription)
            .MaximumLength(500)
            .WithMessage("Short description cannot exceed 500 characters");

        RuleFor(x => x.BasePrice)
            .GreaterThanOrEqualTo(0)
            .WithMessage("Base price must be greater than or equal to 0");

        RuleFor(x => x.CurrencyId)
            .NotEmpty()
            .WithMessage("Currency ID is required");

        RuleFor(x => x.EstimatedDeliveryDays)
            .GreaterThan(0)
            .When(x => x.EstimatedDeliveryDays.HasValue)
            .WithMessage("Estimated delivery days must be greater than 0");

        RuleForEach(x => x.Attributes)
            .SetValidator(new ServiceAttributeDtoValidator());

        RuleForEach(x => x.Requirements)
            .SetValidator(new ServiceRequirementDtoValidator());

        RuleForEach(x => x.PriceComponents)
            .SetValidator(new ServicePriceComponentDtoValidator());
    }
}
