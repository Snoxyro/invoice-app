using InvoiceApp.Common.Dtos.Branches;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Service.Branches;

public interface IBranchService
{
    Task<BranchResponse> CreateAsync(int currentUserId, BranchCreateRequest request);
    Task<BranchResponse> UpdateAsync(int currentUserId, int branchId, BranchUpdateRequest request);
    Task DeleteAsync(int currentUserId, int branchId);
    Task<BranchResponse> GetByIdAsync(int currentUserId, int branchId);
    Task<PagedResult<BranchResponse>> GetPagedAsync(int currentUserId, PagedRequest request);
}
