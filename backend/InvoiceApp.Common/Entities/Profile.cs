namespace InvoiceApp.Common.Entities;

public class Profile : BaseEntity
{
    public int ProfileId { get; set; }
    public int FirmId { get; set; }
    public Firm Firm { get; set; } = null!;
    public string Name { get; set; } = string.Empty;
    public bool IsSystem { get; set; }
    public decimal? MinInvoiceAmount { get; set; }
    public decimal? MaxInvoiceAmount { get; set; }
    public ICollection<User> Users { get; set; } = new List<User>();
    public ICollection<ProfilePermission> ProfilePermissions { get; set; } = new List<ProfilePermission>();
    public ICollection<ProfileVatRate> ProfileVatRates { get; set; } = new List<ProfileVatRate>();
}