using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class UniversityContactConfiguration : IEntityTypeConfiguration<UniversityContact>
{
    public void Configure(EntityTypeBuilder<UniversityContact> builder)
    {
        builder.HasKey(uc => uc.Id);

        builder.Property(uc => uc.ContactType)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(uc => uc.Name)
            .HasMaxLength(100);

        builder.Property(uc => uc.Email)
            .HasMaxLength(256);

        builder.Property(uc => uc.Phone)
            .HasMaxLength(20);

        builder.Property(uc => uc.Department)
            .HasMaxLength(100);

        // Configure relationship with University
        builder.HasOne(uc => uc.University)
            .WithMany(u => u.Contacts)
            .HasForeignKey(uc => uc.UniversityId)
            .OnDelete(DeleteBehavior.Cascade);

        // Indexes
        builder.HasIndex(uc => uc.UniversityId);
        builder.HasIndex(uc => uc.Email);
    }
}
