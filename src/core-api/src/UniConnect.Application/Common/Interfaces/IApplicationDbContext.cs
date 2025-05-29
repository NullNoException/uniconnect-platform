using Microsoft.EntityFrameworkCore;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.Common.Interfaces;

public interface IApplicationDbContext
{
    DbSet<User> Users { get; }
    DbSet<UserProfile> UserProfiles { get; }
    DbSet<Student> Students { get; }
    DbSet<ServiceProvider> ServiceProviders { get; }
    DbSet<ProviderStaff> ProviderStaff { get; }
    DbSet<Admin> Admins { get; }
    DbSet<Address> Addresses { get; }
    DbSet<Country> Countries { get; }
    DbSet<University> Universities { get; }
    DbSet<UniversityContact> UniversityContacts { get; }
    DbSet<UniversityAddress> UniversityAddresses { get; }
    DbSet<AcademicProgram> AcademicPrograms { get; }
    DbSet<AcademicLevel> AcademicLevels { get; }
    DbSet<Major> Majors { get; }
    DbSet<ProgramTuitionFee> ProgramTuitionFees { get; }
    DbSet<ProviderProgramOffering> ProviderProgramOfferings { get; }
    DbSet<FieldOfStudy> FieldsOfStudy { get; }
    DbSet<ServiceCategory> ServiceCategories { get; }
    DbSet<Service> Services { get; }
    DbSet<ServiceAttribute> ServiceAttributes { get; }
    DbSet<ServiceRequirement> ServiceRequirements { get; }
    DbSet<ServicePriceComponent> ServicePriceComponents { get; }
    DbSet<ServiceRequest> ServiceRequests { get; }
    DbSet<RequestDocument> RequestDocuments { get; }
    DbSet<DocumentType> DocumentTypes { get; }
    DbSet<RequestMilestone> RequestMilestones { get; }
    DbSet<Currency> Currencies { get; }
    DbSet<Transaction> Transactions { get; }
    DbSet<PaymentMethod> PaymentMethods { get; }
    DbSet<SubscriptionPlan> SubscriptionPlans { get; }
    DbSet<Invoice> Invoices { get; }
    DbSet<InvoiceItem> InvoiceItems { get; }
    DbSet<Message> Messages { get; }
    DbSet<Conversation> Conversations { get; }
    DbSet<ConversationParticipant> ConversationParticipants { get; }
    DbSet<Notification> Notifications { get; }
    DbSet<CommunicationChannelPreference> CommunicationChannelPreferences { get; }
    DbSet<SystemLog> SystemLogs { get; }
    DbSet<ErrorCode> ErrorCodes { get; }
    DbSet<ApiKey> ApiKeys { get; }
    DbSet<FeatureToggle> FeatureToggles { get; }
    DbSet<Review> Reviews { get; }
    DbSet<ReviewResponse> ReviewResponses { get; }
    DbSet<RefreshToken> RefreshTokens { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken);
}
