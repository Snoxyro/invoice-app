namespace InvoiceApp.Common.Dtos.Users;

public class UserUpdateRequest
{
    public string UserName { get; set; } = string.Empty;
    public int ProfileId { get; set; }
    public string? NewPassword { get; set; }
    public int? BranchId { get; set; }
}
