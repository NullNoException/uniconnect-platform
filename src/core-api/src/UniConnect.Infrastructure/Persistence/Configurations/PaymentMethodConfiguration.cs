using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class PaymentMethodConfiguration : IEntityTypeConfiguration<PaymentMethod>
{
    public void Configure(EntityTypeBuilder<PaymentMethod> builder)
    {
        builder.HasKey(pm => pm.Id);

        builder.Property(pm => pm.MethodType)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(pm => pm.AccountName)
            .IsRequired()
            .HasMaxLength(100);

        // Configure relationship with User
        builder.HasOne(pm => pm.User)
            .WithMany(u => u.PaymentMethods)
            .HasForeignKey(pm => pm.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Transactions
        builder.HasMany(pm => pm.Transactions)
            .WithOne(t => t.PaymentMethod)
            .HasForeignKey(t => t.PaymentMethodId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
