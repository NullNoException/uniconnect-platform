namespace UniConnect.Domain.Enums;

public enum DeadlineType
{
    ApplicationStart = 1,
    ApplicationEnd = 2,
    EnrollmentStart = 3,
    EnrollmentEnd = 4,
    PaymentDeadline = 5,
    AddDropPeriodStart = 6,
    AddDropPeriodEnd = 7,
    WithdrawalDeadline = 8,
    FinalExamStart = 9,
    FinalExamEnd = 10,
    GradeSubmissionDeadline = 11,
    Custom = 99
}
