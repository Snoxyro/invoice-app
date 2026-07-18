namespace InvoiceApp.Common.Exceptions;

public class BusinessRuleException : AppException
{
    public BusinessRuleException(string errorCode, IReadOnlyDictionary<string, string>? parameters = null)
        : base(errorCode, parameters)
    {
    }
}