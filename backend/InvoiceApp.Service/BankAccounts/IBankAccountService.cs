using InvoiceApp.Common.Dtos.BankAccounts;

namespace InvoiceApp.Service.BankAccounts;

public interface IBankAccountService
{
    Task<List<BankAccountResponse>> GetAllAsync(int currentUserId);
    Task<BankAccountResponse> CreateAsync(int currentUserId, BankAccountCreateRequest request);
    Task<BankAccountResponse> UpdateAsync(int currentUserId, int bankAccountId, BankAccountUpdateRequest request);
    Task DeleteAsync(int currentUserId, int bankAccountId);
}
