using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ConversationConfiguration : IEntityTypeConfiguration<Conversation>
{
    public void Configure(EntityTypeBuilder<Conversation> builder)
    {
        builder.HasKey(c => c.Id);

        builder.Property(c => c.ConversationType)
            .IsRequired();

        builder.Property(c => c.Status)
            .IsRequired();

        // Configure the one-to-many relationship between Conversation and Messages
        builder.HasMany(c => c.Messages)
            .WithOne(m => m.Conversation)
            .HasForeignKey(m => m.ConversationId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure the one-to-one relationship with LastMessage
        builder.HasOne(c => c.LastMessage)
            .WithMany()  // No inverse navigation property from Message back to Conversation as LastMessage
            .HasForeignKey(c => c.LastMessageId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with ServiceRequest
        builder.HasOne(c => c.Request)
            .WithMany(r => r.Conversations)
            .HasForeignKey(c => c.RequestId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
