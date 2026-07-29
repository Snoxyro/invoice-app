namespace InvoiceApp.Common.Entities;

public class Branch : BaseEntity
{
    public int BranchId { get; set; }
    public int FirmId { get; set; }
    public Firm Firm { get; set; } = null!;
    public string Name { get; set; } = string.Empty;
    public bool IsHeadquarters { get; set; }
    public string? Address { get; set; }
    public string? City { get; set; }
    public string? TaxOffice { get; set; }
    public string? Phone { get; set; }
    public string? Fax { get; set; }
    public string? Email { get; set; }
    public string? Website { get; set; }
    public ICollection<User> Users { get; set; } = new List<User>();
    public ICollection<Customer> Customers { get; set; } = new List<Customer>();
    public ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();
    public ICollection<InvoiceSeries> InvoiceSeries { get; set; } = new List<InvoiceSeries>();
}
