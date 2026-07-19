namespace InvoiceApp.Common.Entities;

public class Permission : BaseEntity
{
    public int PermissionId { get; set; }
    public PermissionResource Resource { get; set; }
    public PermissionAction Action { get; set; }
    public ICollection<ProfilePermission> ProfilePermissions { get; set; } = new List<ProfilePermission>();
}