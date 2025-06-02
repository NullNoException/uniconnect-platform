using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;


namespace UniConnect.Infrastructure.Persistence.Configurations;

public class TransactionConfiguration : IEntityTypeConfiguration<Transaction>
{
    public void Configure(EntityTypeBuilder<Transaction> builder)
    {
        builder.HasKey(t => t.Id);

        builder.Property(t => t.TransactionType)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(t => t.Amount)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        builder.Property(t => t.Status)
            .IsRequired()
            .HasConversion<int>();

        builder.Property(t => t.Notes)
            .HasMaxLength(1000);

        builder.Property(t => t.PlatformFeeAmount)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        builder.Property(t => t.ProviderAmount)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        builder.Property(t => t.ServiceRequestId)
            .IsRequired();

        builder.Property(t => t.StudentId)
            .IsRequired();

        builder.Property(t => t.ProviderId)
            .IsRequired();

        // Configure relationship with ServiceRequest
        builder.HasOne(t => t.Request)
            .WithMany(sr => sr.Transactions)
            .HasForeignKey(t => t.RequestId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Currency
        builder.HasOne(t => t.Currency)
            .WithMany(c => c.Transactions)
            .HasForeignKey(t => t.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with PaymentMethod
        builder.HasOne(t => t.PaymentMethod)
            .WithMany(pm => pm.Transactions)
            .HasForeignKey(t => t.PaymentMethodId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
