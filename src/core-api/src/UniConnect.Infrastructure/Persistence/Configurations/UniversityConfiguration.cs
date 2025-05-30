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

        // Configure relationship with UniversityContacts
        builder.HasMany(u => u.Contacts)
            .WithOne(uc => uc.University)
            .HasForeignKey(uc => uc.UniversityId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with UniversityAddresses
        builder.HasMany(u => u.Addresses)
            .WithOne(ua => ua.University)
            .HasForeignKey(ua => ua.UniversityId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with AcademicPrograms
        builder.HasMany(u => u.AcademicPrograms)
            .WithOne(ap => ap.University)
            .HasForeignKey(ap => ap.UniversityId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure additional properties
        builder.Property(u => u.Description)
            .HasMaxLength(2048);

        builder.Property(u => u.Website)
            .HasMaxLength(512);

        builder.Property(u => u.LogoUrl)
            .HasMaxLength(1024);

        builder.Property(u => u.Email)
            .HasMaxLength(256);

        builder.Property(u => u.Phone)
            .HasMaxLength(32);

        builder.Property(u => u.AccreditationBody)
            .HasMaxLength(256);

        builder.Property(u => u.Type)
            .HasMaxLength(64);

        builder.Property(u => u.Ranking)
            .HasColumnType("decimal(5,2)");

        builder.Property(u => u.IsActive)
            .IsRequired()
            .HasDefaultValue(true);

        // Configure indexes
        builder.HasIndex(u => u.Name);
        builder.HasIndex(u => u.Status);
        builder.HasIndex(u => u.AccreditationStatus);
        builder.HasIndex(u => u.EstablishedYear);
        builder.HasIndex(u => u.Ranking);

        // Configure audit fields
        builder.Property(u => u.CreatedAt)
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        builder.Property(u => u.UpdatedAt)
            .IsRequired(false);

        builder.Property(u => u.CreatedBy)
            .HasMaxLength(128);

        builder.Property(u => u.UpdatedBy)
            .HasMaxLength(128);

        // Soft delete
        builder.HasQueryFilter(u => !u.IsDeleted);
    }
}
