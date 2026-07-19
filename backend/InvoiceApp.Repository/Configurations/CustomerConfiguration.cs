using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class CustomerConfiguration : IEntityTypeConfiguration<Customer>
{
    public void Configure(EntityTypeBuilder<Customer> builder)
    {
        builder.HasKey(c => c.CustomerId);

        builder.Property(c => c.Title).IsRequired().HasMaxLength(200);
        builder.Property(c => c.TaxNumber).IsRequired().HasMaxLength(20);
        builder.Property(c => c.Address).HasMaxLength(500);
        builder.Property(c => c.Email).HasMaxLength(200);

        builder.HasOne(c => c.Firm)
            .WithMany(f => f.Customers)
            .HasForeignKey(c => c.FirmId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(c => c.FirmId);
    }
}