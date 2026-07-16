namespace InvoiceApp.Common.Dtos.Customers;

public class CustomerCreateRequest
{
    public string TaxNumber { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
}