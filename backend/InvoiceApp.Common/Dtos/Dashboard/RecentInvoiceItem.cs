namespace InvoiceApp.Common.Dtos.Dashboard;

public class RecentInvoiceItem
{
    public int InvoiceId { get; set; }
    public string InvoiceNumber { get; set; } = string.Empty;
    public string CustomerTitle { get; set; } = string.Empty;
    public decimal GrandTotal { get; set; }
    public DateTime InvoiceDate { get; set; }
}
