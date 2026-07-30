using InvoiceApp.Common.Dtos.Invoices;

namespace InvoiceApp.Service.Invoices;

public interface IInvoiceService
{
    Task<InvoiceResponse> CreateAsync(int currentUserId, InvoiceCreateRequest request);
    Task<InvoiceResponse> UpdateAsync(int currentUserId, int invoiceId, InvoiceUpdateRequest request);
    Task<InvoiceResponse> SendAsync(int currentUserId, int invoiceId);
    Task DeleteAsync(int currentUserId, int invoiceId);
    Task<InvoiceResponse> GetByIdAsync(int currentUserId, int invoiceId);
    Task<string> GetPreviewHtmlAsync(int currentUserId, int invoiceId);
    Task<InvoiceListResponse> GetPagedAsync(int currentUserId, InvoiceListRequest request);
}
