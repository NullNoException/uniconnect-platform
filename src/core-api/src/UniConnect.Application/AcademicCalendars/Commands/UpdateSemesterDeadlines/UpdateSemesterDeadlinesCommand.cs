using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Application.Common.Exceptions;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Commands.UpdateSemesterDeadlines;

public record UpdateSemesterDeadlinesCommand(UpdateSemesterDeadlinesRequest Request) : IRequest<List<DeadlineDto>>;

public class UpdateSemesterDeadlinesCommandHandler : IRequestHandler<UpdateSemesterDeadlinesCommand, List<DeadlineDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public UpdateSemesterDeadlinesCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _context = context;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<List<DeadlineDto>> Handle(UpdateSemesterDeadlinesCommand request, CancellationToken cancellationToken)
    {
        // Verify semester exists
        var semester = await _context.Semesters
            .Include(s => s.Deadlines)
            .FirstOrDefaultAsync(s => s.Id == request.Request.SemesterId, cancellationToken);

        if (semester == null)
        {
            throw new NotFoundException(nameof(Semester), request.Request.SemesterId);
        }

        var currentTime = DateTime.UtcNow;
        var currentUserId = _currentUserService.UserId;

        // Process deadlines
        foreach (var deadlineRequest in request.Request.Deadlines)
        {
            if (deadlineRequest.Id.HasValue)
            {
                // Update or delete existing deadline
                var existingDeadline = semester.Deadlines
                    .FirstOrDefault(d => d.Id == deadlineRequest.Id.Value);

                if (existingDeadline == null)
                {
                    throw new NotFoundException(nameof(Deadline), deadlineRequest.Id.Value);
                }

                if (deadlineRequest.DeleteExisting)
                {
                    // Remove deadline
                    _context.Deadlines.Remove(existingDeadline);
                }
                else
                {
                    // Update deadline
                    existingDeadline.Name = deadlineRequest.Name;
                    existingDeadline.Description = deadlineRequest.Description;
                    existingDeadline.Type = deadlineRequest.Type;
                    existingDeadline.Date = deadlineRequest.Date;
                    existingDeadline.UpdatedBy = currentUserId;
                    existingDeadline.UpdatedAt = currentTime;
                }
            }
            else if (!deadlineRequest.DeleteExisting)
            {
                // Create new deadline
                var newDeadline = new Deadline
                {
                    SemesterId = semester.Id,
                    Name = deadlineRequest.Name,
                    Description = deadlineRequest.Description,
                    Type = deadlineRequest.Type,
                    Date = deadlineRequest.Date,
                    CreatedBy = currentUserId,
                    CreatedAt = currentTime
                };

                await _context.Deadlines.AddAsync(newDeadline, cancellationToken);
            }
        }

        await _context.SaveChangesAsync(cancellationToken);

        // Get updated deadlines from database
        var updatedDeadlines = await _context.Deadlines
            .Where(d => d.SemesterId == request.Request.SemesterId)
            .OrderBy(d => d.Date)
            .ToListAsync(cancellationToken);

        // Map deadlines to DTOs and return
        return _mapper.Map<List<DeadlineDto>>(updatedDeadlines);
    }
}
