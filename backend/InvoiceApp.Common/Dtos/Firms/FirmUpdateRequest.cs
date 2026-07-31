namespace InvoiceApp.Common.Dtos.Firms;

public class FirmUpdateRequest
{
    public string Name { get; set; } = string.Empty;
    public string? Vkn { get; set; }
}
