using System;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Infrastructure.Persistence.Interceptors;

namespace UniConnect.UnitTests.Infrastructure
{
    public class TestCurrentUserService : ICurrentUserService
    {
        public string? UserId => "test-user";
        public string? UserEmail => "test@example.com";
        public bool IsAuthenticated => true;
        public bool IsInRole(string role) => false;
    }

    public class TestDateTime : IDateTime
    {
        public DateTime Now => new DateTime(2025, 5, 31, 12, 0, 0);
        public DateTime UtcNow => new DateTime(2025, 5, 31, 12, 0, 0);
    }

    public static class TestAuditableEntitySaveChangesInterceptorFactory
    {
        public static AuditableEntitySaveChangesInterceptor Create()
        {
            return new AuditableEntitySaveChangesInterceptor(new TestCurrentUserService(), new TestDateTime());
        }
    }
}
