using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class RequestMilestoneConfiguration : IEntityTypeConfiguration<RequestMilestone>
{
    public void Configure(EntityTypeBuilder<RequestMilestone> builder)
    {
        builder.HasKey(rm => rm.Id);

        builder.Property(rm => rm.MilestoneName)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(rm => rm.Status)
            .IsRequired()
            .HasMaxLength(50);

        // Configure relationship with ServiceRequest
        builder.HasOne(rm => rm.Request)
            .WithMany(sr => sr.Milestones)
            .HasForeignKey(rm => rm.RequestId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
