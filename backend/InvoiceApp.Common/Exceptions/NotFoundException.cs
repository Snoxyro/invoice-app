namespace InvoiceApp.Common.Exceptions;

public class NotFoundException : AppException
{
    public NotFoundException(string errorCode, IReadOnlyDictionary<string, string>? parameters = null)
        : base(errorCode, parameters)
    {
    }
}