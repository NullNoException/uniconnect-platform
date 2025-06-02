using FluentValidation;

namespace UniConnect.Application.Admin.Commands.ServiceManagement;

public class ManageServiceCategoryCommandValidator : AbstractValidator<ManageServiceCategoryCommand>
{
    public ManageServiceCategoryCommandValidator()
    {
        RuleFor(x => x.CategoryName)
            .NotEmpty()
            .When(x => x.Operation == ServiceCategoryOperation.Create || x.Operation == ServiceCategoryOperation.Update)
            .WithMessage("Category name is required for create and update operations")
            .MaximumLength(100)
            .WithMessage("Category name must not exceed 100 characters");

        RuleFor(x => x.Description)
            .MaximumLength(500)
            .When(x => !string.IsNullOrEmpty(x.Description))
            .WithMessage("Description must not exceed 500 characters");

        RuleFor(x => x.SortOrder)
            .GreaterThanOrEqualTo(0)
            .WithMessage("Sort order must be a non-negative number");

        RuleFor(x => x.CategoryId)
            .NotEmpty()
            .When(x => x.Operation != ServiceCategoryOperation.Create)
            .WithMessage("Category ID is required for update, delete, activate, and deactivate operations");

        RuleFor(x => x.AdminId)
            .NotEmpty()
            .WithMessage("Admin ID is required");

        RuleFor(x => x.Operation)
            .IsInEnum()
            .WithMessage("Invalid operation specified");
    }
}
