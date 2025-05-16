using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ErrorCodeConfiguration : IEntityTypeConfiguration<ErrorCode>
{
    public void Configure(EntityTypeBuilder<ErrorCode> builder)
    {
        builder.HasKey(ec => ec.Id);

        builder.Property(ec => ec.Code)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(ec => ec.ErrorDescription)
            .IsRequired();

        builder.HasIndex(ec => ec.Code)
            .IsUnique();
    }
}
