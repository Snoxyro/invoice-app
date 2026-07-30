using InvoiceApp.Common.Paging;

namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceListResponse : PagedResult<InvoiceListItemResponse>
{
    public InvoiceTotalsResponse Totals { get; set; } = new();
}
