using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Queries.GetUniversityById;

public class GetUniversityByIdQueryHandler : IRequestHandler<GetUniversityByIdQuery, UniversityDto?>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetUniversityByIdQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<UniversityDto?> Handle(GetUniversityByIdQuery request, CancellationToken cancellationToken)
    {
        var university = await _context.Universities
            .Include(u => u.Country)
            .Include(u => u.Contacts.Where(c => c.IsActive))
            .Include(u => u.Addresses.Where(a => a.IsActive))
                .ThenInclude(a => a.Country)
            .Include(u => u.AcademicPrograms.Where(p => !p.IsDeleted))
                .ThenInclude(p => p.AcademicLevel)
            .Include(u => u.AcademicPrograms.Where(p => !p.IsDeleted))
                .ThenInclude(p => p.Major)
            .Include(u => u.AcademicPrograms.Where(p => !p.IsDeleted))
                .ThenInclude(p => p.Currency)
            .FirstOrDefaultAsync(u => u.Id == request.Id && !u.IsDeleted, cancellationToken);

        return university == null ? null : _mapper.Map<UniversityDto>(university);
    }
}
