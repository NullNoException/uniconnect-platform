using MediatR;
using Microsoft.EntityFrameworkCore;
using UniConnect.Application.Common.Interfaces;

namespace UniConnect.Application.Universities.Commands.DeleteUniversity;

public class DeleteUniversityCommandHandler : IRequestHandler<DeleteUniversityCommand, bool>
{
    private readonly IApplicationDbContext _context;

    public DeleteUniversityCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<bool> Handle(DeleteUniversityCommand request, CancellationToken cancellationToken)
    {
        var university = await _context.Universities
            .FirstOrDefaultAsync(u => u.Id == request.Id, cancellationToken);

        if (university == null)
        {
            return false;
        }

        // Soft delete
        university.IsDeleted = true;
        university.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync(cancellationToken);
        return true;
    }
}
