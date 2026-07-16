namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceResponse
{
    public int InvoiceId { get; set; }
    public string InvoiceNumber { get; set; } = string.Empty;
    public DateTime InvoiceDate { get; set; }
    public decimal TotalAmount { get; set; }
    public int CustomerId { get; set; }
    public string CustomerTitle { get; set; } = string.Empty;
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
    public List<InvoiceLineResponse> Lines { get; set; } = new();
}