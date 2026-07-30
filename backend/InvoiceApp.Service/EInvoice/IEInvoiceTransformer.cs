namespace InvoiceApp.Service.EInvoice;

public interface IEInvoiceTransformer
{
    string TransformToHtml(byte[] xmlBytes);
}
