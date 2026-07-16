namespace InvoiceApp.Common.Entities;

public class Invoice : BaseEntity
{
    public int InvoiceId { get; set; }
    public int CustomerId { get; set; }
    public Customer Customer { get; set; } = null!;
    public string InvoiceNumber { get; set; } = string.Empty;
    public DateTime InvoiceDate { get; set; }
    public decimal TotalAmount { get; set; }
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    public bool IsDeleted { get; set; }
    public DateTime? DeletedDate { get; set; }
    public ICollection<InvoiceLine> InvoiceLines { get; set; } = new List<InvoiceLine>();
}