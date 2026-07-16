using InvoiceApp.Common.Entities;

namespace InvoiceApp.Common.Dtos.Auth;

public class LoginResponse
{
    public string Token { get; set; } = string.Empty;
    public DateTime ExpiresAt { get; set; }
    public string UserName { get; set; } = string.Empty;
    public UserRole Role { get; set; }
}