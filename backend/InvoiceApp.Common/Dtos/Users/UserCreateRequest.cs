using InvoiceApp.Common.Entities;

namespace InvoiceApp.Common.Dtos.Users;

public class UserCreateRequest
{
    public string UserName { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public UserRole Role { get; set; }
}