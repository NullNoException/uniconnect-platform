using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class FeatureToggleConfiguration : IEntityTypeConfiguration<FeatureToggle>
{
    public void Configure(EntityTypeBuilder<FeatureToggle> builder)
    {
        builder.HasKey(ft => ft.Id);

        builder.Property(ft => ft.FeatureName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(ft => ft.IsEnabled)
            .IsRequired();

        builder.HasIndex(ft => ft.FeatureName)
            .IsUnique();
    }
}
