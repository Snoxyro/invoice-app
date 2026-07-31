namespace InvoiceApp.Common.Dtos.Firms;

public class FirmResponse
{
    public int FirmId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Vkn { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}
