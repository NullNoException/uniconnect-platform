using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ServiceProviderConfiguration : IEntityTypeConfiguration<ServiceProvider>
{
    public void Configure(EntityTypeBuilder<ServiceProvider> builder)
    {
        builder.HasKey(sp => sp.Id);

        builder.Property(sp => sp.CompanyName)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(sp => sp.VerificationStatus)
            .IsRequired();

        // Configure relationship with User
        builder.HasOne(sp => sp.User)
            .WithOne(u => u.ServiceProvider)
            .HasForeignKey<ServiceProvider>(sp => sp.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with VerifiedBy
        builder.HasOne(sp => sp.VerifiedBy)
            .WithMany()
            .HasForeignKey(sp => sp.VerifiedById)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with SubscriptionPlan
        builder.HasOne(sp => sp.SubscriptionPlan)
            .WithMany(s => s.ServiceProviders)
            .HasForeignKey(sp => sp.SubscriptionPlanId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with BillingAddress
        builder.HasOne(sp => sp.BillingAddress)
            .WithOne()
            .HasForeignKey<ServiceProvider>(sp => sp.BillingAddressId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Staff
        builder.HasMany(sp => sp.Staff)
            .WithOne(s => s.Provider)
            .HasForeignKey(s => s.ProviderId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Services
        builder.HasMany(sp => sp.Services)
            .WithOne(s => s.Provider)
            .HasForeignKey(s => s.ProviderId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
