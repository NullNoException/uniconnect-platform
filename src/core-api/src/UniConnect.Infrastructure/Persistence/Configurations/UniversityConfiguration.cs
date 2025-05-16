using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class UniversityConfiguration : IEntityTypeConfiguration<University>
{
    public void Configure(EntityTypeBuilder<University> builder)
    {
        builder.HasKey(u => u.Id);

        builder.Property(u => u.Name)
            .IsRequired()
            .HasMaxLength(256);

        // Configure relationship with Country
        builder.HasOne(u => u.Country)
            .WithMany(c => c.Universities)
            .HasForeignKey(u => u.CountryId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Address
        builder.HasOne(u => u.Address)
            .WithOne()
            .HasForeignKey<University>(u => u.AddressId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Students
        builder.HasMany(u => u.Students)
            .WithOne(s => s.CurrentUniversity)
            .HasForeignKey(s => s.CurrentUniversityId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.SetNull);
    }
}
