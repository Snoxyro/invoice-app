namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceLineCustomValueResponse
{
    public int ColumnDefinitionId { get; set; }
    public string ColumnLabel { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
}
