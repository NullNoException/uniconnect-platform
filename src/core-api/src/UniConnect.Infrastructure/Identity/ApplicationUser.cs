using Microsoft.AspNetCore.Identity;

namespace UniConnect.Infrastructure.Identity;

public class ApplicationUser : IdentityUser
{
    // Add custom properties for ASP.NET Core Identity User
    public bool IsActive { get; set; } = true;
    public DateTime? LastLogin { get; set; }
}
