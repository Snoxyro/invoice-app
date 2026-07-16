namespace InvoiceApp.Common.Dtos.Customers;

public class CustomerResponse
{
    public int CustomerId { get; set; }
    public string TaxNumber { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public DateTime CreatedDate { get; set; }
    public DateTime? UpdatedDate { get; set; }
}