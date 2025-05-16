using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ReviewConfiguration : IEntityTypeConfiguration<Review>
{
    public void Configure(EntityTypeBuilder<Review> builder)
    {
        builder.HasKey(r => r.Id);

        builder.Property(r => r.ReviewedEntityType)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(r => r.Rating)
            .IsRequired();

        builder.Property(r => r.ModerationStatus)
            .IsRequired()
            .HasMaxLength(50);

        // Configure relationship with ServiceRequest
        builder.HasOne(r => r.Request)
            .WithMany(sr => sr.Reviews)
            .HasForeignKey(r => r.RequestId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Reviewer
        builder.HasOne(r => r.Reviewer)
            .WithMany()
            .HasForeignKey(r => r.ReviewerId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Moderator
        builder.HasOne(r => r.ModeratedBy)
            .WithMany()
            .HasForeignKey(r => r.ModeratedById)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Response
        builder.HasOne(r => r.Response)
            .WithOne(rr => rr.Review)
            .HasForeignKey<Review>(r => r.ResponseId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
