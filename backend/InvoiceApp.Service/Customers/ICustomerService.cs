using InvoiceApp.Common.Dtos.Customers;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Service.Customers;

public interface ICustomerService
{
    Task<CustomerResponse> CreateAsync(int currentUserId, CustomerCreateRequest request);
    Task<CustomerResponse> UpdateAsync(int currentUserId, int customerId, CustomerUpdateRequest request);
    Task DeleteAsync(int currentUserId, int customerId);
    Task<CustomerResponse> GetByIdAsync(int currentUserId, int customerId);
    Task<PagedResult<CustomerResponse>> GetPagedAsync(int currentUserId, PagedRequest request);
}