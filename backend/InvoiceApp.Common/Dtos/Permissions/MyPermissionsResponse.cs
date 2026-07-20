using InvoiceApp.Common.Dtos.VatRates;

namespace InvoiceApp.Common.Dtos.Permissions;

public class MyPermissionsResponse
{
    public int? ProfileId { get; set; }
    public string? ProfileName { get; set; }
    public bool IsSystemProfile { get; set; }
    public List<string> Permissions { get; set; } = new();
    public List<VatRateResponse> VatRates { get; set; } = new();
    public decimal? MinInvoiceAmount { get; set; }
    public decimal? MaxInvoiceAmount { get; set; }
}