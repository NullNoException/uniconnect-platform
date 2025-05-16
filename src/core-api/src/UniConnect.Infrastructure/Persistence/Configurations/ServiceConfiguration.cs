using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ServiceConfiguration : IEntityTypeConfiguration<Service>
{
    public void Configure(EntityTypeBuilder<Service> builder)
    {
        builder.HasKey(s => s.Id);

        builder.Property(s => s.ServiceName)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(s => s.BasePrice)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        // Configure relationship with ServiceProvider
        builder.HasOne(s => s.Provider)
            .WithMany(p => p.Services)
            .HasForeignKey(s => s.ProviderId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with ServiceCategory
        builder.HasOne(s => s.Category)
            .WithMany(c => c.Services)
            .HasForeignKey(s => s.CategoryId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Currency
        builder.HasOne(s => s.Currency)
            .WithMany(c => c.Services)
            .HasForeignKey(s => s.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Attributes
        builder.HasMany(s => s.Attributes)
            .WithOne(a => a.Service)
            .HasForeignKey(a => a.ServiceId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Requirements
        builder.HasMany(s => s.Requirements)
            .WithOne(r => r.Service)
            .HasForeignKey(r => r.ServiceId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with PriceComponents
        builder.HasMany(s => s.PriceComponents)
            .WithOne(p => p.Service)
            .HasForeignKey(p => p.ServiceId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Requests
        builder.HasMany(s => s.Requests)
            .WithOne(r => r.Service)
            .HasForeignKey(r => r.ServiceId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
