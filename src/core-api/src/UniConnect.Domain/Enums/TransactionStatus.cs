namespace UniConnect.Domain.Enums;

public enum TransactionStatus
{
    Pending = 1,
    Escrowed = 2,
    Completed = 3,
    Released = 4,
    Refunded = 5,
    Failed = 6,
    Disputed = 7,
    Cancelled = 8
}
