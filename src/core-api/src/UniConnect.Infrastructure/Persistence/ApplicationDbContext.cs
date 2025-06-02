using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System.Reflection;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Infrastructure.Identity;
using UniConnect.Infrastructure.Persistence.Interceptors;

namespace UniConnect.Infrastructure.Persistence;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser>, IApplicationDbContext
{
    private readonly AuditableEntitySaveChangesInterceptor _auditableEntitySaveChangesInterceptor;

    public ApplicationDbContext(
        DbContextOptions<ApplicationDbContext> options,
        AuditableEntitySaveChangesInterceptor auditableEntitySaveChangesInterceptor)
        : base(options)
    {
        _auditableEntitySaveChangesInterceptor = auditableEntitySaveChangesInterceptor;
    }

    public new DbSet<User> Users => Set<User>();
    public DbSet<UserProfile> UserProfiles => Set<UserProfile>();
    public DbSet<Student> Students => Set<Student>();
    public DbSet<ServiceProvider> ServiceProviders => Set<ServiceProvider>();
    public DbSet<ProviderStaff> ProviderStaff => Set<ProviderStaff>();
    public DbSet<Admin> Admins => Set<Admin>();
    public DbSet<Address> Addresses => Set<Address>();
    public DbSet<Country> Countries => Set<Country>();
    public DbSet<University> Universities => Set<University>();
    public DbSet<UniversityContact> UniversityContacts => Set<UniversityContact>();
    public DbSet<UniversityAddress> UniversityAddresses => Set<UniversityAddress>();
    public DbSet<AcademicProgram> AcademicPrograms => Set<AcademicProgram>();
    public DbSet<AcademicLevel> AcademicLevels => Set<AcademicLevel>();
    public DbSet<Major> Majors => Set<Major>();
    public DbSet<ProgramTuitionFee> ProgramTuitionFees => Set<ProgramTuitionFee>();
    public DbSet<ProviderProgramOffering> ProviderProgramOfferings => Set<ProviderProgramOffering>();
    public DbSet<FieldOfStudy> FieldsOfStudy => Set<FieldOfStudy>();
    public DbSet<ServiceCategory> ServiceCategories => Set<ServiceCategory>();
    public DbSet<Service> Services => Set<Service>();
    public DbSet<ServiceAttribute> ServiceAttributes => Set<ServiceAttribute>();
    public DbSet<ServiceRequirement> ServiceRequirements => Set<ServiceRequirement>();
    public DbSet<ServicePriceComponent> ServicePriceComponents => Set<ServicePriceComponent>();
    public DbSet<ServiceRequest> ServiceRequests => Set<ServiceRequest>();
    public DbSet<RequestDocument> RequestDocuments => Set<RequestDocument>();
    public DbSet<DocumentTypeEntity> DocumentTypes => Set<DocumentTypeEntity>();
    public DbSet<RequestMilestone> RequestMilestones => Set<RequestMilestone>();
    public DbSet<Currency> Currencies => Set<Currency>();
    public DbSet<Transaction> Transactions => Set<Transaction>();
    public DbSet<PaymentMethod> PaymentMethods => Set<PaymentMethod>();
    public DbSet<AcademicCalendar> AcademicCalendars => Set<AcademicCalendar>();
    public DbSet<AcademicYear> AcademicYears => Set<AcademicYear>();
    public DbSet<Semester> Semesters => Set<Semester>();
    public DbSet<Deadline> Deadlines => Set<Deadline>();
    public DbSet<SemesterProgram> SemesterPrograms => Set<SemesterProgram>();
    public DbSet<SubscriptionPlan> SubscriptionPlans => Set<SubscriptionPlan>();
    public DbSet<Invoice> Invoices => Set<Invoice>();
    public DbSet<InvoiceItem> InvoiceItems => Set<InvoiceItem>();
    public DbSet<Message> Messages => Set<Message>();
    public DbSet<Conversation> Conversations => Set<Conversation>();
    public DbSet<ConversationParticipant> ConversationParticipants => Set<ConversationParticipant>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<CommunicationChannelPreference> CommunicationChannelPreferences => Set<CommunicationChannelPreference>();
    public DbSet<SystemLog> SystemLogs => Set<SystemLog>();
    public DbSet<ErrorCode> ErrorCodes => Set<ErrorCode>();
    public DbSet<ApiKey> ApiKeys => Set<ApiKey>();
    public DbSet<FeatureToggle> FeatureToggles => Set<FeatureToggle>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<ReviewResponse> ReviewResponses => Set<ReviewResponse>();
    public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();
    public DbSet<Document> Documents => Set<Document>();

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        // Configure ASP.NET Core Identity tables with schema
        builder.Entity<ApplicationUser>().ToTable("AspNetUsers");
        builder.Entity<Microsoft.AspNetCore.Identity.IdentityRole>().ToTable("AspNetRoles");
        builder.Entity<Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>>().ToTable("AspNetRoleClaims");
        builder.Entity<Microsoft.AspNetCore.Identity.IdentityUserClaim<string>>().ToTable("AspNetUserClaims");
        builder.Entity<Microsoft.AspNetCore.Identity.IdentityUserLogin<string>>().ToTable("AspNetUserLogins");
        builder.Entity<Microsoft.AspNetCore.Identity.IdentityUserRole<string>>().ToTable("AspNetUserRoles");
        builder.Entity<Microsoft.AspNetCore.Identity.IdentityUserToken<string>>().ToTable("AspNetUserTokens");

        builder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.AddInterceptors(_auditableEntitySaveChangesInterceptor);
        base.OnConfiguring(optionsBuilder);
    }

    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        return await base.SaveChangesAsync(cancellationToken);
    }
}
