using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Common.Dtos.Invoices;

public class InvoiceListRequest : PagedRequest
{
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public InvoiceStatus? Status { get; set; }
    public InvoiceTypeCode? InvoiceTypeCode { get; set; }
}
