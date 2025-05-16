using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ServiceAttributeConfiguration : IEntityTypeConfiguration<ServiceAttribute>
{
    public void Configure(EntityTypeBuilder<ServiceAttribute> builder)
    {
        builder.HasKey(sa => sa.Id);

        builder.Property(sa => sa.AttributeKey)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(sa => sa.AttributeValue)
            .IsRequired();

        // Configure relationship with Service
        builder.HasOne(sa => sa.Service)
            .WithMany(s => s.Attributes)
            .HasForeignKey(sa => sa.ServiceId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
