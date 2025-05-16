using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class StudentConfiguration : IEntityTypeConfiguration<Student>
{
    public void Configure(EntityTypeBuilder<Student> builder)
    {
        builder.HasKey(s => s.Id);

        // Configure relationship with User
        builder.HasOne(s => s.User)
            .WithOne(u => u.Student)
            .HasForeignKey<Student>(s => s.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with University
        builder.HasOne(s => s.CurrentUniversity)
            .WithMany(u => u.Students)
            .HasForeignKey(s => s.CurrentUniversityId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.SetNull);

        // Configure relationship with FieldOfStudy
        builder.HasOne(s => s.FieldOfStudy)
            .WithMany(f => f.Students)
            .HasForeignKey(s => s.FieldOfStudyId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.SetNull);

        // Configure relationship with ServiceRequests
        builder.HasMany(s => s.ServiceRequests)
            .WithOne(sr => sr.Student)
            .HasForeignKey(sr => sr.StudentId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
