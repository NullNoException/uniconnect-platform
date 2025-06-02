using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class DocumentTypeConfiguration : IEntityTypeConfiguration<DocumentTypeEntity>
{
    public void Configure(EntityTypeBuilder<DocumentTypeEntity> builder)
    {
        builder.HasKey(dt => dt.Id);

        builder.Property(dt => dt.TypeName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(dt => dt.MaxFileSizeMB)
            .IsRequired();

        // Configure relationship with ServiceRequirements
        builder.HasMany(dt => dt.ServiceRequirements)
            .WithOne(sr => sr.DocumentType)
            .HasForeignKey(sr => sr.DocumentTypeId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with RequestDocuments
        builder.HasMany(dt => dt.RequestDocuments)
            .WithOne(rd => rd.DocumentType)
            .HasForeignKey(rd => rd.DocumentTypeId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
