using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Repository;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users => Set<User>();
    public DbSet<Customer> Customers => Set<Customer>();
    public DbSet<Invoice> Invoices => Set<Invoice>();
    public DbSet<InvoiceLine> InvoiceLines => Set<InvoiceLine>();
    public DbSet<Firm> Firms => Set<Firm>();
    public DbSet<Profile> Profiles => Set<Profile>();
    public DbSet<Permission> Permissions => Set<Permission>();
    public DbSet<ProfilePermission> ProfilePermissions => Set<ProfilePermission>();
    public DbSet<VatRate> VatRates => Set<VatRate>();
    public DbSet<ProfileVatRate> ProfileVatRates => Set<ProfileVatRate>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
    }

    public override int SaveChanges()
    {
        ApplyAuditTimestamps();
        return base.SaveChanges();
    }

    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        ApplyAuditTimestamps();
        return base.SaveChangesAsync(cancellationToken);
    }

    private void ApplyAuditTimestamps()
    {
        var now = DateTime.UtcNow;

        foreach (var entry in ChangeTracker.Entries<BaseEntity>())
        {
            if (entry.State == EntityState.Added)
            {
                entry.Entity.CreatedDate = now;
            }
            else if (entry.State == EntityState.Modified)
            {
                entry.Entity.UpdatedDate = now;
            }
        }
    }
}