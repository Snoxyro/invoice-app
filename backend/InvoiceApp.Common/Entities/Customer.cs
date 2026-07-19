namespace InvoiceApp.Common.Entities;

public class Customer : BaseEntity
{
    public int CustomerId { get; set; }
    public string TaxNumber { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public int FirmId { get; set; }
    public Firm Firm { get; set; } = null!;
    public ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();
}