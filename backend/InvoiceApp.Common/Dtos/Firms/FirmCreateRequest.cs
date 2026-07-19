namespace InvoiceApp.Common.Dtos.Firms;

public class FirmCreateRequest
{
    public string FirmName { get; set; } = string.Empty;
    public string FirstUserName { get; set; } = string.Empty;
    public string FirstUserPassword { get; set; } = string.Empty;
}
