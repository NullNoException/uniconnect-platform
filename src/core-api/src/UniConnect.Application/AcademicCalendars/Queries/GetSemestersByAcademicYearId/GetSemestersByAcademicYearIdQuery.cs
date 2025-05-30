using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Queries.GetSemestersByAcademicYearId;

public record GetSemestersByAcademicYearIdQuery(Guid AcademicYearId) : IRequest<List<SemesterDto>>;

public class GetSemestersByAcademicYearIdQueryHandler : IRequestHandler<GetSemestersByAcademicYearIdQuery, List<SemesterDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetSemestersByAcademicYearIdQueryHandler(
        IApplicationDbContext context,
        IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<List<SemesterDto>> Handle(GetSemestersByAcademicYearIdQuery request, CancellationToken cancellationToken)
    {
        // First check if the academic year exists
        var academicYearExists = await _context.AcademicYears
            .AnyAsync(ay => ay.Id == request.AcademicYearId, cancellationToken);

        if (!academicYearExists)
        {
            throw new NotFoundException(nameof(AcademicYear), request.AcademicYearId);
        }

        // Get all semesters for the academic year
        return await _context.Semesters
            .Where(s => s.AcademicYearId == request.AcademicYearId)
            .OrderBy(s => s.Order)
            .ProjectTo<SemesterDto>(_mapper.ConfigurationProvider)
            .ToListAsync(cancellationToken);
    }
}
