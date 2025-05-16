using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Logging;
using UniConnect.Domain.Entities;
using UniConnect.Infrastructure.Identity;

namespace UniConnect.Infrastructure.Persistence;

public class ApplicationDbContextInitialiser
{
    private readonly ILogger<ApplicationDbContextInitialiser> _logger;
    private readonly ApplicationDbContext _context;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;

    public ApplicationDbContextInitialiser(
        ILogger<ApplicationDbContextInitialiser> logger,
        ApplicationDbContext context,
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager)
    {
        _logger = logger;
        _context = context;
        _userManager = userManager;
        _roleManager = roleManager;
    }

    public async Task InitialiseAsync()
    {
        try
        {
            if (_context.Database.ProviderName?.Contains("Npgsql") == true)
            {
                await _context.Database.MigrateAsync();
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred while initialising the database");
            throw;
        }
    }

    public async Task SeedAsync()
    {
        try
        {
            await TrySeedAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred while seeding the database");
            throw;
        }
    }

    private async Task TrySeedAsync()
    {
        // Default roles
        var roles = new[] { "Admin", "Student", "ServiceProvider", "ProviderStaff" };

        foreach (var role in roles)
        {
            if (!await _roleManager.RoleExistsAsync(role))
            {
                await _roleManager.CreateAsync(new IdentityRole(role));
                _logger.LogInformation("Created role {Role}", role);
            }
        }

        // Default admin user
        var adminEmail = "admin@uniconnect.com";
        var adminUser = await _userManager.FindByEmailAsync(adminEmail);

        if (adminUser == null)
        {
            adminUser = new ApplicationUser
            {
                UserName = adminEmail,
                Email = adminEmail,
                EmailConfirmed = true
            };

            await _userManager.CreateAsync(adminUser, "Admin@123");
            await _userManager.AddToRoleAsync(adminUser, "Admin");

            _logger.LogInformation("Created admin user {Email}", adminEmail);

            // Create domain entities for the admin user
            var user = new User
            {
                Id = Guid.Parse(adminUser.Id),
                Email = adminEmail,
                UserType = Domain.Enums.UserType.Admin,
                Status = Domain.Enums.UserStatus.Active,
                CreatedAt = DateTime.UtcNow,
                CreatedBy = adminUser.Id
            };

            await _context.Users.AddAsync(user);

            var profile = new UserProfile
            {
                UserId = user.Id,
                FirstName = "System",
                LastName = "Administrator",
                PreferredLanguage = "en",
                CreatedAt = DateTime.UtcNow,
                CreatedBy = adminUser.Id
            };

            await _context.UserProfiles.AddAsync(profile);

            var admin = new Admin
            {
                UserId = user.Id,
                Role = "System Administrator",
                Department = "IT",
                CreatedAt = DateTime.UtcNow,
                CreatedBy = adminUser.Id
            };

            await _context.Admins.AddAsync(admin);
            await _context.SaveChangesAsync();
        }

        // Seed basic data for testing purposes
        if (!_context.Countries.Any())
        {
            await _context.Countries.AddRangeAsync(
                new Country { CountryName = "United States", CountryCode = "US", PhoneCode = "1", Currency = "USD", CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Country { CountryName = "United Kingdom", CountryCode = "GB", PhoneCode = "44", Currency = "GBP", CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Country { CountryName = "Australia", CountryCode = "AU", PhoneCode = "61", Currency = "AUD", CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Country { CountryName = "Canada", CountryCode = "CA", PhoneCode = "1", Currency = "CAD", CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Country { CountryName = "Germany", CountryCode = "DE", PhoneCode = "49", Currency = "EUR", CreatedAt = DateTime.UtcNow, CreatedBy = "system" }
            );

            await _context.SaveChangesAsync();
            _logger.LogInformation("Seeded countries data");
        }

        if (!_context.Currencies.Any())
        {
            await _context.Currencies.AddRangeAsync(
                new Currency { CurrencyCode = "USD", CurrencyName = "US Dollar", CurrencySymbol = "$", IsActive = true, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Currency { CurrencyCode = "EUR", CurrencyName = "Euro", CurrencySymbol = "€", IsActive = true, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Currency { CurrencyCode = "GBP", CurrencyName = "British Pound", CurrencySymbol = "£", IsActive = true, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Currency { CurrencyCode = "AUD", CurrencyName = "Australian Dollar", CurrencySymbol = "A$", IsActive = true, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new Currency { CurrencyCode = "CAD", CurrencyName = "Canadian Dollar", CurrencySymbol = "C$", IsActive = true, CreatedAt = DateTime.UtcNow, CreatedBy = "system" }
            );

            await _context.SaveChangesAsync();
            _logger.LogInformation("Seeded currencies data");
        }

        if (!_context.ServiceCategories.Any())
        {
            await _context.ServiceCategories.AddRangeAsync(
                new ServiceCategory { CategoryName = "University Applications", Description = "Services related to university application submissions", IconUrl = "university-icon.png", IsActive = true, DisplayOrder = 1, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new ServiceCategory { CategoryName = "Visa Services", Description = "Services related to student visa applications and support", IconUrl = "visa-icon.png", IsActive = true, DisplayOrder = 2, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new ServiceCategory { CategoryName = "Accommodation", Description = "Services for finding student accommodation", IconUrl = "housing-icon.png", IsActive = true, DisplayOrder = 3, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new ServiceCategory { CategoryName = "Document Translation", Description = "Translation services for academic and personal documents", IconUrl = "translation-icon.png", IsActive = true, DisplayOrder = 4, CreatedAt = DateTime.UtcNow, CreatedBy = "system" },
                new ServiceCategory { CategoryName = "Test Preparation", Description = "Services for preparing for standardized tests like IELTS, TOEFL, GRE, etc.", IconUrl = "test-icon.png", IsActive = true, DisplayOrder = 5, CreatedAt = DateTime.UtcNow, CreatedBy = "system" }
            );

            await _context.SaveChangesAsync();
            _logger.LogInformation("Seeded service categories data");
        }
    }
}
