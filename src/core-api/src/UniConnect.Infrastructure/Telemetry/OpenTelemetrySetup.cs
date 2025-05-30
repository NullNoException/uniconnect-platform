using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using System.Diagnostics;
using OpenTelemetry.Instrumentation.EntityFrameworkCore;

namespace UniConnect.Infrastructure.Telemetry;

public static class OpenTelemetrySetup
{
    public static IServiceCollection AddOpenTelemetryServices(this IServiceCollection services, IConfiguration configuration)
    {
        // Early exit for test environments
        if (configuration.GetValue<bool>("UseInMemoryDatabase", false) ||
            !configuration.GetSection("JaegerSettings").GetValue<bool>("Enabled", true))
        {
            // For test environments, just return the services without adding OpenTelemetry
            return services;
        }

        var resourceBuilder = ResourceBuilder.CreateDefault()
            .AddService(serviceName: "UniConnect.API", serviceVersion: "1.0.0")
            .AddTelemetrySdk()
            .AddEnvironmentVariableDetector();

        // Configure OpenTelemetry tracing
        services.AddOpenTelemetry()
            .WithTracing(builder => ConfigureTracing(builder, configuration, resourceBuilder))
            .WithMetrics(builder => ConfigureMetrics(builder, resourceBuilder));

        return services;
    }

    private static void ConfigureTracing(TracerProviderBuilder builder, IConfiguration configuration, ResourceBuilder resourceBuilder)
    {
        builder
            .SetResourceBuilder(resourceBuilder)
            .AddSource("UniConnect.API")
            .AddHttpClientInstrumentation(options =>
            {
                options.RecordException = true;
            })
            .AddAspNetCoreInstrumentation(options =>
            {
                options.RecordException = true;
                options.EnrichWithHttpRequest = (activity, httpRequest) =>
                {
                    activity.SetTag("http.host", httpRequest.Host.Value);
                    activity.SetTag("http.scheme", httpRequest.Scheme);
                };
                options.EnrichWithHttpResponse = (activity, httpResponse) =>
                {
                    activity.SetTag("http.status_code", httpResponse.StatusCode);
                };
                options.Filter = (httpContext) =>
                {
                    // Exclude health check and swagger endpoints from telemetry
                    return !httpContext.Request.Path.StartsWithSegments("/health") &&
                           !httpContext.Request.Path.StartsWithSegments("/swagger");
                };
            })
            .AddEntityFrameworkCoreInstrumentation(options =>
            {
                options.SetDbStatementForText = true;
                options.SetDbStatementForStoredProcedure = true;
            });

        // Add Jaeger Exporter if configured and enabled
        var jaegerSettings = configuration.GetSection("JaegerSettings");
        if (jaegerSettings.Exists() &&
            jaegerSettings.GetValue<bool>("Enabled", true) &&
            !string.IsNullOrEmpty(jaegerSettings["Host"]))
        {
            builder.AddJaegerExporter(options =>
            {
                options.AgentHost = jaegerSettings["Host"];
                options.AgentPort = int.TryParse(jaegerSettings["Port"], out int port) ? port : 6831;
            });
        }
    }

    private static void ConfigureMetrics(MeterProviderBuilder builder, ResourceBuilder resourceBuilder)
    {
        builder
            .SetResourceBuilder(resourceBuilder)
            .AddMeter("UniConnect.API")
            .AddAspNetCoreInstrumentation()
            .AddHttpClientInstrumentation();
    }
}
