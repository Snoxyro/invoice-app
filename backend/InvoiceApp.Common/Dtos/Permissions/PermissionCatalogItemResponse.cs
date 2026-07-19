using InvoiceApp.Common.Entities;

namespace InvoiceApp.Common.Dtos.Permissions;

public class PermissionCatalogItemResponse
{
    public int PermissionId { get; set; }
    public PermissionResource Resource { get; set; }
    public PermissionAction Action { get; set; }
}
