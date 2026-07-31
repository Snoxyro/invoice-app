namespace InvoiceApp.Service.EInvoice;

public interface IPdfRenderer
{
    Task<byte[]> RenderAsync(string html);
}
