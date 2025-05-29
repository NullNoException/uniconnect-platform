using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Universities.DTOs;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Universities.Commands.VerifyUniversity;

public class VerifyUniversityCommandHandler : IRequestHandler<VerifyUniversityCommand, UniversityDto>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public VerifyUniversityCommandHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<UniversityDto> Handle(VerifyUniversityCommand request, CancellationToken cancellationToken)
    {
        var university = await _context.Universities
            .FirstOrDefaultAsync(u => u.Id == request.Request.UniversityId, cancellationToken);

        if (university == null)
        {
            throw new ArgumentException($"University with ID {request.Request.UniversityId} not found.");
        }

        // Update verification status
        university.Status = request.Request.Status;
        university.ReviewedAt = DateTime.UtcNow;
        university.UpdatedAt = DateTime.UtcNow;

        if (request.Request.Status == UniversityStatus.Rejected)
        {
            university.RejectionReason = request.Request.Comments;
        }
        else
        {
            university.RejectionReason = null;
        }

        await _context.SaveChangesAsync(cancellationToken);

        // Load the updated university with related data for response
        var updatedUniversity = await _context.Universities
            .Include(u => u.Country)
            .Include(u => u.Contacts)
            .Include(u => u.Addresses)
                .ThenInclude(a => a.Country)
            .Include(u => u.AcademicPrograms)
                .ThenInclude(p => p.AcademicLevel)
            .Include(u => u.AcademicPrograms)
                .ThenInclude(p => p.Major)
            .FirstOrDefaultAsync(u => u.Id == university.Id, cancellationToken);

        if (updatedUniversity == null)
        {
            throw new InvalidOperationException("Failed to retrieve the updated university.");
        }

        return _mapper.Map<UniversityDto>(updatedUniversity);
    }
}
