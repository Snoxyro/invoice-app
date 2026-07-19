using InvoiceApp.Common.Entities;

namespace InvoiceApp.Common.Dtos.Users;

public class UserResponse
{
    public int UserId { get; set; }
    public string UserName { get; set; } = string.Empty;
    public UserRole Role { get; set; }
    public int? ProfileId { get; set; }
    public string? ProfileName { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}
