namespace InvoiceApp.Common.Dtos.Firms;

public class FirmBrandingResponse
{
    public string? LogoBase64 { get; set; }
    public string? StampBase64 { get; set; }
    public string? AccentColorHex { get; set; }
    public string? FontFamily { get; set; }
    public int? LogoWidthPx { get; set; }
    public int? LogoHeightPx { get; set; }
    public int? StampWidthPx { get; set; }
    public int? StampHeightPx { get; set; }
}
