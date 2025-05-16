using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class RequestDocumentConfiguration : IEntityTypeConfiguration<RequestDocument>
{
    public void Configure(EntityTypeBuilder<RequestDocument> builder)
    {
        builder.HasKey(rd => rd.Id);

        builder.Property(rd => rd.DocumentName)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(rd => rd.FileUrl)
            .IsRequired();

        builder.Property(rd => rd.Status)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(rd => rd.UploadDate)
            .IsRequired();

        // Configure relationship with ServiceRequest
        builder.HasOne(rd => rd.Request)
            .WithMany(sr => sr.Documents)
            .HasForeignKey(rd => rd.RequestId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with DocumentType
        builder.HasOne(rd => rd.DocumentType)
            .WithMany(dt => dt.RequestDocuments)
            .HasForeignKey(rd => rd.DocumentTypeId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with User (VerifiedBy)
        builder.HasOne(rd => rd.VerifiedBy)
            .WithMany()
            .HasForeignKey(rd => rd.VerifiedById)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
