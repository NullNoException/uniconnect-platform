using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ServiceRequirementConfiguration : IEntityTypeConfiguration<ServiceRequirement>
{
    public void Configure(EntityTypeBuilder<ServiceRequirement> builder)
    {
        builder.HasKey(sr => sr.Id);

        builder.Property(sr => sr.RequirementName)
            .IsRequired()
            .HasMaxLength(256);

        // Configure relationship with Service
        builder.HasOne(sr => sr.Service)
            .WithMany(s => s.Requirements)
            .HasForeignKey(sr => sr.ServiceId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with DocumentType
        builder.HasOne(sr => sr.DocumentType)
            .WithMany(dt => dt.ServiceRequirements)
            .HasForeignKey(sr => sr.DocumentTypeId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
