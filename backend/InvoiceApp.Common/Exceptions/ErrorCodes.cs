namespace InvoiceApp.Common.Exceptions;

public static class ErrorCodes
{
    public const string InvalidCredentials = "INVALID_CREDENTIALS";
    public const string UsernameAlreadyExists = "USERNAME_ALREADY_EXISTS";
    public const string UserNotFound = "USER_NOT_FOUND";
    public const string CannotDeleteOwnAccount = "CANNOT_DELETE_OWN_ACCOUNT";
    public const string CannotEditOwnAccount = "CANNOT_EDIT_OWN_ACCOUNT";
    public const string FirmHasRecordsCannotDelete = "FIRM_HAS_RECORDS_CANNOT_DELETE";
    public const string UserHasNoFirm = "USER_HAS_NO_FIRM";
    public const string CustomerNotFound = "CUSTOMER_NOT_FOUND";
    public const string InvalidTaxNumberFormat = "INVALID_TAX_NUMBER_FORMAT";
    public const string CustomerTaxNumberAlreadyExists = "CUSTOMER_TAX_NUMBER_ALREADY_EXISTS";
    public const string CustomerHasInvoicesCannotDelete = "CUSTOMER_HAS_INVOICES_CANNOT_DELETE";
    public const string InvoiceNotFound = "INVOICE_NOT_FOUND";
    public const string InvoiceNumberAlreadyExists = "INVOICE_NUMBER_ALREADY_EXISTS";
    public const string InvoiceRequiresAtLeastOneLine = "INVOICE_REQUIRES_AT_LEAST_ONE_LINE";
    public const string InvoiceAmountBelowMinimum = "INVOICE_AMOUNT_BELOW_MINIMUM";
    public const string InvoiceAmountAboveMaximum = "INVOICE_AMOUNT_ABOVE_MAXIMUM";
    public const string FirmNotFound = "FIRM_NOT_FOUND";
    public const string FirmNameAlreadyExists = "FIRM_NAME_ALREADY_EXISTS";
    public const string ProfileNotFound = "PROFILE_NOT_FOUND";
    public const string ProfileNameAlreadyExists = "PROFILE_NAME_ALREADY_EXISTS";
    public const string ProfileIsSystemCannotModify = "PROFILE_IS_SYSTEM_CANNOT_MODIFY";
    public const string ProfileHasUsersCannotDelete = "PROFILE_HAS_USERS_CANNOT_DELETE";
    public const string ProfileStrongerThanCaller = "PROFILE_STRONGER_THAN_CALLER";
    public const string CannotManageStrongerUser = "CANNOT_MANAGE_STRONGER_USER";
    public const string CannotGrantBeyondOwnPermissions = "CANNOT_GRANT_BEYOND_OWN_PERMISSIONS";
    public const string InvalidPermissionSelection = "INVALID_PERMISSION_SELECTION";
    public const string InvalidVatRateSelection = "INVALID_VAT_RATE_SELECTION";
    public const string ReadPermissionRequiredForMutation = "READ_PERMISSION_REQUIRED_FOR_MUTATION";
    public const string InvoiceRangeInvalid = "INVOICE_RANGE_INVALID";
    public const string LastFullPermissionUserCannotBeRemoved = "LAST_FULL_PERMISSION_USER_CANNOT_BE_REMOVED";
    public const string UnexpectedError = "UNEXPECTED_ERROR";
}
