namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceLineResponse
{
    public int InvoiceLineId { get; set; }
    public string ItemName { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public decimal Price { get; set; }
    public int VatRateId { get; set; }
    public decimal VatRatePercentage { get; set; }
    public decimal Subtotal => Math.Round(Quantity * Price, 2);
    public decimal VatAmount => Math.Round(Subtotal * VatRatePercentage / 100, 2);
    public decimal LineTotal => Subtotal + VatAmount;
}
