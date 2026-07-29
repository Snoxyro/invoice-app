namespace InvoiceApp.Common.Entities;

public class Firm : BaseEntity
{
    public int FirmId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Vkn { get; set; }
    public ICollection<User> Users { get; set; } = new List<User>();
    public ICollection<Profile> Profiles { get; set; } = new List<Profile>();
    public ICollection<Customer> Customers { get; set; } = new List<Customer>();
    public ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();
    public ICollection<Branch> Branches { get; set; } = new List<Branch>();
}
