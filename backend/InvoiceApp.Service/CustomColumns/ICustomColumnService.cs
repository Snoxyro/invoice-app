using InvoiceApp.Common.Dtos.CustomColumns;

namespace InvoiceApp.Service.CustomColumns;

public interface ICustomColumnService
{
    Task<List<CustomColumnResponse>> GetAllAsync(int currentUserId);
    Task<CustomColumnResponse> CreateAsync(int currentUserId, CustomColumnCreateRequest request);
    Task<CustomColumnResponse> UpdateAsync(int currentUserId, int id, CustomColumnUpdateRequest request);
    Task DeleteAsync(int currentUserId, int id);
}
