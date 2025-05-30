using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class MajorConfiguration : IEntityTypeConfiguration<Major>
{
    public void Configure(EntityTypeBuilder<Major> builder)
    {
        builder.HasKey(m => m.Id);

        builder.Property(m => m.Name)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(m => m.Description)
            .HasMaxLength(1024);

        builder.Property(m => m.Code)
            .HasMaxLength(32);

        builder.Property(m => m.Level)
            .HasMaxLength(128);

        builder.Property(m => m.IsActive)
            .IsRequired()
            .HasDefaultValue(true);

        // Configure indexes
        builder.HasIndex(m => m.Name);

        builder.HasIndex(m => m.Code)
            .IsUnique()
            .HasFilter("[Code] IS NOT NULL");

        builder.HasIndex(m => m.Level);

        // Configure relationship with AcademicPrograms
        builder.HasMany(m => m.AcademicPrograms)
            .WithOne(ap => ap.Major)
            .HasForeignKey(ap => ap.MajorId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure audit fields
        builder.Property(m => m.CreatedAt)
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        builder.Property(m => m.UpdatedAt)
            .IsRequired(false);

        builder.Property(m => m.CreatedBy)
            .HasMaxLength(128);

        builder.Property(m => m.UpdatedBy)
            .HasMaxLength(128);

        // Soft delete
        builder.HasQueryFilter(m => !m.IsDeleted);
    }
}
