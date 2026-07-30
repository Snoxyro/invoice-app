namespace InvoiceApp.Common.Entities;

public class Invoice : BaseEntity
{
    public int InvoiceId { get; set; }
    public int CustomerId { get; set; }
    public Customer Customer { get; set; } = null!;
    public string? InvoiceNumber { get; set; }
    public DateTime InvoiceDate { get; set; }
    public decimal Subtotal { get; set; }
    public decimal VatTotal { get; set; }
    public decimal GrandTotal { get; set; }
    public int FirmId { get; set; }
    public Firm Firm { get; set; } = null!;
    public int? BranchId { get; set; }
    public Branch? Branch { get; set; }
    public int InvoiceSeriesId { get; set; }
    public InvoiceSeries InvoiceSeries { get; set; } = null!;
    public InvoiceStatus Status { get; set; }
    public string? GibStatusCode { get; set; }
    public string? GibStatusMessage { get; set; }
    public DateTime? SentDate { get; set; }
    public int CreatedByUserId { get; set; }
    public User CreatedByUser { get; set; } = null!;
    public bool IsDeleted { get; set; }
    public DateTime? DeletedDate { get; set; }
    public ICollection<InvoiceLine> InvoiceLines { get; set; } = new List<InvoiceLine>();
}
