using InvoiceApp.Common.Entities;

namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceListItemResponse
{
    public int InvoiceId { get; set; }
    public string? InvoiceNumber { get; set; }
    public DateTime InvoiceDate { get; set; }
    public decimal Subtotal { get; set; }
    public decimal VatTotal { get; set; }
    public decimal GrandTotal { get; set; }
    public int CustomerId { get; set; }
    public string CustomerTitle { get; set; } = string.Empty;
    public int? BranchId { get; set; }
    public string? BranchName { get; set; }
    public InvoiceStatus Status { get; set; }
    public InvoiceTypeCode InvoiceTypeCode { get; set; }
    public string? ReturnInvoiceNumber { get; set; }
    public string? OriginalInvoiceNumber { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}
