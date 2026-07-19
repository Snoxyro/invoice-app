using InvoiceApp.Common.Dtos.Firms;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Service.Firms;

public interface IFirmService
{
    Task<FirmResponse> CreateAsync(FirmCreateRequest request);
    Task<FirmResponse> UpdateAsync(int firmId, FirmUpdateRequest request);
    Task DeleteAsync(int firmId);
    Task<FirmResponse> GetByIdAsync(int firmId);
    Task<PagedResult<FirmResponse>> GetPagedAsync(PagedRequest request);
}
