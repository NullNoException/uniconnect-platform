using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class SystemLogConfiguration : IEntityTypeConfiguration<SystemLog>
{
    public void Configure(EntityTypeBuilder<SystemLog> builder)
    {
        builder.HasKey(sl => sl.Id);

        builder.Property(sl => sl.LogLevel)
            .IsRequired()
            .HasMaxLength(20);

        builder.Property(sl => sl.LogCategory)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(sl => sl.LogMessage)
            .IsRequired();

        builder.Property(sl => sl.UserIP)
            .HasMaxLength(50);

        builder.Property(sl => sl.UserAgent)
            .HasMaxLength(500);

        builder.Property(sl => sl.RequestUrl)
            .HasMaxLength(1000);

        builder.Property(sl => sl.RequestMethod)
            .HasMaxLength(10);

        // Configure relationship with User
        builder.HasOne(sl => sl.User)
            .WithMany()
            .HasForeignKey(sl => sl.UserId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Add indexes for improved query performance
        builder.HasIndex(sl => sl.LogLevel);
        builder.HasIndex(sl => sl.CreatedAt);
    }
}
