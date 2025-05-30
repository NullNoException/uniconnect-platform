using UniConnect.Application.Common.Interfaces;

namespace UniConnect.IntegrationTests.Services;

/// <summary>
/// A test implementation of the IDateTime service that always returns UTC dates
/// to ensure compatibility with PostgreSQL's timestamp with time zone.
/// </summary>
public class TestDateTimeService : IDateTime
{
    // Always return UTC times to avoid PostgreSQL DateTime kind issues
    public DateTime Now => DateTime.UtcNow;
    public DateTime UtcNow => DateTime.UtcNow;
}
