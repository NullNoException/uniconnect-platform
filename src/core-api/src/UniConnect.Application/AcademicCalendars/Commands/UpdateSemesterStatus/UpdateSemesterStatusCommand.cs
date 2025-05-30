using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterStatus;

public record UpdateSemesterStatusCommand(Guid Id, SemesterStatus Status) : IRequest<SemesterDto>;

public class UpdateSemesterStatusCommandHandler : IRequestHandler<UpdateSemesterStatusCommand, SemesterDto>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public UpdateSemesterStatusCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<SemesterDto> Handle(UpdateSemesterStatusCommand request, CancellationToken cancellationToken)
    {
        var semester = await _context.Semesters
            .Include(s => s.AcademicYear)
            .FirstOrDefaultAsync(s => s.Id == request.Id, cancellationToken);

        if (semester == null)
        {
            throw new NotFoundException(nameof(Semester), request.Id);
        }

        // Update the status
        semester.Status = request.Status;
        semester.UpdatedBy = _currentUserService.UserId;
        semester.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync(cancellationToken);

        // Return the updated semester
        var result = _mapper.Map<SemesterDto>(semester);
        result.AcademicYearName = semester.AcademicYear.Name;

        return result;
    }
}
