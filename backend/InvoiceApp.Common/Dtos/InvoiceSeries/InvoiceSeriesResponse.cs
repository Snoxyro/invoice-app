namespace InvoiceApp.Common.Dtos.InvoiceSeries;

public class InvoiceSeriesResponse
{
    public int InvoiceSeriesId { get; set; }
    public int BranchId { get; set; }
    public string Prefix { get; set; } = string.Empty;
    public int LastUsedYear { get; set; }
    public int NextNumber { get; set; }
    public bool IsActive { get; set; }
}
