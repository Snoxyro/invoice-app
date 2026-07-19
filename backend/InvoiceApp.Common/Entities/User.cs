namespace InvoiceApp.Common.Entities;

public class User : BaseEntity
{
    public int UserId { get; set; }
    public string UserName { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public UserRole Role { get; set; }
    public int? FirmId { get; set; }
    public Firm? Firm { get; set; }
    public int? ProfileId { get; set; }
    public Profile? Profile { get; set; }
    public ICollection<Invoice> CreatedInvoices { get; set; } = new List<Invoice>();
}