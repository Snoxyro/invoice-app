namespace InvoiceApp.Common.Entities;

public class InvoiceLineCustomValue : BaseEntity
{
    public int InvoiceLineCustomValueId { get; set; }
    public int InvoiceLineId { get; set; }
    public InvoiceLine InvoiceLine { get; set; } = null!;
    public string Label { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
    public int DisplayOrder { get; set; }
}
