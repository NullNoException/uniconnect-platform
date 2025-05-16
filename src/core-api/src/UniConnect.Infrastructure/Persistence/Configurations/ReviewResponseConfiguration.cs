using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ReviewResponseConfiguration : IEntityTypeConfiguration<ReviewResponse>
{
    public void Configure(EntityTypeBuilder<ReviewResponse> builder)
    {
        builder.HasKey(rr => rr.Id);

        builder.Property(rr => rr.Response)
            .IsRequired();

        builder.Property(rr => rr.ResponseDate)
            .IsRequired();

        builder.Property(rr => rr.ModerationStatus)
            .IsRequired()
            .HasMaxLength(50);

        // Configure relationship with Review
        builder.HasOne(rr => rr.Review)
            .WithOne(r => r.Response)
            .HasForeignKey<ReviewResponse>(rr => rr.ReviewId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Responder
        builder.HasOne(rr => rr.Responder)
            .WithMany()
            .HasForeignKey(rr => rr.ResponderId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Moderator
        builder.HasOne(rr => rr.ModeratedBy)
            .WithMany()
            .HasForeignKey(rr => rr.ModeratedById)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
