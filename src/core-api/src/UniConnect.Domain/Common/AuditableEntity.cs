namespace UniConnect.Domain.Common;

public abstract class AuditableEntity : BaseEntity
{
    public DateTime? LastModifiedDate { get; set; }
    public string? LastModifiedBy { get; set; }
}
