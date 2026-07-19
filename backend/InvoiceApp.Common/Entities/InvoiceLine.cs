namespace InvoiceApp.Common.Entities;

public class InvoiceLine : BaseEntity
{
    public int InvoiceLineId { get; set; }
    public int InvoiceId { get; set; }
    public Invoice Invoice { get; set; } = null!;
    public string ItemName { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public decimal Price { get; set; }
    public int VatRateId { get; set; }
    public VatRate VatRate { get; set; } = null!;
    public int UserId { get; set; }
    public User User { get; set; } = null!;
}
