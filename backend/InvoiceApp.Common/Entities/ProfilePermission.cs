namespace InvoiceApp.Common.Entities;

public class ProfilePermission : BaseEntity
{
    public int ProfilePermissionId { get; set; }
    public int ProfileId { get; set; }
    public Profile Profile { get; set; } = null!;
    public int PermissionId { get; set; }
    public Permission Permission { get; set; } = null!;
}