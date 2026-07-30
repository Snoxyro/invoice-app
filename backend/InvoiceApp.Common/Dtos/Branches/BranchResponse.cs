namespace InvoiceApp.Common.Dtos.Branches;

public class BranchResponse
{
    public int BranchId { get; set; }
    public string Name { get; set; } = string.Empty;
    public bool IsHeadquarters { get; set; }
    public string? Address { get; set; }
    public string? City { get; set; }
    public string? TaxOffice { get; set; }
    public string? Phone { get; set; }
    public string? Fax { get; set; }
    public string? Email { get; set; }
    public string? Website { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}
