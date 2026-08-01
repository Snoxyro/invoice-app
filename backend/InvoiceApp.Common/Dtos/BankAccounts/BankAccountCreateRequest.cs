namespace InvoiceApp.Common.Dtos.BankAccounts;

public class BankAccountCreateRequest
{
    public string BankName { get; set; } = string.Empty;
    public string Currency { get; set; } = string.Empty;
    public string Iban { get; set; } = string.Empty;
}
