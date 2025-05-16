using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ServicePriceComponentConfiguration : IEntityTypeConfiguration<ServicePriceComponent>
{
    public void Configure(EntityTypeBuilder<ServicePriceComponent> builder)
    {
        builder.HasKey(spc => spc.Id);

        builder.Property(spc => spc.ComponentName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(spc => spc.Price)
            .IsRequired()
            .HasColumnType("decimal(18,2)");

        // Configure relationship with Service
        builder.HasOne(spc => spc.Service)
            .WithMany(s => s.PriceComponents)
            .HasForeignKey(spc => spc.ServiceId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
