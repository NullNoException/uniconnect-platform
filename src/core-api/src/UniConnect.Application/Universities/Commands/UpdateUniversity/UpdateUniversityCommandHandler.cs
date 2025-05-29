using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Universities.DTOs;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.Universities.Commands.UpdateUniversity;

public class UpdateUniversityCommandHandler : IRequestHandler<UpdateUniversityCommand, UniversityDto>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public UpdateUniversityCommandHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<UniversityDto> Handle(UpdateUniversityCommand request, CancellationToken cancellationToken)
    {
        // Find the existing university
        var university = await _context.Universities
            .FirstOrDefaultAsync(u => u.Id == request.Request.Id, cancellationToken);

        if (university == null)
        {
            throw new ArgumentException($"University with ID {request.Request.Id} not found.");
        }

        // Validate that the country exists
        var country = await _context.Countries
            .FirstOrDefaultAsync(c => c.Id == request.Request.CountryId, cancellationToken);

        if (country == null)
        {
            throw new ArgumentException($"Country with ID {request.Request.CountryId} not found.");
        }

        // Update university properties
        university.Name = request.Request.Name;
        university.Description = request.Request.Description;
        university.CountryId = request.Request.CountryId;
        university.Website = request.Request.Website;
        university.Email = request.Request.Email;
        university.Phone = request.Request.Phone;
        university.EstablishedYear = request.Request.EstablishedYear;
        university.Type = request.Request.Type;
        university.AccreditationBody = request.Request.AccreditationBody;
        university.AccreditationDate = request.Request.AccreditationDate;
        university.Ranking = request.Request.Ranking;
        university.IsActive = request.Request.IsActive;
        university.UpdatedAt = DateTime.UtcNow;

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
