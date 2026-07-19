namespace InvoiceApp.Common.Dtos.Profiles;

public class ProfileResponse
{
    public int ProfileId { get; set; }
    public string Name { get; set; } = string.Empty;
    public bool IsSystem { get; set; }
    public decimal? MinInvoiceAmount { get; set; }
    public decimal? MaxInvoiceAmount { get; set; }
    public List<int> PermissionIds { get; set; } = new();
    public List<int> VatRateIds { get; set; } = new();
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}
