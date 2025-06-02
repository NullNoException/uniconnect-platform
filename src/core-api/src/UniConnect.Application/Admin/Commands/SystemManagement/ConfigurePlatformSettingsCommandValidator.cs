using FluentValidation;

namespace UniConnect.Application.Admin.Commands.SystemManagement;

public class ConfigurePlatformSettingsCommandValidator : AbstractValidator<ConfigurePlatformSettingsCommand>
{
    public ConfigurePlatformSettingsCommandValidator()
    {
        RuleFor(x => x.AdminId)
            .NotEmpty()
            .WithMessage("Admin ID is required");

        RuleFor(x => x.SettingCategory)
            .NotEmpty()
            .WithMessage("Setting category is required")
            .MaximumLength(100)
            .WithMessage("Setting category must not exceed 100 characters");

        RuleFor(x => x.Settings)
            .NotEmpty()
            .WithMessage("At least one setting must be provided");
    }
}
