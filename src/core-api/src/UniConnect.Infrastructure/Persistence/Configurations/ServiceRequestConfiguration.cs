using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using UniConnect.Domain.Entities;

namespace UniConnect.Infrastructure.Persistence.Configurations;

public class ServiceRequestConfiguration : IEntityTypeConfiguration<ServiceRequest>
{
    public void Configure(EntityTypeBuilder<ServiceRequest> builder)
    {
        builder.HasKey(sr => sr.Id);

        builder.Property(sr => sr.RequestStatus)
            .IsRequired();

        builder.Property(sr => sr.InitiatedDate)
            .IsRequired();

        // Configure relationship with Student
        builder.HasOne(sr => sr.Student)
            .WithMany(s => s.ServiceRequests)
            .HasForeignKey(sr => sr.StudentId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Service
        builder.HasOne(sr => sr.Service)
            .WithMany(s => s.Requests)
            .HasForeignKey(sr => sr.ServiceId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Documents
        builder.HasMany(sr => sr.Documents)
            .WithOne(rd => rd.Request)
            .HasForeignKey(rd => rd.RequestId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Milestones
        builder.HasMany(sr => sr.Milestones)
            .WithOne(rm => rm.Request)
            .HasForeignKey(rm => rm.RequestId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Transactions
        builder.HasMany(sr => sr.Transactions)
            .WithOne(t => t.Request)
            .HasForeignKey(t => t.RequestId)
            .OnDelete(DeleteBehavior.Cascade);

        // Configure relationship with Conversations
        builder.HasMany(sr => sr.Conversations)
            .WithOne(c => c.Request)
            .HasForeignKey(c => c.RequestId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.Restrict);

        // Configure relationship with Reviews
        builder.HasMany(sr => sr.Reviews)
            .WithOne(r => r.Request)
            .HasForeignKey(r => r.RequestId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
