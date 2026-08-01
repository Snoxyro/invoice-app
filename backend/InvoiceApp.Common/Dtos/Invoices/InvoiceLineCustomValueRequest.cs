namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceLineCustomValueRequest
{
    public int ColumnDefinitionId { get; set; }
    public string Value { get; set; } = string.Empty;
}
