namespace UniConnect.Application.Common.Interfaces;

public interface ISemesterStatusService
{
    /// <summary>
    /// Automatically updates semester statuses based on current date
    /// </summary>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Task representing the asynchronous operation</returns>
    Task UpdateSemesterStatusesAsync(CancellationToken cancellationToken = default);
}
