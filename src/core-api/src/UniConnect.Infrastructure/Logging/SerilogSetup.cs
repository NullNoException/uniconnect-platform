using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Serilog;
using Serilog.Events;
using Serilog.Exceptions;
using System.Diagnostics;

namespace UniConnect.Infrastructure.Logging;

public static class SerilogSetup
{
    public static IHostBuilder UseSerilogLogging(this IHostBuilder hostBuilder)
    {
        return hostBuilder.UseSerilog((context, services, loggerConfiguration) =>
        {
            var environment = context.HostingEnvironment;
            var config = context.Configuration;

            loggerConfiguration
                .ReadFrom.Configuration(config)
                .ReadFrom.Services(services)
                .Enrich.FromLogContext()
                .Enrich.WithExceptionDetails()
                .Enrich.WithMachineName()
                .Enrich.WithEnvironmentName()
                .Enrich.WithProperty("ApplicationName", "UniConnect.API")
                .Enrich.WithProperty("TraceId", () => Activity.Current?.Id ?? string.Empty)
                .Enrich.WithProperty("SpanId", () => Activity.Current?.SpanId.ToString() ?? string.Empty)
                .MinimumLevel.Information()
                .MinimumLevel.Override("Microsoft", LogEventLevel.Warning)
                .MinimumLevel.Override("System", LogEventLevel.Warning)
                .MinimumLevel.Override("Microsoft.AspNetCore.Authentication", LogEventLevel.Information)
                .WriteTo.Console();

            if (!environment.IsProduction())
            {
                loggerConfiguration
                    .MinimumLevel.Debug()
                    .MinimumLevel.Override("Microsoft", LogEventLevel.Information)
                    .WriteTo.Console(outputTemplate: "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:lj}{NewLine}{Exception}");
            }

            // Also write logs to a file for Seq (to be picked up)
            loggerConfiguration.WriteTo.File(
                "logs/uniconnect-.log",
                rollingInterval: RollingInterval.Day,
                fileSizeLimitBytes: 10 * 1024 * 1024,
                retainedFileCountLimit: 30,
                outputTemplate: "{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] {Message:lj}{NewLine}{Exception}");

            // If Seq is configured
            var seqServerUrl = config["Seq:ServerUrl"];
            if (!string.IsNullOrEmpty(seqServerUrl))
            {
                loggerConfiguration.WriteTo.Seq(seqServerUrl);
            }
        });
    }
}
