using System.IO;
using System.Reflection;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using UniConnect.API.Services;
using UniConnect.Application.Common.Interfaces;

namespace UniConnect.API;

public static class DependencyInjection
{
    public static IServiceCollection AddApiServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDatabaseDeveloperPageExceptionFilter();

        services.AddSingleton<ICurrentUserService, CurrentUserService>();
        services.AddSingleton<ITracingService, TracingService>();

        services.AddHttpContextAccessor();

        // Add authorization policies
        services.AddAuthorization(options =>
        {
            // Customer area policies
            options.AddPolicy("CustomerPolicy", policy =>
                policy.RequireRole("Student", "Customer"));

            // Admin area policies
            options.AddPolicy("AdminPolicy", policy =>
                policy.RequireRole("Administrator", "Admin", "SuperAdmin"));

            // Control panel policies (broader access)
            options.AddPolicy("ControlPanelPolicy", policy =>
                policy.RequireRole("Staff", "Moderator", "Administrator", "Admin", "SuperAdmin", "SystemAdmin"));

            // Specific role policies
            options.AddPolicy("SuperAdminOnly", policy =>
                policy.RequireRole("SuperAdmin"));

            options.AddPolicy("AdminOrAbove", policy =>
                policy.RequireRole("Administrator", "Admin", "SuperAdmin"));

            options.AddPolicy("StaffOrAbove", policy =>
                policy.RequireRole("Staff", "Moderator", "Administrator", "Admin", "SuperAdmin"));
        });

        services.AddHealthChecks();

        // Add background services
        services.AddHostedService<MeiliSearchIndexInitializer>();

        // Database health checks will be registered in the Infrastructure layer
        // where the DbContext is defined

        // Configure Swagger
        services.AddSwaggerGen(options =>
        {
            options.SwaggerDoc("v1", new OpenApiInfo
            {
                Title = "UniConnect API",
                Version = "v1",
                Description = "UniConnect - A platform connecting university students with educational support providers",
                Contact = new OpenApiContact
                {
                    Name = "UniConnect Support",
                    Email = "support@uniconnect.com"
                }
            });

            // Add JWT authentication for Swagger
            var securityScheme = new OpenApiSecurityScheme
            {
                Name = "Authorization",
                Description = "JWT Authorization header using the Bearer scheme",
                In = ParameterLocation.Header,
                Type = SecuritySchemeType.Http,
                Scheme = "bearer",
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            };

            options.AddSecurityDefinition("Bearer", securityScheme);

            var securityRequirement = new OpenApiSecurityRequirement
            {
                { securityScheme, new[] { "Bearer" } }
            };

            options.AddSecurityRequirement(securityRequirement);

            // XML documentation
            var xmlFilename = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
            var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFilename);
            if (File.Exists(xmlPath))
            {
                options.IncludeXmlComments(xmlPath);
            }
        });

        return services;
    }
}
