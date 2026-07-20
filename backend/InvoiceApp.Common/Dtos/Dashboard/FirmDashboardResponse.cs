namespace InvoiceApp.Common.Dtos.Dashboard;

public class FirmDashboardResponse
{
    public InvoiceStatsResponse? InvoiceStats { get; set; }
    public int? CustomerCount { get; set; }
    public int? NewCustomersThisMonth { get; set; }
    public int? UserCount { get; set; }
    public int? ProfileCount { get; set; }
}
