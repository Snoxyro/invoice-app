namespace InvoiceApp.Common.Entities;

public class ProfileVatRate : BaseEntity
{
    public int ProfileVatRateId { get; set; }
    public int ProfileId { get; set; }
    public Profile Profile { get; set; } = null!;
    public int VatRateId { get; set; }
    public VatRate VatRate { get; set; } = null!;
}