using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class UniversityAddressConfiguration : IEntityTypeConfiguration<UniversityAddress>
{
    public void Configure(EntityTypeBuilder<UniversityAddress> builder)
    {
        builder.HasKey(ua => ua.Id);

        builder.Property(ua => ua.AddressType)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(ua => ua.Street)
            .HasMaxLength(200);

        builder.Property(ua => ua.City)
            .HasMaxLength(100);

        builder.Property(ua => ua.State)
            .HasMaxLength(100);

        builder.Property(ua => ua.PostalCode)
            .HasMaxLength(20);

        builder.Property(ua => ua.Latitude)
            .HasColumnType("decimal(10,8)");

        builder.Property(ua => ua.Longitude)
            .HasColumnType("decimal(11,8)");

        // Configure relationship with University
        builder.HasOne(ua => ua.University)
            .WithMany(u => u.Addresses)
            .HasForeignKey(ua => ua.UniversityId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Country
        builder.HasOne(ua => ua.Country)
            .WithMany()
            .HasForeignKey(ua => ua.CountryId)
            .OnDelete(DeleteBehavior.Restrict);

        // Indexes
        builder.HasIndex(ua => ua.UniversityId);
        builder.HasIndex(ua => ua.CountryId);
        builder.HasIndex(ua => new { ua.UniversityId, ua.IsPrimary });
    }
}
