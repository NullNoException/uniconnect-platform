using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class DocumentConfiguration : IEntityTypeConfiguration<Document>
{
    public void Configure(EntityTypeBuilder<Document> builder)
    {
        builder.ToTable("documents");

        builder.HasKey(d => d.Id);

        builder.Property(d => d.FileName)
            .IsRequired()
            .HasColumnName("file_name")
            .HasMaxLength(256);

        builder.Property(d => d.OriginalFileName)
            .IsRequired()
            .HasColumnName("original_file_name")
            .HasMaxLength(256);

        builder.Property(d => d.ContentType)
            .IsRequired()
            .HasColumnName("content_type")
            .HasMaxLength(128);

        builder.Property(d => d.FileSize)
            .IsRequired()
            .HasColumnName("file_size");

        builder.Property(d => d.StoragePath)
            .IsRequired()
            .HasColumnName("storage_path")
            .HasMaxLength(512);

        builder.Property(d => d.DocumentType)
            .IsRequired()
            .HasColumnName("document_type");

        builder.Property(d => d.UploadedByUserId)
            .IsRequired()
            .HasColumnName("uploaded_by_user_id");

        builder.Property(d => d.MalwareScanStatus)
            .IsRequired()
            .HasColumnName("malware_scan_status");

        builder.Property(d => d.VirusScanDetails)
            .HasColumnName("virus_scan_details")
            .HasMaxLength(1024);

        // Auditing columns (from BaseAuditableEntity)
        builder.Property(d => d.CreatedAt)
            .IsRequired()
            .HasColumnName("created_at");
        builder.Property(d => d.CreatedBy)
            .HasColumnName("created_by");
        builder.Property(d => d.UpdatedAt)
            .HasColumnName("updated_at");
        builder.Property(d => d.UpdatedBy)
            .HasColumnName("updated_by");
    }
}
