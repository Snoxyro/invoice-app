namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceCreateRequest
{
    public int CustomerId { get; set; }
    public int InvoiceSeriesId { get; set; }
    public DateTime InvoiceDate { get; set; }
    public List<InvoiceLineRequest> Lines { get; set; } = new();
}
