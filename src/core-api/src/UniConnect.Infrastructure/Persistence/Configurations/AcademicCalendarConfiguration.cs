using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class AcademicCalendarConfiguration : IEntityTypeConfiguration<AcademicCalendar>
{
    public void Configure(EntityTypeBuilder<AcademicCalendar> builder)
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

        // Relationships
        builder.HasOne(e => e.University)
            .WithMany(u => u.AcademicCalendars)
            .HasForeignKey(e => e.UniversityId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
