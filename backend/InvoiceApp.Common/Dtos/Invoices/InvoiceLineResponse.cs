namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceLineResponse
{
    public int InvoiceLineId { get; set; }
    public string ItemName { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public decimal Price { get; set; }
    public decimal LineTotal => Quantity * Price;
}