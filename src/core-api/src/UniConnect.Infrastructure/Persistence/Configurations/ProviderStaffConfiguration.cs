using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ProviderStaffConfiguration : IEntityTypeConfiguration<ProviderStaff>
{
    public void Configure(EntityTypeBuilder<ProviderStaff> builder)
    {
        builder.HasKey(ps => ps.Id);

        builder.Property(ps => ps.Position)
            .IsRequired()
            .HasMaxLength(100);

        // Configure relationship with User
        builder.HasOne(ps => ps.User)
            .WithMany()
            .HasForeignKey(ps => ps.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with ServiceProvider
        builder.HasOne(ps => ps.Provider)
            .WithMany(sp => sp.Staff)
            .HasForeignKey(ps => ps.ProviderId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Supervisor (self-reference)
        builder.HasOne(ps => ps.Supervisor)
            .WithMany(ps => ps.Subordinates)
            .HasForeignKey(ps => ps.SupervisorId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
