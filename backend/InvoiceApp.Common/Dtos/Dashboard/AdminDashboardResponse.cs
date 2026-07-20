namespace InvoiceApp.Common.Dtos.Dashboard;

public class AdminDashboardResponse
{
    public int TotalFirmCount { get; set; }
    public int NewFirmsThisMonth { get; set; }
    public List<RecentFirmItem> RecentFirms { get; set; } = new();
}
