using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Commands.BulkOperations;

public record BulkUniversityOperationCommand(
    BulkUniversityOperationRequest Request
) : IRequest<BulkUniversityOperationResponse>;

public record BulkUniversityOperationRequest
{
    public List<Guid> UniversityIds { get; init; } = new();
    public BulkOperationType OperationType { get; init; }
    public BulkOperationData? Data { get; init; }
}

public record BulkOperationData
{
    // For bulk status updates
    public Domain.Enums.UniversityStatus? Status { get; init; }

    // For bulk verification
    public bool? IsApproved { get; init; }
    public string? VerificationNotes { get; init; }

    // For bulk soft delete
    public bool? IsDeleted { get; init; }

    // For bulk property updates
    public string? UpdateField { get; init; }
    public object? UpdateValue { get; init; }
}

public enum BulkOperationType
{
    UpdateStatus,
    Verify,
    SoftDelete,
    Restore,
    UpdateProperty
}

public record BulkUniversityOperationResponse
{
    public int TotalRequested { get; init; }
    public int Successful { get; init; }
    public int Failed { get; init; }
    public List<BulkOperationResult> Results { get; init; } = new();
    public List<string> Errors { get; init; } = new();
}

public record BulkOperationResult
{
    public Guid UniversityId { get; init; }
    public string UniversityName { get; init; } = string.Empty;
    public bool Success { get; init; }
    public string? ErrorMessage { get; init; }
}
