namespace InvoiceApp.Common.Dtos.Branches;

public class BranchOptionResponse
{
    public int BranchId { get; set; }
    public string Name { get; set; } = string.Empty;
    public bool IsHeadquarters { get; set; }
}
