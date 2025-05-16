using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class CommunicationChannelPreferenceConfiguration : IEntityTypeConfiguration<CommunicationChannelPreference>
{
    public void Configure(EntityTypeBuilder<CommunicationChannelPreference> builder)
    {
        builder.HasKey(cp => cp.Id);

        builder.Property(cp => cp.NotificationType)
            .IsRequired()
            .HasMaxLength(50);

        // Configure relationship with User
        builder.HasOne(cp => cp.User)
            .WithMany(u => u.CommunicationPreferences)
            .HasForeignKey(cp => cp.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        // Index for faster lookups based on user and notification type
        builder.HasIndex(cp => new { cp.UserId, cp.NotificationType });
    }
}
