using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class RefreshTokenConfiguration : IEntityTypeConfiguration<RefreshToken>
{
    public void Configure(EntityTypeBuilder<RefreshToken> builder)
    {
        builder.HasKey(rt => rt.Id);

        builder.Property(rt => rt.Token)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(rt => rt.JwtId)
            .IsRequired()
            .HasMaxLength(128);

        builder.Property(rt => rt.UserId)
            .IsRequired()
            .HasMaxLength(450);  // Match ASP.NET Identity's Id column length

        builder.HasIndex(rt => rt.Token)
            .IsUnique();

        builder.HasIndex(rt => rt.JwtId);

        builder.HasIndex(rt => rt.UserId);
    }
}
