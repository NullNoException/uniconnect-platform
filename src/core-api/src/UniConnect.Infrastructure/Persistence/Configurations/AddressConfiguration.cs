using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class AddressConfiguration : IEntityTypeConfiguration<Address>
{
    public void Configure(EntityTypeBuilder<Address> builder)
    {
        builder.HasKey(a => a.Id);

        builder.Property(a => a.AddressLine1)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(a => a.City)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(a => a.PostalCode)
            .IsRequired()
            .HasMaxLength(20);

        builder.Property(a => a.EntityType)
            .IsRequired()
            .HasMaxLength(50);

        // Configure relationship with Country
        builder.HasOne(a => a.Country)
            .WithMany(c => c.Addresses)
            .HasForeignKey(a => a.CountryId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
