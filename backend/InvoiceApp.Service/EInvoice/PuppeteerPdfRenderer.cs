using PuppeteerSharp;
using PuppeteerSharp.Media;

namespace InvoiceApp.Service.EInvoice;

public class PuppeteerPdfRenderer : IPdfRenderer
{
    private static readonly string[] ChromiumCandidatePaths =
    {
        "/usr/bin/google-chrome-stable",
        "/usr/bin/google-chrome",
        "/usr/bin/chromium",
        "/usr/bin/chromium-browser"
    };

    public async Task<byte[]> RenderAsync(string html)
    {
        var executablePath = ResolveChromiumExecutablePath();

        var launchOptions = new LaunchOptions
        {
            Headless = true,
            ExecutablePath = executablePath,
            Args = new[] { "--no-sandbox", "--disable-setuid-sandbox", "--disable-dev-shm-usage" }
        };

        var browser = await Puppeteer.LaunchAsync(launchOptions);

        try
        {
            var page = await browser.NewPageAsync();

            try
            {
                await page.SetContentAsync(html);
                await Task.Delay(500);

                var pdfOptions = new PdfOptions
                {
                    Format = PaperFormat.A4,
                    PrintBackground = true,
                    Scale = 0.973m
                };

                return await page.PdfDataAsync(pdfOptions);
            }
            finally
            {
                await page.CloseAsync();
            }
        }
        finally
        {
            await browser.CloseAsync();
        }
    }

    private static string ResolveChromiumExecutablePath()
    {
        foreach (var path in ChromiumCandidatePaths)
        {
            if (File.Exists(path))
            {
                return path;
            }
        }

        throw new InvalidOperationException(
            $"Chromium bulunamadı ({string.Join(", ", ChromiumCandidatePaths)}). Docker image'ının 'chromium' paketiyle build edildiğinden emin ol.");
    }
}