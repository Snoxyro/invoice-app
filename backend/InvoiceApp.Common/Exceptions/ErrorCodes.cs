namespace InvoiceApp.Common.Exceptions;

public static class ErrorCodes
{
    public const string InvalidCredentials = "INVALID_CREDENTIALS";
    public const string UsernameAlreadyExists = "USERNAME_ALREADY_EXISTS";
    public const string UserNotFound = "USER_NOT_FOUND";
    public const string FirmHasRecordsCannotDelete = "FIRM_HAS_RECORDS_CANNOT_DELETE";
    public const string CustomerNotFound = "CUSTOMER_NOT_FOUND";
    public const string CustomerHasInvoicesCannotDelete = "CUSTOMER_HAS_INVOICES_CANNOT_DELETE";
    public const string InvoiceNotFound = "INVOICE_NOT_FOUND";
    public const string InvoiceRequiresAtLeastOneLine = "INVOICE_REQUIRES_AT_LEAST_ONE_LINE";
    public const string UnexpectedError = "UNEXPECTED_ERROR";
}