namespace InvoiceApp.Common.Dtos.Profiles;

public class ProfileCreateRequest
{
    public string Name { get; set; } = string.Empty;
    public List<int> PermissionIds { get; set; } = new();
    public List<int> VatRateIds { get; set; } = new();
    public decimal? MinInvoiceAmount { get; set; }
    public decimal? MaxInvoiceAmount { get; set; }
}
