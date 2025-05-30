using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class AcademicLevelConfiguration : IEntityTypeConfiguration<AcademicLevel>
{
    public void Configure(EntityTypeBuilder<AcademicLevel> builder)
    {
        builder.HasKey(al => al.Id);

        builder.Property(al => al.Name)
            .IsRequired()
            .HasMaxLength(128);

        builder.Property(al => al.Description)
            .HasMaxLength(512);

        builder.Property(al => al.Order)
            .IsRequired();

        builder.Property(al => al.IsActive)
            .IsRequired()
            .HasDefaultValue(true);

        // Configure index for name uniqueness
        builder.HasIndex(al => al.Name)
            .IsUnique();

        // Configure index for order
        builder.HasIndex(al => al.Order);

        // Configure relationship with AcademicPrograms
        builder.HasMany(al => al.AcademicPrograms)
            .WithOne(ap => ap.AcademicLevel)
            .HasForeignKey(ap => ap.AcademicLevelId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure audit fields
        builder.Property(al => al.CreatedAt)
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        builder.Property(al => al.UpdatedAt)
            .IsRequired(false);

        builder.Property(al => al.CreatedBy)
            .HasMaxLength(128);

        builder.Property(al => al.UpdatedBy)
            .HasMaxLength(128);

        // Soft delete
        builder.HasQueryFilter(al => !al.IsDeleted);
    }
}
