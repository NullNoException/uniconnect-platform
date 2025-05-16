using FluentValidation;

namespace UniConnect.Application.Users.Queries;

public class GetUsersWithPaginationQueryValidator : AbstractValidator<GetUsersWithPaginationQuery>
{
    public GetUsersWithPaginationQueryValidator()
    {
        RuleFor(x => x.PageNumber)
            .GreaterThanOrEqualTo(1).WithMessage("PageNumber must be greater than or equal to 1.");

        RuleFor(x => x.PageSize)
            .GreaterThanOrEqualTo(1).WithMessage("PageSize must be greater than or equal to 1.")
            .LessThanOrEqualTo(100).WithMessage("PageSize must be less than or equal to 100.");
    }
}
