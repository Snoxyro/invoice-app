namespace InvoiceApp.Service.Permissions;

public class UserPermissionContext : PermissionDefinition
{
    public int UserId { get; set; }
    public int? FirmId { get; set; }
    public int? ProfileId { get; set; }
    public bool IsSystemProfile { get; set; }
}
