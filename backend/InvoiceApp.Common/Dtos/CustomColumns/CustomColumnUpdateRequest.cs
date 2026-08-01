namespace InvoiceApp.Common.Dtos.CustomColumns;

public class CustomColumnUpdateRequest
{
    public string Label { get; set; } = string.Empty;
    public int DisplayOrder { get; set; }
    public bool IsActive { get; set; }
}
