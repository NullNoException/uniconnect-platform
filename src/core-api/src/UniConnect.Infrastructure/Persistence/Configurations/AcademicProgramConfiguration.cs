using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class AcademicProgramConfiguration : IEntityTypeConfiguration<AcademicProgram>
{
    public void Configure(EntityTypeBuilder<AcademicProgram> builder)
    {
        builder.HasKey(ap => ap.Id);

        builder.Property(ap => ap.Name)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(ap => ap.Description)
            .HasMaxLength(2000);

        builder.Property(ap => ap.BaseTuitionFee)
            .HasColumnType("decimal(18,2)");

        builder.Property(ap => ap.Language)
            .HasMaxLength(50);

        // Configure relationships
        builder.HasOne(ap => ap.University)
            .WithMany(u => u.AcademicPrograms)
            .HasForeignKey(ap => ap.UniversityId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(ap => ap.AcademicLevel)
            .WithMany(al => al.AcademicPrograms)
            .HasForeignKey(ap => ap.AcademicLevelId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(ap => ap.Major)
            .WithMany(m => m.AcademicPrograms)
            .HasForeignKey(ap => ap.MajorId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(ap => ap.Currency)
            .WithMany()
            .HasForeignKey(ap => ap.CurrencyId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure collections
        builder.HasMany(ap => ap.TuitionFees)
            .WithOne(tf => tf.Program)
            .HasForeignKey(tf => tf.ProgramId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(ap => ap.ProviderOfferings)
            .WithOne(o => o.Program)
            .HasForeignKey(o => o.ProgramId)
            .OnDelete(DeleteBehavior.Cascade);

        // Indexes
        builder.HasIndex(ap => ap.UniversityId);
        builder.HasIndex(ap => ap.AcademicLevelId);
        builder.HasIndex(ap => ap.MajorId);
        builder.HasIndex(ap => new { ap.UniversityId, ap.Status });
    }
}
