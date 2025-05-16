using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ApiKeyConfiguration : IEntityTypeConfiguration<ApiKey>
{
    public void Configure(EntityTypeBuilder<ApiKey> builder)
    {
        builder.HasKey(ak => ak.Id);

        builder.Property(ak => ak.KeyValue)
            .IsRequired()
            .HasMaxLength(128);

        builder.Property(ak => ak.KeyName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(ak => ak.IsActive)
            .IsRequired()
            .HasMaxLength(50);

        builder.HasIndex(ak => ak.KeyValue)
            .IsUnique();
    }
}
