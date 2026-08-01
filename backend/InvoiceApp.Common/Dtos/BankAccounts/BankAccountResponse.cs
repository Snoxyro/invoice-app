namespace InvoiceApp.Common.Dtos.BankAccounts;

public class BankAccountResponse
{
    public int BankAccountId { get; set; }
    public string BankName { get; set; } = string.Empty;
    public string Currency { get; set; } = string.Empty;
    public string Iban { get; set; } = string.Empty;
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}
