using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class InvoiceConfiguration : IEntityTypeConfiguration<Invoice>
{
    public void Configure(EntityTypeBuilder<Invoice> builder)
    {
        builder.HasKey(i => i.Id);

        builder.Property(i => i.InvoiceNumber)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(i => i.EntityType)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(i => i.InvoiceDate)
            .IsRequired();

        builder.Property(i => i.DueDate)
            .IsRequired();

        builder.Property(i => i.TotalAmount)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        builder.Property(i => i.Status)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(i => i.PaidAmount)
            .HasColumnType("decimal(18,2)");

        // Configure relationship with Currency
        builder.HasOne(i => i.Currency)
            .WithMany(c => c.Invoices)
            .HasForeignKey(i => i.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with InvoiceItems
        builder.HasMany(i => i.Items)
            .WithOne(ii => ii.Invoice)
            .HasForeignKey(ii => ii.InvoiceId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
