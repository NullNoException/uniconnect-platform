using FluentValidation;

namespace UniConnect.Application.Providers.Commands.ServiceManagement;

public class CreateServiceListingCommandValidator : AbstractValidator<CreateServiceListingCommand>
{
    public CreateServiceListingCommandValidator()
    {
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

public class ServiceAttributeDtoValidator : AbstractValidator<ServiceAttributeDto>
{
    public ServiceAttributeDtoValidator()
    {
        RuleFor(x => x.AttributeKey)
            .NotEmpty()
            .WithMessage("Attribute key is required")
            .MaximumLength(100)
            .WithMessage("Attribute key cannot exceed 100 characters");

        RuleFor(x => x.AttributeValue)
            .NotEmpty()
            .WithMessage("Attribute value is required")
            .MaximumLength(500)
            .WithMessage("Attribute value cannot exceed 500 characters");
    }
}

public class ServiceRequirementDtoValidator : AbstractValidator<ServiceRequirementDto>
{
    public ServiceRequirementDtoValidator()
    {
        RuleFor(x => x.RequirementName)
            .NotEmpty()
            .WithMessage("Requirement name is required")
            .MaximumLength(256)
            .WithMessage("Requirement name cannot exceed 256 characters");

        RuleFor(x => x.RequirementDescription)
            .MaximumLength(1000)
            .WithMessage("Requirement description cannot exceed 1000 characters");
    }
}

public class ServicePriceComponentDtoValidator : AbstractValidator<ServicePriceComponentDto>
{
    public ServicePriceComponentDtoValidator()
    {
        RuleFor(x => x.ComponentName)
            .NotEmpty()
            .WithMessage("Component name is required")
            .MaximumLength(100)
            .WithMessage("Component name cannot exceed 100 characters");

        RuleFor(x => x.ComponentDescription)
            .MaximumLength(500)
            .WithMessage("Component description cannot exceed 500 characters");

        RuleFor(x => x.Price)
            .GreaterThanOrEqualTo(0)
            .WithMessage("Price must be greater than or equal to 0");
    }
}
