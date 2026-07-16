using InvoiceApp.Common.Entities;

namespace InvoiceApp.Common.Dtos.Users;

public class UserUpdateRequest
{
    public string UserName { get; set; } = string.Empty;
    public UserRole Role { get; set; }
    public string? NewPassword { get; set; }
}