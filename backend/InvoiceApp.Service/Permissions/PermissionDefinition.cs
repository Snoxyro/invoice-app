using InvoiceApp.Common.Entities;

namespace InvoiceApp.Service.Permissions;

public class PermissionDefinition
{
    public HashSet<int> PermissionIds { get; set; } = new();
    public HashSet<(PermissionResource Resource, PermissionAction Action)> Permissions { get; set; } = new();
    public HashSet<int> VatRateIds { get; set; } = new();
    public decimal? MinInvoiceAmount { get; set; }
    public decimal? MaxInvoiceAmount { get; set; }

    public bool Has(PermissionResource resource, PermissionAction action) => Permissions.Contains((resource, action));

    public bool IsSubsetOf(PermissionDefinition other)
    {
        return PermissionIds.All(other.PermissionIds.Contains)
            && VatRateIds.All(other.VatRateIds.Contains)
            && IsRangeWithin(other);
    }

    private bool IsRangeWithin(PermissionDefinition other)
    {
        var minOk = other.MinInvoiceAmount is null
            || (MinInvoiceAmount is not null && MinInvoiceAmount >= other.MinInvoiceAmount);

        var maxOk = other.MaxInvoiceAmount is null
            || (MaxInvoiceAmount is not null && MaxInvoiceAmount <= other.MaxInvoiceAmount);

        return minOk && maxOk;
    }
}
