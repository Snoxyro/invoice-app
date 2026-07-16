using InvoiceApp.Common.Dtos.Invoices;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Service.Invoices;

public interface IInvoiceService
{
    Task<InvoiceResponse> CreateAsync(int currentUserId, InvoiceCreateRequest request);
    Task<InvoiceResponse> UpdateAsync(int currentUserId, int invoiceId, InvoiceUpdateRequest request);
    Task DeleteAsync(int currentUserId, int invoiceId);
    Task<InvoiceResponse> GetByIdAsync(int currentUserId, int invoiceId);
    Task<PagedResult<InvoiceListItemResponse>> GetPagedAsync(int currentUserId, InvoiceListRequest request);
}