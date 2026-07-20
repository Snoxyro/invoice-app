namespace InvoiceApp.Common.Dtos.Dashboard;

public class InvoiceStatsResponse
{
    public int TotalInvoiceCount { get; set; }
    public int InvoiceCountThisMonth { get; set; }
    public decimal TotalRevenue { get; set; }
    public decimal RevenueThisMonth { get; set; }
    public List<RecentInvoiceItem> RecentInvoices { get; set; } = new();
}
