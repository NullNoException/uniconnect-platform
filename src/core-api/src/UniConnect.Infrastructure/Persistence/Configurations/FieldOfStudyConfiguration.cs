using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class FieldOfStudyConfiguration : IEntityTypeConfiguration<FieldOfStudy>
{
    public void Configure(EntityTypeBuilder<FieldOfStudy> builder)
    {
        builder.HasKey(f => f.Id);

        builder.Property(f => f.FieldName)
            .IsRequired()
            .HasMaxLength(256);

        // Configure relationship with ParentField (self-reference)
        builder.HasOne(f => f.ParentField)
            .WithMany(f => f.ChildFields)
            .HasForeignKey(f => f.ParentFieldId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Students
        builder.HasMany(f => f.Students)
            .WithOne(s => s.FieldOfStudy)
            .HasForeignKey(s => s.FieldOfStudyId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.SetNull);
    }
}
