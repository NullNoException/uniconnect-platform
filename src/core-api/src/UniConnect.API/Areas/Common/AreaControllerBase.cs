using Microsoft.AspNetCore.Mvc;
using UniConnect.Application.Common.Models;

namespace UniConnect.API.Areas.Common;

[ApiController]
public abstract class AreaControllerBase : ControllerBase
{
    protected ActionResult<TResult> HandleResult<TResult>(Result<TResult> result)
    {
        if (result.Succeeded && result.Data != null)
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

    protected ActionResult<PaginatedResponse<TResult>> HandlePaginatedResult<TResult>(PaginatedList<TResult> result)
    {
        return Ok(new PaginatedResponse<TResult>
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

public class PaginatedResponse<T>
{
    public IEnumerable<T> Items { get; set; } = new List<T>();
    public int PageNumber { get; set; }
    public int TotalPages { get; set; }
    public int TotalCount { get; set; }
    public bool HasPreviousPage { get; set; }
    public bool HasNextPage { get; set; }
}
