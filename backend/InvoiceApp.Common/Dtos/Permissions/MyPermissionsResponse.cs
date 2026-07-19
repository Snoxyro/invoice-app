namespace InvoiceApp.Common.Dtos.Permissions;

public class MyPermissionsResponse
{
    public int? ProfileId { get; set; }
    public bool IsSystemProfile { get; set; }
    public List<string> Permissions { get; set; } = new();
    public List<int> VatRateIds { get; set; } = new();
    public decimal? MinInvoiceAmount { get; set; }
    public decimal? MaxInvoiceAmount { get; set; }
}
