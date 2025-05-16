namespace UniConnect.Domain.Enums;

public enum ServiceRequestStatus
{
    Draft = 1,
    Submitted = 2,
    InReview = 3,
    InProgress = 4,
    AwaitingFeedback = 5,
    Completed = 6,
    Cancelled = 7,
    Rejected = 8
}
