using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class CountryConfiguration : IEntityTypeConfiguration<Country>
{
    public void Configure(EntityTypeBuilder<Country> builder)
    {
        builder.HasKey(c => c.Id);

        builder.Property(c => c.CountryName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(c => c.CountryCode)
            .IsRequired()
            .HasMaxLength(3);

        builder.HasIndex(c => c.CountryCode)
            .IsUnique();

        // Configure relationship with Universities
        builder.HasMany(c => c.Universities)
            .WithOne(u => u.Country)
            .HasForeignKey(u => u.CountryId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Addresses
        builder.HasMany(c => c.Addresses)
            .WithOne(a => a.Country)
            .HasForeignKey(a => a.CountryId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
