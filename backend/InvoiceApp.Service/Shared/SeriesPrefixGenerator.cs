namespace InvoiceApp.Service.Shared;

public static class SeriesPrefixGenerator
{
    public static string Derive(string branchName)
    {
        var normalized = branchName
            .Replace('Ç', 'C').Replace('ç', 'c')
            .Replace('Ğ', 'G').Replace('ğ', 'g')
            .Replace('İ', 'I').Replace('ı', 'i')
            .Replace('Ö', 'O').Replace('ö', 'o')
            .Replace('Ş', 'S').Replace('ş', 's')
            .Replace('Ü', 'U').Replace('ü', 'u');

        var alphanumeric = new string(normalized.Where(char.IsLetterOrDigit).ToArray()).ToUpperInvariant();

        return alphanumeric.Length >= 3 ? alphanumeric[..3] : alphanumeric.PadRight(3, '0');
    }

    public static bool IsValidFormat(string prefix)
    {
        return prefix.Length == 3 && prefix.All(char.IsAsciiLetterOrDigit);
    }
}
