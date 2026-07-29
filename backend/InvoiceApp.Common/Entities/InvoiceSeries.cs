namespace InvoiceApp.Common.Entities;

public class InvoiceSeries : BaseEntity
{
    public int InvoiceSeriesId { get; set; }
    public int BranchId { get; set; }
    public Branch Branch { get; set; } = null!;
    public string Prefix { get; set; } = string.Empty;
    public int LastUsedYear { get; set; }
    public int NextNumber { get; set; }
    public bool IsActive { get; set; }
}
