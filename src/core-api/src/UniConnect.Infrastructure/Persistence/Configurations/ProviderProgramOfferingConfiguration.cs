using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ProviderProgramOfferingConfiguration : IEntityTypeConfiguration<ProviderProgramOffering>
{
    public void Configure(EntityTypeBuilder<ProviderProgramOffering> builder)
    {
        builder.HasKey(ppo => ppo.Id);

        builder.Property(ppo => ppo.ServiceDescription)
            .IsRequired(false)
            .HasMaxLength(1024);

        builder.Property(ppo => ppo.MarketingContent)
            .IsRequired(false)
            .HasMaxLength(2048);

        builder.Property(ppo => ppo.EntryRequirements)
            .IsRequired(false)
            .HasMaxLength(1024);

        builder.Property(ppo => ppo.ProgramHighlights)
            .IsRequired(false)
            .HasMaxLength(1024);

        builder.Property(ppo => ppo.Status)
            .IsRequired()
            .HasDefaultValue(0); // Default to Active

        builder.Property(ppo => ppo.IsPromoted)
            .IsRequired()
            .HasDefaultValue(false);

        builder.Property(ppo => ppo.DisplayOrder)
            .IsRequired()
            .HasDefaultValue(0);

        // Configure relationships
        builder.HasOne(ppo => ppo.Provider)
            .WithMany()
            .HasForeignKey(ppo => ppo.ProviderId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(ppo => ppo.Program)
            .WithMany(ap => ap.ProviderOfferings)
            .HasForeignKey(ppo => ppo.ProgramId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure indexes
        builder.HasIndex(ppo => new { ppo.ProviderId, ppo.ProgramId })
            .IsUnique();

        builder.HasIndex(ppo => ppo.Status);

        builder.HasIndex(ppo => ppo.ActivationDate);

        builder.HasIndex(ppo => ppo.DeactivationDate);

        // Configure audit fields
        builder.Property(ppo => ppo.CreatedAt)
            .IsRequired()
            .HasDefaultValueSql("GETUTCDATE()");

        builder.Property(ppo => ppo.UpdatedAt)
            .IsRequired(false);

        builder.Property(ppo => ppo.CreatedBy)
            .HasMaxLength(128);

        builder.Property(ppo => ppo.UpdatedBy)
            .HasMaxLength(128);

        // Soft delete
        builder.HasQueryFilter(ppo => !ppo.IsDeleted);
    }
}
