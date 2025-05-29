using System.Diagnostics;
using UniConnect.Application.Common.Interfaces;

namespace UniConnect.API.Services;

public class TracingService : ITracingService
{
    private static readonly ActivitySource ActivitySource = new("UniConnect.API");
    private readonly ILogger<TracingService> _logger;

    public TracingService(ILogger<TracingService> logger)
    {
        _logger = logger;
    }

    public IDisposable? StartActivity(string activityName, Dictionary<string, object?>? tags = null)
    {
        var activity = ActivitySource.StartActivity(activityName, ActivityKind.Internal);

        if (activity != null && tags != null)
        {
            foreach (var tag in tags)
            {
                activity.SetTag(tag.Key, tag.Value);
            }
        }

        return activity;
    }

    public void SetActivityBaggage(string key, string value)
    {
        Activity.Current?.AddBaggage(key, value);
    }

    public void SetActivityTag(string key, object? value)
    {
        Activity.Current?.SetTag(key, value);
    }

    public void AddActivityEvent(string name, Dictionary<string, object?>? tags = null)
    {
        var activity = Activity.Current;
        if (activity != null)
        {
            var activityEvent = new ActivityEvent(name, tags: tags != null
                ? new ActivityTagsCollection(tags.Where(t => t.Value != null).Select(t =>
                    new KeyValuePair<string, object?>(t.Key, t.Value)))
                : null);

            activity.AddEvent(activityEvent);
        }
    }

    public void RecordException(Exception exception, Dictionary<string, object?>? additionalTags = null)
    {
        var activity = Activity.Current;
        if (activity != null)
        {
            var tags = new Dictionary<string, object?>
            {
                ["exception.type"] = exception.GetType().FullName,
                ["exception.message"] = exception.Message,
                ["exception.stacktrace"] = exception.ToString()
            };

            if (additionalTags != null)
            {
                foreach (var tag in additionalTags)
                {
                    tags[tag.Key] = tag.Value;
                }
            }

            AddActivityEvent("exception", tags);
            activity.SetStatus(ActivityStatusCode.Error, exception.Message);
        }

        _logger.LogError(exception, "An exception occurred");
    }
}
