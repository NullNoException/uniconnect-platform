using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class SemesterProgramConfiguration : IEntityTypeConfiguration<SemesterProgram>
{
    public void Configure(EntityTypeBuilder<SemesterProgram> builder)
    {
        builder.HasKey(e => e.Id);

        builder.Property(e => e.IsActive)
            .HasDefaultValue(true);

        builder.Property(e => e.AvailableSeats)
            .IsRequired();

        builder.Property(e => e.Notes)
            .HasMaxLength(2000);

        // Relationships
        builder.HasOne(e => e.Semester)
            .WithMany(s => s.SemesterPrograms)
            .HasForeignKey(e => e.SemesterId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(e => e.Program)
            .WithMany(p => p.SemesterPrograms)
            .HasForeignKey(e => e.ProgramId)
            .OnDelete(DeleteBehavior.Restrict); // Prevent cascade delete from both sides
    }
}
