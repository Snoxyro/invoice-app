namespace InvoiceApp.Common.Entities;

public class VatRate : BaseEntity
{
    public int VatRateId { get; set; }
    public decimal Rate { get; set; }
    public ICollection<ProfileVatRate> ProfileVatRates { get; set; } = new List<ProfileVatRate>();
}