using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ServiceCategoryConfiguration : IEntityTypeConfiguration<ServiceCategory>
{
    public void Configure(EntityTypeBuilder<ServiceCategory> builder)
    {
        builder.HasKey(sc => sc.Id);

        builder.Property(sc => sc.CategoryName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(sc => sc.DisplayOrder)
            .HasDefaultValue(0);

        // Configure relationship with parent category (self-reference)
        builder.HasOne(sc => sc.ParentCategory)
            .WithMany(sc => sc.ChildCategories)
            .HasForeignKey(sc => sc.ParentCategoryId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Services
        builder.HasMany(sc => sc.Services)
            .WithOne(s => s.Category)
            .HasForeignKey(s => s.CategoryId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
