namespace InvoiceApp.Common.Dtos.CustomColumns;

public class CustomColumnResponse
{
    public int InvoiceLineCustomColumnDefinitionId { get; set; }
    public string Label { get; set; } = string.Empty;
    public int DisplayOrder { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}
