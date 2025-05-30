using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using Microsoft.AspNetCore.Mvc.Controllers;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Text.RegularExpressions;

namespace UniConnect.API.Common.SwaggerConfig;

/// <summary>
/// Resolves conflicting action paths by considering the area name in the path.
/// </summary>
public class ConflictingActionsResolver : IOperationFilter
{
    private const string AdminAreaName = "Admin";
    private const string CustomerAreaName = "Customer";

    public void Apply(Microsoft.OpenApi.Models.OpenApiOperation operation, OperationFilterContext context)
    {
        // If the controller is from an area, add the area to the path tag
        if (context.ApiDescription.ActionDescriptor is ControllerActionDescriptor descriptor)
        {
            var controllerTypeInfo = descriptor.ControllerTypeInfo;
            var areaAttribute = controllerTypeInfo.GetCustomAttributes(typeof(AreaAttribute), true)
                .OfType<AreaAttribute>()
                .FirstOrDefault();

            if (areaAttribute != null)
            {
                // Add area to operationId to avoid conflicts in generated client code
                operation.OperationId = $"{areaAttribute.RouteValue}_{operation.OperationId}";

                // Group operations by area
                if (operation.Tags == null)
                {
                    operation.Tags = new List<Microsoft.OpenApi.Models.OpenApiTag>();
                }

                // Add area as a tag
                operation.Tags.Add(new Microsoft.OpenApi.Models.OpenApiTag { Name = areaAttribute.RouteValue });
            }
        }
    }
}
