---
applyTo: '**/*.cs'
---

act as a Expert .Net Core Backend Developer and Senior Software architecture, with huge experience in API and System integration
Design a .NET Aspire solution using Clean Architecture and Modular Monolith principles.
Follow this structure:

- Core Domain layer with Entities, ValueObjects, and Aggregates (no external dependencies).
- Application layer with UseCases/Commands/Queries using the Vertical Slice architecture (CQRS with MediatR).
- Infrastructure layer for database access (EF Core), messaging (RabbitMQ or similar), and external services.
- API layer using minimal APIs or controllers for each feature slice.
- Group code into modules (e.g., Identity, Students, Billing) with their own Application, Domain, and Infrastructure folders.
- Use Vertical Slice Architecture: Each feature folder should contain Command/Query, Handler, Validator, and DTO.
- Implement dependency injection with scoped services in each module via extension methods.
- Keep each module decoupled and independently testable.
- Use FluentValidation for input validation and MediatR for orchestration.
  Generate all required code, keeping code clean, SOLID, and testable.
  Do not violate architecture boundaries — Domain should not reference Application or Infrastructure.

Design this solution as a Modular Monolith using Clean Architecture and Vertical Slice pattern.  
Each module (Customers, Admin, ServiceProvider) should follow Clean Architecture layering:

- Domain
- Application (MediatR-based Commands & Queries)
- Infrastructure
- API (minimal API or Controllers)

Each API project should only expose relevant endpoints for its target audience:

- Customers.API: public-facing endpoints for users
- Admin.API: restricted endpoints for administrators
- ServiceProvider.API: endpoints for vendors/providers

Follow separation of concerns. Do not share infrastructure directly across modules; only share through contracts.

🔸 MinIO Object Storage

- Create a service implementing IStorageService using the Minio .NET SDK.
- Include methods to UploadAsync(), DownloadAsync(), and DeleteAsync().
- Ensure the bucket exists before file operations.
- Load endpoint, access key, and secret from appsettings.json.

🔸 Keycloak Authentication

- Configure JWT Bearer authentication using Keycloak.
- Load Authority, Realm, and Audience from configuration.
- Validate roles and map them to ASP.NET Core policies.
- Support both admin and provider API segregation via authorization attributes.

🔸 Jaeger Distributed Tracing

- Use OpenTelemetry to set up distributed tracing.
- Export traces to Jaeger based on endpoint in config.
- Instrument ASP.NET Core, EF Core, and HttpClient automatically.
- Assign consistent service names and include TraceId in logging context.

🔸 PostgreSQL with EF Core

- Configure PostgreSQL as the main DB using Entity Framework Core.
- Apply snake_case naming convention to table and column names.
- Use IEntityTypeConfiguration for modular entity setup.
- Handle migrations using EF CLI and register AppDbContext with dependency injection.

🔸 Redis Cache

- Wrap Redis IDistributedCache into ICacheService interface.
- Provide methods for GetAsync<T>(), SetAsync<T>(), RemoveAsync() with optional expiration.
- Read Redis configuration from appsettings.json and support connection pooling.

🔸 Meilisearch Full-Text Search

- Create an ISearchService interface.
- Implement Meilisearch integration with index, search, and delete document methods.
- Configure the Meilisearch host URL and API key via appsettings.json.
- Initialize indexes like Courses and Providers at startup if not already created.

Ensure all services are cleanly separated in the Infrastructure layer and registered via DI in Startup/Program.cs.
