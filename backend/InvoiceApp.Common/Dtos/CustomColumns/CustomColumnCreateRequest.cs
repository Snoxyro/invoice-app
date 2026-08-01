namespace InvoiceApp.Common.Dtos.CustomColumns;

public class CustomColumnCreateRequest
{
    public string Label { get; set; } = string.Empty;
    public int DisplayOrder { get; set; }
}
