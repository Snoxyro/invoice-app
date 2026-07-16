using InvoiceApp.Common.Dtos.Users;
using InvoiceApp.Common.Paging;

namespace InvoiceApp.Service.Users;

public interface IUserService
{
    Task<UserResponse> CreateAsync(UserCreateRequest request);
    Task<UserResponse> UpdateAsync(int userId, UserUpdateRequest request);
    Task DeleteAsync(int userId);
    Task<UserResponse> GetByIdAsync(int userId);
    Task<PagedResult<UserResponse>> GetPagedAsync(PagedRequest request);
}