namespace InvoiceApp.Common.Entities;

public class BankAccount : BaseEntity
{
    public int BankAccountId { get; set; }
    public int FirmId { get; set; }
    public Firm Firm { get; set; } = null!;
    public string BankName { get; set; } = string.Empty;
    public string Currency { get; set; } = string.Empty;
    public string Iban { get; set; } = string.Empty;
}
