using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Text.RegularExpressions;

namespace UniConnect.API.Common.SwaggerConfig;

/// <summary>
/// Represents the Swagger/Swashbuckle operation filter used to document the implicit API version parameter.
/// </summary>
public class SwaggerDefaultValues : IOperationFilter
{
    /// <summary>
    /// Applies the filter to the specified operation using the given context.
    /// </summary>
    /// <param name="operation">The operation to apply the filter to.</param>
    /// <param name="context">The current operation filter context.</param>
    public void Apply(OpenApiOperation operation, OperationFilterContext context)
    {
        var apiDescription = context.ApiDescription;

        var controllerActionDescriptor = context.ApiDescription.ActionDescriptor as ControllerActionDescriptor;
        if (controllerActionDescriptor == null)
        {
            return;
        }

        // Add controller name to operation ID to make it unique
        var controllerName = controllerActionDescriptor.ControllerName;
        var actionName = controllerActionDescriptor.ActionName;

        // Check if controller is in an area
        var areaName = controllerActionDescriptor.RouteValues.TryGetValue("area", out var area) ? area : string.Empty;
        if (!string.IsNullOrEmpty(areaName))
        {
            // Add area name to operationId to ensure uniqueness
            operation.OperationId = $"{areaName}_{controllerName}_{actionName}";
        }
        else
        {
            operation.OperationId = $"{controllerName}_{actionName}";
        }

        // Add tags based on area
        if (!string.IsNullOrEmpty(areaName))
        {
            operation.Tags = new List<OpenApiTag> { new OpenApiTag { Name = areaName } };
        }

        // Set operation.Deprecated based on ObsoleteAttribute
        if (apiDescription.TryGetMethodInfo(out var methodInfo) && methodInfo.GetCustomAttributes(typeof(ObsoleteAttribute), false).Any())
        {
            operation.Deprecated = true;
        }
    }
}
