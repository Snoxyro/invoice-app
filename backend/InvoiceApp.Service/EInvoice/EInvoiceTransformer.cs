using System.Diagnostics;

namespace InvoiceApp.Service.EInvoice;

public class EInvoiceTransformer : IEInvoiceTransformer
{
    private readonly string _scriptPath;
    private readonly string _stylesheetPath;

    public EInvoiceTransformer()
    {
        _scriptPath = Path.Combine(AppContext.BaseDirectory, "EInvoice", "transform.py");
        _stylesheetPath = Path.Combine(AppContext.BaseDirectory, "EInvoice", "gib-e-fatura.xslt");
    }

    public string TransformToHtml(byte[] xmlBytes)
    {
        if (!File.Exists(_scriptPath))
        {
            throw new InvalidOperationException($"e-Fatura dönüştürme betiği bulunamadı: {_scriptPath}");
        }

        if (!File.Exists(_stylesheetPath))
        {
            throw new InvalidOperationException($"e-Fatura XSLT şablonu bulunamadı: {_stylesheetPath}");
        }

        var tempXmlPath = Path.GetTempFileName();
        File.WriteAllBytes(tempXmlPath, xmlBytes);

        var startInfo = new ProcessStartInfo
        {
            FileName = "python3",
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            UseShellExecute = false
        };

        startInfo.ArgumentList.Add(_scriptPath);
        startInfo.ArgumentList.Add(_stylesheetPath);
        startInfo.ArgumentList.Add(tempXmlPath);

        using var process = Process.Start(startInfo)
            ?? throw new InvalidOperationException("e-Fatura dönüştürme süreci başlatılamadı.");

        var output = process.StandardOutput.ReadToEnd();
        var error = process.StandardError.ReadToEnd();

        process.WaitForExit();

        if (process.ExitCode != 0)
        {
            throw new InvalidOperationException(
                $"e-Fatura dönüştürme başarısız oldu (geçici dosya: {tempXmlPath}): {error}");
        }

        File.Delete(tempXmlPath);

        return output;
    }
}
