using InvoiceApp.Common.Dtos.Branches;
using InvoiceApp.Common.Dtos.InvoiceSeries;
using InvoiceApp.Common.Dtos.VatRates;

namespace InvoiceApp.Common.Dtos.Permissions;

public class MyPermissionsResponse
{
    public int? ProfileId { get; set; }
    public string? ProfileName { get; set; }
    public bool IsSystemProfile { get; set; }
    public List<string> Permissions { get; set; } = new();
    public List<VatRateResponse> VatRates { get; set; } = new();
    public decimal? MinInvoiceAmount { get; set; }
    public decimal? MaxInvoiceAmount { get; set; }
    public bool CanAccessAllBranches { get; set; }
    public int? BranchId { get; set; }
    public List<InvoiceSeriesOptionResponse> AvailableInvoiceSeries { get; set; } = new();
    public List<BranchOptionResponse> AvailableBranches { get; set; } = new();
}
