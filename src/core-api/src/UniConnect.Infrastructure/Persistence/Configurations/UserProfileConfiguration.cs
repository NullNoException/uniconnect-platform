using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class UserProfileConfiguration : IEntityTypeConfiguration<UserProfile>
{
    public void Configure(EntityTypeBuilder<UserProfile> builder)
    {
        builder.HasKey(up => up.Id);

        builder.Property(up => up.FirstName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(up => up.LastName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(up => up.PreferredLanguage)
            .IsRequired()
            .HasMaxLength(10)
            .HasDefaultValue("en");        // Configure relationship with User
        builder.HasOne(up => up.User)
            .WithOne(u => u.Profile)
            .HasForeignKey<UserProfile>(up => up.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        // Ignore the FullName property - it's a computed property in C# code
        builder.Ignore(up => up.FullName);
    }
}
