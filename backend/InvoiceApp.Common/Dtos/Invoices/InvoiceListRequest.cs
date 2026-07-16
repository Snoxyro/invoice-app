using InvoiceApp.Common.Paging;

namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceListRequest : PagedRequest
{
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
}