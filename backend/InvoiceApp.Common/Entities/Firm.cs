namespace InvoiceApp.Common.Entities;

public class Firm : BaseEntity
{
    public int FirmId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Vkn { get; set; }
    public string? LogoBase64 { get; set; }
    public string? StampBase64 { get; set; }
    public string? AccentColorHex { get; set; }
    public string? FontFamily { get; set; }
    public int? LogoWidthPx { get; set; }
    public int? LogoHeightPx { get; set; }
    public int? StampWidthPx { get; set; }
    public int? StampHeightPx { get; set; }
    public ICollection<User> Users { get; set; } = new List<User>();
    public ICollection<Profile> Profiles { get; set; } = new List<Profile>();
    public ICollection<Customer> Customers { get; set; } = new List<Customer>();
    public ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();
    public ICollection<Branch> Branches { get; set; } = new List<Branch>();
    public ICollection<BankAccount> BankAccounts { get; set; } = new List<BankAccount>();
    public ICollection<InvoiceLineCustomColumnDefinition> CustomColumnDefinitions { get; set; } = new List<InvoiceLineCustomColumnDefinition>();
}
