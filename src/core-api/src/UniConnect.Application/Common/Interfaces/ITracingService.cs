namespace UniConnect.Application.Common.Interfaces;

public interface ITracingService
{
    /// <summary>
    /// Starts a new activity with the given name and optional tags.
    /// </summary>
    /// <param name="activityName">The name of the activity.</param>
    /// <param name="tags">Optional tags to add to the activity.</param>
    /// <returns>A disposable that ends the activity when disposed.</returns>
    IDisposable? StartActivity(string activityName, Dictionary<string, object?>? tags = null);

    /// <summary>
    /// Sets baggage on the current activity.
    /// </summary>
    /// <param name="key">The baggage key.</param>
    /// <param name="value">The baggage value.</param>
    void SetActivityBaggage(string key, string value);

    /// <summary>
    /// Sets a tag on the current activity.
    /// </summary>
    /// <param name="key">The tag key.</param>
    /// <param name="value">The tag value.</param>
    void SetActivityTag(string key, object? value);

    /// <summary>
    /// Adds an event to the current activity.
    /// </summary>
    /// <param name="name">The name of the event.</param>
    /// <param name="tags">Optional tags for the event.</param>
    void AddActivityEvent(string name, Dictionary<string, object?>? tags = null);

    /// <summary>
    /// Records an exception on the current activity.
    /// </summary>
    /// <param name="exception">The exception to record.</param>
    /// <param name="additionalTags">Optional additional tags to add.</param>
    void RecordException(Exception exception, Dictionary<string, object?>? additionalTags = null);
}
