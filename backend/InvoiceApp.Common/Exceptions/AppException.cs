namespace InvoiceApp.Common.Exceptions;

public abstract class AppException : Exception
{
    public string ErrorCode { get; }
    public IReadOnlyDictionary<string, string> Params { get; }

    protected AppException(string errorCode, IReadOnlyDictionary<string, string>? parameters = null)
        : base(errorCode)
    {
        ErrorCode = errorCode;
        Params = parameters ?? new Dictionary<string, string>();
    }
}