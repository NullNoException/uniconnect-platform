using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Queries.GetSemesterById;

public record GetSemesterByIdQuery(Guid Id) : IRequest<SemesterDto>;

public class GetSemesterByIdQueryHandler : IRequestHandler<GetSemesterByIdQuery, SemesterDto>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetSemesterByIdQueryHandler(
        IApplicationDbContext context,
        IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<SemesterDto> Handle(GetSemesterByIdQuery request, CancellationToken cancellationToken)
    {
        var semester = await _context.Semesters
            .Include(s => s.AcademicYear)
            .Include(s => s.Deadlines)
            .Include(s => s.AvailablePrograms)
            .FirstOrDefaultAsync(s => s.Id == request.Id, cancellationToken);

        if (semester == null)
        {
            throw new NotFoundException(nameof(Semester), request.Id);
        }

        var result = _mapper.Map<SemesterDto>(semester);
        result.AcademicYearName = semester.AcademicYear.Name;

        return result;
    }
}
