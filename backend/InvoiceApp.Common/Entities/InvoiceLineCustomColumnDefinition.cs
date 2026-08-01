namespace InvoiceApp.Common.Entities;

public class InvoiceLineCustomColumnDefinition : BaseEntity
{
    public int InvoiceLineCustomColumnDefinitionId { get; set; }
    public int FirmId { get; set; }
    public Firm Firm { get; set; } = null!;
    public string Label { get; set; } = string.Empty;
    public int DisplayOrder { get; set; }
    public bool IsActive { get; set; }
}
