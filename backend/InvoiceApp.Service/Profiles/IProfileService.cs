using InvoiceApp.Common.Dtos.Permissions;
using InvoiceApp.Common.Dtos.Profiles;
using InvoiceApp.Common.Dtos.VatRates;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Service.Profiles;

public interface IProfileService
{
    Task<ProfileResponse> CreateAsync(int currentUserId, ProfileCreateRequest request);
    Task<ProfileResponse> UpdateAsync(int currentUserId, int profileId, ProfileUpdateRequest request);
    Task DeleteAsync(int currentUserId, int profileId);
    Task<ProfileResponse> GetByIdAsync(int currentUserId, int profileId);
    Task<PagedResult<ProfileResponse>> GetPagedAsync(int currentUserId, PagedRequest request);
    Task<List<PermissionCatalogItemResponse>> GetPermissionCatalogAsync();
    Task<List<VatRateResponse>> GetVatRateCatalogAsync();
}
