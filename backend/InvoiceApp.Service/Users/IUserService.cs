using InvoiceApp.Common.Dtos.Users;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Service.Users;

public interface IUserService
{
    Task<UserResponse> CreateAsync(int currentUserId, UserCreateRequest request);
    Task<UserResponse> UpdateAsync(int currentUserId, int userId, UserUpdateRequest request);
    Task DeleteAsync(int currentUserId, int userId);
    Task<UserResponse> GetByIdAsync(int currentUserId, int userId);
    Task<PagedResult<UserResponse>> GetPagedAsync(int currentUserId, PagedRequest request);
}
