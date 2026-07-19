namespace InvoiceApp.Common.Entities;

public class Firm : BaseEntity
{
    public int FirmId { get; set; }
    public string Name { get; set; } = string.Empty;
    public ICollection<User> Users { get; set; } = new List<User>();
    public ICollection<Profile> Profiles { get; set; } = new List<Profile>();
    public ICollection<Customer> Customers { get; set; } = new List<Customer>();
    public ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();
}