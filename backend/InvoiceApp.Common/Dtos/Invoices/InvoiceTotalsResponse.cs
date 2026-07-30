namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceTotalsResponse
{
    public decimal SubtotalSum { get; set; }
    public decimal VatTotalSum { get; set; }
    public decimal GrandTotalSum { get; set; }
}
