using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Universities.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Universities.Commands.CreateUniversity;

public class CreateUniversityCommandHandler : IRequestHandler<CreateUniversityCommand, UniversityDto>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public CreateUniversityCommandHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<UniversityDto> Handle(CreateUniversityCommand request, CancellationToken cancellationToken)
    {
        // Validate that the country exists
        var country = await _context.Countries
            .FirstOrDefaultAsync(c => c.Id == request.Request.CountryId, cancellationToken);

        if (country == null)
        {
            throw new ArgumentException($"Country with ID {request.Request.CountryId} not found.");
        }

        // Create the university entity
        var university = new University
        {
            Id = Guid.NewGuid(),
            Name = request.Request.Name,
            Description = request.Request.Description,
            CountryId = request.Request.CountryId,
            Website = request.Request.Website,
            Email = request.Request.Email,
            Phone = request.Request.Phone,
            EstablishedYear = request.Request.EstablishedYear,
            Type = request.Request.Type,
            AccreditationBody = request.Request.AccreditationBody,
            AccreditationDate = request.Request.AccreditationDate,
            Ranking = request.Request.Ranking,
            Status = UniversityStatus.PendingReview,
            AccreditationStatus = request.Request.AccreditationDate.HasValue
                ? AccreditationStatus.Accredited
                : AccreditationStatus.NotAccredited,
            IsActive = true,
            CreatedAt = DateTime.UtcNow
        };

        _context.Universities.Add(university);

        // Create university address if provided
        if (request.Request.Address != null)
        {
            var address = new UniversityAddress
            {
                Id = Guid.NewGuid(),
                UniversityId = university.Id,
                AddressType = request.Request.Address.AddressType,
                Street = request.Request.Address.Street,
                City = request.Request.Address.City,
                State = request.Request.Address.State,
                PostalCode = request.Request.Address.PostalCode,
                CountryId = request.Request.Address.CountryId,
                Latitude = request.Request.Address.Latitude,
                Longitude = request.Request.Address.Longitude,
                IsPrimary = request.Request.Address.IsPrimary,
                IsActive = true,
                CreatedAt = DateTime.UtcNow
            };

            _context.UniversityAddresses.Add(address);
        }

        // Create university contacts if provided
        if (request.Request.Contacts.Any())
        {
            var contacts = request.Request.Contacts.Select(c => new UniversityContact
            {
                Id = Guid.NewGuid(),
                UniversityId = university.Id,
                ContactType = c.ContactType,
                Name = c.Name,
                Email = c.Email,
                Phone = c.Phone,
                Department = c.Department,
                IsPrimary = c.IsPrimary,
                IsActive = true,
                CreatedAt = DateTime.UtcNow
            }).ToList();

            _context.UniversityContacts.AddRange(contacts);
        }

        await _context.SaveChangesAsync(cancellationToken);

        // Load the created university with related data for response
        var createdUniversity = await _context.Universities
            .Include(u => u.Country)
            .Include(u => u.Contacts)
            .Include(u => u.Addresses)
                .ThenInclude(a => a.Country)
            .Include(u => u.AcademicPrograms)
                .ThenInclude(p => p.AcademicLevel)
            .Include(u => u.AcademicPrograms)
                .ThenInclude(p => p.Major)
            .FirstOrDefaultAsync(u => u.Id == university.Id, cancellationToken);

        if (createdUniversity == null)
        {
            throw new InvalidOperationException("Failed to retrieve the created university.");
        }

        return _mapper.Map<UniversityDto>(createdUniversity);
    }
}
