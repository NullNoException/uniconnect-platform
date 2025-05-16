using UniConnect.Domain.Common;

namespace UniConnect.Domain.Entities;

public class Invoice : BaseEntity
{
    public Guid EntityId { get; set; }
    public string EntityType { get; set; } = string.Empty;
    public string InvoiceNumber { get; set; } = string.Empty;
    public DateTime InvoiceDate { get; set; } = DateTime.UtcNow;
    public DateTime DueDate { get; set; }
    public decimal TotalAmount { get; set; }
    public Guid CurrencyId { get; set; }
    public string Status { get; set; } = "Unpaid";
    public DateTime? PaidDate { get; set; }
    public decimal? PaidAmount { get; set; }

    // Navigation properties
    public Currency Currency { get; set; } = null!;
    public ICollection<InvoiceItem> Items { get; private set; } = new List<InvoiceItem>();
}
