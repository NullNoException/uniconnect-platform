using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ProgramTuitionFeeConfiguration : IEntityTypeConfiguration<ProgramTuitionFee>
{
    public void Configure(EntityTypeBuilder<ProgramTuitionFee> builder)
    {
        builder.HasKey(ptf => ptf.Id);

        builder.Property(ptf => ptf.FeeType)
            .IsRequired()
            .HasMaxLength(64);

        builder.Property(ptf => ptf.Amount)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        builder.Property(ptf => ptf.FeeType)
            .IsRequired()
            .HasMaxLength(32);

        builder.Property(ptf => ptf.Notes)
            .HasMaxLength(512);

        builder.Property(ptf => ptf.IsActive)
            .IsRequired()
            .HasDefaultValue(true);

        // Configure relationships
        builder.HasOne(ptf => ptf.Program)
            .WithMany(ap => ap.TuitionFees)
            .HasForeignKey(ptf => ptf.ProgramId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(ptf => ptf.Currency)
            .WithMany()
            .HasForeignKey(ptf => ptf.CurrencyId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure indexes
        builder.HasIndex(ptf => new { ptf.ProgramId, ptf.FeeType })
            .IsUnique();

        builder.HasIndex(ptf => ptf.FeeType);

        builder.HasIndex(ptf => ptf.Amount);

        // Configure audit fields
        builder.Property(ptf => ptf.CreatedAt)
            .IsRequired()
            .HasDefaultValueSql("NOW()");

        builder.Property(ptf => ptf.UpdatedAt)
            .IsRequired(false);

        builder.Property(ptf => ptf.CreatedBy)
            .HasMaxLength(128);

        builder.Property(ptf => ptf.UpdatedBy)
            .HasMaxLength(128);

        // Soft delete
        builder.HasQueryFilter(ptf => !ptf.IsDeleted);
    }
}
