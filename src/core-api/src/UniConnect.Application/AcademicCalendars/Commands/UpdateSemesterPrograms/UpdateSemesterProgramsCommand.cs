using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterPrograms;

public record UpdateSemesterProgramsCommand(UpdateSemesterProgramsRequest Request) : IRequest<List<SemesterProgramDto>>;

public class UpdateSemesterProgramsCommandHandler : IRequestHandler<UpdateSemesterProgramsCommand, List<SemesterProgramDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public UpdateSemesterProgramsCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<List<SemesterProgramDto>> Handle(UpdateSemesterProgramsCommand request, CancellationToken cancellationToken)
    {
        // Verify semester exists
        var semester = await _context.Semesters
            .Include(s => s.AvailablePrograms)
            .FirstOrDefaultAsync(s => s.Id == request.Request.SemesterId, cancellationToken);

        if (semester == null)
        {
            throw new NotFoundException(nameof(Semester), request.Request.SemesterId);
        }

        // Get the academic calendar ID for validation
        var academicCalendarId = await _context.AcademicYears
            .Where(ay => ay.Id == semester.AcademicYearId)
            .Select(ay => ay.AcademicCalendarId)
            .FirstOrDefaultAsync(cancellationToken);

        // Process each program request
        foreach (var programRequest in request.Request.Programs)
        {
            // Verify program exists
            var program = await _context.AcademicPrograms
                .FirstOrDefaultAsync(p => p.Id == programRequest.ProgramId, cancellationToken);

            if (program == null)
            {
                throw new NotFoundException(nameof(AcademicProgram), programRequest.ProgramId);
            }

            // Verify program belongs to the same university as the academic calendar
            if (program.UniversityId != await _context.AcademicCalendars
                .Where(ac => ac.Id == academicCalendarId)
                .Select(ac => ac.UniversityId)
                .FirstOrDefaultAsync(cancellationToken))
            {
                throw new ValidationException("ProgramId", $"Program with ID {programRequest.ProgramId} does not belong to the same university as the semester");
            }

            // Check if the program is already associated with the semester
            var existingAssociation = await _context.SemesterPrograms
                .FirstOrDefaultAsync(sp =>
                    sp.SemesterId == request.Request.SemesterId &&
                    sp.ProgramId == programRequest.ProgramId,
                    cancellationToken);

            if (existingAssociation != null)
            {
                if (programRequest.RemoveFromSemester)
                {
                    // Remove the association
                    _context.SemesterPrograms.Remove(existingAssociation);
                }
                else
                {
                    // Update the existing association
                    existingAssociation.IsActive = programRequest.IsActive;
                    existingAssociation.UpdatedBy = _currentUserService.UserId;
                    existingAssociation.UpdatedAt = DateTime.UtcNow;
                }
            }
            else if (!programRequest.RemoveFromSemester)
            {
                // Create a new association
                var semesterProgram = new SemesterProgram
                {
                    SemesterId = request.Request.SemesterId,
                    ProgramId = programRequest.ProgramId,
                    IsActive = programRequest.IsActive,
                    CreatedBy = _currentUserService.UserId,
                    CreatedAt = DateTime.UtcNow
                };

                await _context.SemesterPrograms.AddAsync(semesterProgram, cancellationToken);
            }
        }

        await _context.SaveChangesAsync(cancellationToken);

        // Fetch updated semester programs with program details for the response
        var updatedSemesterPrograms = await _context.SemesterPrograms
            .Include(sp => sp.Program)
            .Where(sp => sp.SemesterId == request.Request.SemesterId)
            .ToListAsync(cancellationToken);

        // Map to DTOs and return
        return _mapper.Map<List<SemesterProgramDto>>(updatedSemesterPrograms);
    }
}
