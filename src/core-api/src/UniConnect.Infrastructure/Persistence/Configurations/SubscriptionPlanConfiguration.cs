using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class SubscriptionPlanConfiguration : IEntityTypeConfiguration<SubscriptionPlan>
{
    public void Configure(EntityTypeBuilder<SubscriptionPlan> builder)
    {
        builder.HasKey(sp => sp.Id);

        builder.Property(sp => sp.PlanName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(sp => sp.MonthlyPrice)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        builder.Property(sp => sp.AnnualPrice)
            .HasColumnType("decimal(18,2)");

        builder.Property(sp => sp.CommissionPercentage)
            .IsRequired()
            .HasColumnType("decimal(5,2)");

        // Configure relationship with Currency
        builder.HasOne(sp => sp.Currency)
            .WithMany(c => c.SubscriptionPlans)
            .HasForeignKey(sp => sp.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with ServiceProviders
        builder.HasMany(sp => sp.ServiceProviders)
            .WithOne(sprov => sprov.SubscriptionPlan)
            .HasForeignKey(sprov => sprov.SubscriptionPlanId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
