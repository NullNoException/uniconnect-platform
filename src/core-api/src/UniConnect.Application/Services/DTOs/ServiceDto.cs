namespace UniConnect.Application.Services.DTOs;

public class ServiceDto
{
    public Guid Id { get; set; }
    public string ServiceName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public Guid ProviderId { get; set; }
    public Guid CategoryId { get; set; }
    public bool IsActive { get; set; }
    public decimal BasePrice { get; set; }
    public Guid CurrencyId { get; set; }
    public int? EstimatedDeliveryDays { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
