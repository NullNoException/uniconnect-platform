using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class AcademicYearConfiguration : IEntityTypeConfiguration<AcademicYear>
{
    public void Configure(EntityTypeBuilder<AcademicYear> builder)
    {
        builder.HasKey(e => e.Id);

        builder.Property(e => e.Name)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(e => e.Description)
            .HasMaxLength(2000);

        builder.Property(e => e.IsActive)
            .HasDefaultValue(true);

        builder.Property(e => e.StartDate)
            .IsRequired();

        builder.Property(e => e.EndDate)
            .IsRequired();

        builder.Property(e => e.Year)
            .IsRequired();

        // Relationships
        builder.HasOne(e => e.AcademicCalendar)
            .WithMany(c => c.AcademicYears)
            .HasForeignKey(e => e.AcademicCalendarId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
