using InvoiceApp.Common.Dtos.Auth;

namespace InvoiceApp.Service.Auth;

public interface IAuthService
{
    Task<LoginResponse> LoginAsync(LoginRequest request);
}