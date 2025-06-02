using Microsoft.AspNetCore.Mvc;
using UniConnect.Application.Common.Models;

namespace UniConnect.API.Common;

[ApiController]
public abstract class AreaControllerBase : ControllerBase
{
    protected ActionResult<TResult> HandleResult<TResult>(Result<TResult> result)
    {
        if (result.Succeeded && !EqualityComparer<TResult>.Default.Equals(result.Data, default))
            return Ok(result.Data);

        if (result.Succeeded)
            return NoContent();

        if (result.Errors.Contains("NotFound"))
            return NotFound();

        return BadRequest(result.Errors);
    }

    protected ActionResult HandleResult(Result result)
    {
        if (result.Succeeded)
            return NoContent();

        if (result.Errors.Contains("NotFound"))
            return NotFound();

        return BadRequest(result.Errors);
    }

    protected ActionResult<PaginatedResponse<T>> HandlePaginatedResult<T>(PaginatedResponse<T> result)
    {
        if (result.Items.Count == 0 && result.TotalCount == 0)
            return NotFound();

        return Ok(result);
    }

    protected ActionResult<PaginatedResponse<T>> HandlePaginatedResult<T>(PaginatedList<T> result)
    {
        if (result.Items.Count == 0 && result.TotalCount == 0)
            return NotFound();

        return Ok(new PaginatedResponse<T>
        {
            Items = result.Items,
            PageNumber = result.PageNumber,
            TotalPages = result.TotalPages,
            TotalCount = result.TotalCount,
            HasPreviousPage = result.HasPreviousPage,
            HasNextPage = result.HasNextPage
        });
    }
}
