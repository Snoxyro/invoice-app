namespace InvoiceApp.Common.Dtos.Dashboard;

public class RecentFirmItem
{
    public int FirmId { get; set; }
    public string Name { get; set; } = string.Empty;
    public DateTime CreatedDate { get; set; }
}
