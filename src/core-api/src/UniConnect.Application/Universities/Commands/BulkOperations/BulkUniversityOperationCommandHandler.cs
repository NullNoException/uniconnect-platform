using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Universities.Commands.BulkOperations;

public class BulkUniversityOperationCommandHandler : IRequestHandler<BulkUniversityOperationCommand, BulkUniversityOperationResponse>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILogger<BulkUniversityOperationCommandHandler> _logger;

    public BulkUniversityOperationCommandHandler(
        IApplicationDbContext context,
        ICurrentUserService currentUserService,
        ILogger<BulkUniversityOperationCommandHandler> logger)
    {
        _context = context;
        _currentUserService = currentUserService;
        _logger = logger;
    }

    public async Task<BulkUniversityOperationResponse> Handle(BulkUniversityOperationCommand request, CancellationToken cancellationToken)
    {
        var results = new List<BulkOperationResult>();
        var errors = new List<string>();

        if (request.Request.UniversityIds.Count == 0)
        {
            errors.Add("No university IDs provided");
            return new BulkUniversityOperationResponse
            {
                TotalRequested = 0,
                Successful = 0,
                Failed = 0,
                Results = results,
                Errors = errors
            };
        }

        var universities = await _context.Universities
            .Where(u => request.Request.UniversityIds.Contains(u.Id))
            .ToListAsync(cancellationToken);

        var currentUserId = !string.IsNullOrEmpty(_currentUserService.UserId)
            ? Guid.Parse(_currentUserService.UserId)
            : (Guid?)null;
        var timestamp = DateTime.UtcNow;
        var successful = 0;
        var failed = 0;

        foreach (var universityId in request.Request.UniversityIds)
        {
            var university = universities.FirstOrDefault(u => u.Id == universityId);
            BulkOperationResult result;

            try
            {
                if (university == null)
                {
                    result = new BulkOperationResult
                    {
                        UniversityId = universityId,
                        UniversityName = "Unknown",
                        Success = false,
                        ErrorMessage = "University not found"
                    };
                    failed++;
                    results.Add(result);
                    continue;
                }

                switch (request.Request.OperationType)
                {
                    case BulkOperationType.UpdateStatus:
                        await HandleStatusUpdate(university, request.Request.Data, currentUserId, timestamp);
                        break;

                    case BulkOperationType.Verify:
                        await HandleVerification(university, request.Request.Data, currentUserId, timestamp);
                        break;

                    case BulkOperationType.SoftDelete:
                        await HandleSoftDelete(university, currentUserId, timestamp);
                        break;

                    case BulkOperationType.Restore:
                        await HandleRestore(university, currentUserId, timestamp);
                        break;

                    case BulkOperationType.UpdateProperty:
                        await HandlePropertyUpdate(university, request.Request.Data, currentUserId, timestamp);
                        break;

                    default:
                        throw new ArgumentException($"Unsupported operation type: {request.Request.OperationType}");
                }

                result = new BulkOperationResult
                {
                    UniversityId = universityId,
                    UniversityName = university.Name,
                    Success = true,
                    ErrorMessage = null
                };
                successful++;
            }
            catch (Exception ex)
            {
                result = new BulkOperationResult
                {
                    UniversityId = universityId,
                    UniversityName = university?.Name ?? "Unknown",
                    Success = false,
                    ErrorMessage = ex.Message
                };
                failed++;

                _logger.LogError(ex, "Error processing bulk operation for university {UniversityId}: {Operation}",
                    universityId, request.Request.OperationType);
            }

            results.Add(result);
        }

        if (successful > 0)
        {
            await _context.SaveChangesAsync(cancellationToken);
            _logger.LogInformation("Bulk operation completed: {Successful}/{Total} successful",
                successful, request.Request.UniversityIds.Count);
        }

        return new BulkUniversityOperationResponse
        {
            TotalRequested = request.Request.UniversityIds.Count,
            Successful = successful,
            Failed = failed,
            Results = results,
            Errors = errors
        };
    }

    private static Task HandleStatusUpdate(Domain.Entities.University university, BulkOperationData? data, Guid? currentUserId, DateTime timestamp)
    {
        if (data?.Status == null)
            throw new ArgumentException("Status is required for status update operation");

        university.Status = data.Status.Value;
        university.UpdatedBy = currentUserId?.ToString();
        university.UpdatedAt = timestamp;

        return Task.CompletedTask;
    }

    private static Task HandleVerification(Domain.Entities.University university, BulkOperationData? data, Guid? currentUserId, DateTime timestamp)
    {
        if (data?.IsApproved == null)
            throw new ArgumentException("IsApproved is required for verification operation");

        university.Status = data.IsApproved.Value ? UniversityStatus.Verified : UniversityStatus.Rejected;
        university.AccreditationStatus = data.IsApproved.Value ? AccreditationStatus.Accredited : AccreditationStatus.NotAccredited;
        university.UpdatedBy = currentUserId?.ToString();
        university.UpdatedAt = timestamp;

        return Task.CompletedTask;
    }

    private static Task HandleSoftDelete(Domain.Entities.University university, Guid? currentUserId, DateTime timestamp)
    {
        university.IsDeleted = true;
        university.Status = UniversityStatus.Inactive;
        university.UpdatedBy = currentUserId?.ToString();
        university.UpdatedAt = timestamp;

        return Task.CompletedTask;
    }

    private static Task HandleRestore(Domain.Entities.University university, Guid? currentUserId, DateTime timestamp)
    {
        university.IsDeleted = false;
        university.Status = UniversityStatus.PendingReview;
        university.UpdatedBy = currentUserId?.ToString();
        university.UpdatedAt = timestamp;

        return Task.CompletedTask;
    }

    private static Task HandlePropertyUpdate(Domain.Entities.University university, BulkOperationData? data, Guid? currentUserId, DateTime timestamp)
    {
        if (string.IsNullOrEmpty(data?.UpdateField) || data.UpdateValue == null)
            throw new ArgumentException("UpdateField and UpdateValue are required for property update operation");

        // Use reflection to update the property
        var property = typeof(Domain.Entities.University).GetProperty(data.UpdateField);
        if (property == null || !property.CanWrite)
            throw new ArgumentException($"Property '{data.UpdateField}' not found or not writable");

        // Convert value to appropriate type
        var convertedValue = Convert.ChangeType(data.UpdateValue, property.PropertyType);
        property.SetValue(university, convertedValue);

        university.UpdatedBy = currentUserId?.ToString();
        university.UpdatedAt = timestamp;

        return Task.CompletedTask;
    }
}
