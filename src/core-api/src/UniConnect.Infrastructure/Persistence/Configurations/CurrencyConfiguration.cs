using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class CurrencyConfiguration : IEntityTypeConfiguration<Currency>
{
    public void Configure(EntityTypeBuilder<Currency> builder)
    {
        builder.HasKey(c => c.Id);

        builder.Property(c => c.CurrencyCode)
            .IsRequired()
            .HasMaxLength(3);

        builder.Property(c => c.CurrencyName)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(c => c.CurrencySymbol)
            .IsRequired()
            .HasMaxLength(5);

        builder.HasIndex(c => c.CurrencyCode)
            .IsUnique();

        // Configure relationship with Services
        builder.HasMany(c => c.Services)
            .WithOne(s => s.Currency)
            .HasForeignKey(s => s.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Transactions
        builder.HasMany(c => c.Transactions)
            .WithOne(t => t.Currency)
            .HasForeignKey(t => t.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with SubscriptionPlans
        builder.HasMany(c => c.SubscriptionPlans)
            .WithOne(sp => sp.Currency)
            .HasForeignKey(sp => sp.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Invoices
        builder.HasMany(c => c.Invoices)
            .WithOne(i => i.Currency)
            .HasForeignKey(i => i.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
