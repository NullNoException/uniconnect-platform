using Microsoft.AspNetCore.Http;
using Serilog;
using System;
using System.Threading.Tasks;
using UniConnect.API;
using UniConnect.Application;
using UniConnect.Infrastructure;
using UniConnect.Infrastructure.Logging;
using UniConnect.Infrastructure.Persistence;

// Check if we're in testing environment
var isTestingEnvironment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Testing";
var useSerilog = !isTestingEnvironment && (Environment.GetEnvironmentVariable("DISABLE_SERILOG") != "true");

// Only initialize the logger in non-test environments
if (useSerilog)
{
    try
    {
        // Create a minimal bootstrap logger for startup only - will be replaced by full configuration
        Log.Logger = new LoggerConfiguration()
            .WriteTo.Console()
            .CreateBootstrapLogger();
    }
    catch (Exception ex)
    {
        // Ignore already frozen logger errors during bootstrap
        Console.WriteLine($"Warning: {ex.Message}");
    }
}

try
{
    if (useSerilog)
    {
        Log.Information("Starting UniConnect API");
    }

    var builder = WebApplication.CreateBuilder(args);

    // Use Serilog for logging only in non-test environments
    if (useSerilog && builder.Configuration.GetValue<bool>("UseSerilog", true))
    {
        // Avoid adding Serilog again if it's already configured
        builder.Host.UseSerilogLogging();
    }

    // Add services to the container
    builder.Services.AddApplicationInsightsTelemetry();

    // Add API services
    builder.Services.AddApiServices(builder.Configuration);

    // Add Application layer services
    builder.Services.AddApplication();

    // Add Infrastructure layer services
    builder.Services.AddInfrastructure(builder.Configuration);

    // Add controllers with Areas support
    builder.Services.AddControllers();

    // Add API Explorer for Swagger
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen();

    // Add Areas support
    builder.Services.AddMvc().AddControllersAsServices();

    // Add CORS
    builder.Services.AddCors(options =>
    {
        options.AddPolicy("AllowSpecificOrigins",
            builder => builder
                .WithOrigins(
                    "http://localhost:3000", // Frontend development
                    "https://uniconnect.com") // Production frontend
                .AllowAnyHeader()
                .AllowAnyMethod());
    });

    // Build application
    var app = builder.Build();

    // Configure the HTTP request pipeline
    if (app.Environment.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();

        // Initialize and seed database (skip for integration tests)
        var skipDbInit = app.Configuration.GetValue<bool>("SkipDbInitialization");
        if (!skipDbInit)
        {
            using (var scope = app.Services.CreateScope())
            {
                var initialiser = scope.ServiceProvider.GetRequiredService<ApplicationDbContextInitialiser>();
                await initialiser.InitialiseAsync();
                await initialiser.SeedAsync();
            }
        }
    }
    else
    {
        app.UseHsts();
    }

    // Configure middleware
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "UniConnect API v1");
        options.RoutePrefix = string.Empty; // Serve Swagger UI at application root
    });

    app.UseHttpsRedirection();
    app.UseStaticFiles();
    app.UseRouting();

    app.UseCors("AllowSpecificOrigins");

    app.UseAuthentication();
    app.UseAuthorization();

    // Map controllers with Areas support
    app.MapControllers();

    // Map Areas routes explicitly for better routing
    app.MapControllerRoute(
        name: "areas",
        pattern: "api/{area:exists}/v{version:int}/{controller=Home}/{action=Index}/{id?}");

    app.MapControllerRoute(
        name: "default",
        pattern: "api/v{version:int}/{controller}/{action=Index}/{id?}");

    // Map health checks endpoints
    app.MapHealthChecks("/health");
    app.MapHealthChecks("/health/ready", new Microsoft.AspNetCore.Diagnostics.HealthChecks.HealthCheckOptions
    {
        Predicate = check => check.Tags.Contains("ready"),
        ResponseWriter = async (context, report) =>
        {
            context.Response.ContentType = "text/plain";
            await context.Response.WriteAsync($"Status: {report.Status}");
        }
    });
    app.MapHealthChecks("/health/live", new Microsoft.AspNetCore.Diagnostics.HealthChecks.HealthCheckOptions
    {
        Predicate = _ => false,  // No checks for liveness probe, just return 200 OK
        ResponseWriter = async (context, report) =>
        {
            context.Response.ContentType = "text/plain";
            await context.Response.WriteAsync($"Status: {report.Status}");
        }
    });

    await app.RunAsync();
}
catch (Exception ex)
{
    if (useSerilog)
    {
        Log.Fatal(ex, "An unhandled exception occurred during bootstrapping");
    }
    throw;
}
finally
{
    if (useSerilog)
    {
        Log.CloseAndFlush();
    }
}

// Make Program class accessible for integration tests
public partial class Program { }
