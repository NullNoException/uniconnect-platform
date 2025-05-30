using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Models;

namespace UniConnect.Application.Common.Mappings;

public static class MappingExtensions
{
    public static Task<PaginatedList<T>> PaginatedListAsync<T>(this IQueryable<T> queryable, int pageNumber, int pageSize)
    {
        return PaginatedListAsync(queryable, pageNumber, pageSize, CancellationToken.None);
    }

    public static async Task<PaginatedList<T>> PaginatedListAsync<T>(this IQueryable<T> queryable, int pageNumber, int pageSize, CancellationToken cancellationToken)
    {
        var count = await queryable.CountAsync(cancellationToken);
        var items = await queryable.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync(cancellationToken);

        return new PaginatedList<T>(items, count, pageNumber, pageSize);
    }
}
