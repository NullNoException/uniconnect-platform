using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class SemesterConfiguration : IEntityTypeConfiguration<Semester>
{
    public void Configure(EntityTypeBuilder<Semester> builder)
    {
        builder.HasKey(e => e.Id);

        builder.Property(e => e.Name)
            .IsRequired()
            .HasMaxLength(256);

        builder.Property(e => e.Code)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(e => e.Description)
            .HasMaxLength(2000);

        builder.Property(e => e.StartDate)
            .IsRequired();

        builder.Property(e => e.EndDate)
            .IsRequired();

        builder.Property(e => e.Status)
            .IsRequired();

        builder.Property(e => e.Order)
            .IsRequired();

        // Relationships
        builder.HasOne(e => e.AcademicYear)
            .WithMany(y => y.Semesters)
            .HasForeignKey(e => e.AcademicYearId)
            .OnDelete(DeleteBehavior.Cascade);

        // Many-to-many relationship with AcademicProgram
        builder.HasMany(e => e.AvailablePrograms)
            .WithMany(p => p.AvailableSemesters)
            .UsingEntity<SemesterProgram>(
                j => j.HasOne(sp => sp.Program)
                    .WithMany(p => p.SemesterPrograms)
                    .HasForeignKey(sp => sp.ProgramId),
                j => j.HasOne(sp => sp.Semester)
                    .WithMany(s => s.SemesterPrograms)
                    .HasForeignKey(sp => sp.SemesterId),
                j =>
                {
                    j.HasKey(sp => sp.Id);
                    j.Property(sp => sp.IsActive).HasDefaultValue(true);
                }
            );
    }
}
