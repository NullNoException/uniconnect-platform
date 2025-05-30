using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.AcademicCalendars.Commands.CreateSemester;

public record CreateSemesterCommand(CreateSemesterRequest Request) : IRequest<SemesterDto>;

public class CreateSemesterCommandHandler : IRequestHandler<CreateSemesterCommand, SemesterDto>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public CreateSemesterCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<SemesterDto> Handle(CreateSemesterCommand request, CancellationToken cancellationToken)
    {
        // Verify academic year exists
        var academicYear = await _context.AcademicYears
            .Include(ay => ay.AcademicCalendar)
            .FirstOrDefaultAsync(ay => ay.Id == request.Request.AcademicYearId, cancellationToken);

        if (academicYear == null)
        {
            throw new NotFoundException(nameof(AcademicYear), request.Request.AcademicYearId);
        }

        // Validate dates
        if (request.Request.StartDate >= request.Request.EndDate)
        {
            throw new ValidationException("EndDate", "End date must be after start date");
        }

        // Validate dates are within academic year range
        if (request.Request.StartDate < academicYear.StartDate || request.Request.EndDate > academicYear.EndDate)
        {
            throw new ValidationException("DateRange", "Semester dates must be within the academic year date range");
        }

        // Validate code is unique within the academic year
        var codeExists = await _context.Semesters
            .Where(s => s.AcademicYearId == request.Request.AcademicYearId && s.Code == request.Request.Code)
            .AnyAsync(cancellationToken);

        if (codeExists)
        {
            throw new ValidationException("Code", $"A semester with code '{request.Request.Code}' already exists in this academic year");
        }

        // Create semester
        var semester = new Semester
        {
            AcademicYearId = request.Request.AcademicYearId,
            Name = request.Request.Name,
            Code = request.Request.Code,
            Description = request.Request.Description,
            StartDate = request.Request.StartDate,
            EndDate = request.Request.EndDate,
            Status = request.Request.Status,
            Order = request.Request.Order,
            CreatedBy = _currentUserService.UserId,
            CreatedAt = DateTime.UtcNow
        };

        await _context.Semesters.AddAsync(semester, cancellationToken);
        await _context.SaveChangesAsync(cancellationToken);

        // Return DTO with academic year name
        var result = _mapper.Map<SemesterDto>(semester);
        result.AcademicYearName = academicYear.Name;

        return result;
    }
}
