using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class InvoiceConfiguration : IEntityTypeConfiguration<Invoice>
{
    public void Configure(EntityTypeBuilder<Invoice> builder)
    {
        builder.HasKey(i => i.InvoiceId);

        builder.Property(i => i.InvoiceNumber).HasMaxLength(50);
        builder.Property(i => i.Subtotal).HasColumnType("decimal(18,2)");
        builder.Property(i => i.VatTotal).HasColumnType("decimal(18,2)");
        builder.Property(i => i.GrandTotal).HasColumnType("decimal(18,2)");

        builder.Property(i => i.Status)
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.Property(i => i.GibStatusCode).HasMaxLength(10);
        builder.Property(i => i.GibStatusMessage).HasMaxLength(200);

        builder.HasOne(i => i.Customer)
            .WithMany(c => c.Invoices)
            .HasForeignKey(i => i.CustomerId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(i => i.Firm)
            .WithMany(f => f.Invoices)
            .HasForeignKey(i => i.FirmId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(i => i.Branch)
            .WithMany(b => b.Invoices)
            .HasForeignKey(i => i.BranchId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(i => i.InvoiceSeries)
            .WithMany()
            .HasForeignKey(i => i.InvoiceSeriesId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(i => i.CreatedByUser)
            .WithMany(u => u.CreatedInvoices)
            .HasForeignKey(i => i.CreatedByUserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasQueryFilter(i => !i.IsDeleted);

        builder.HasIndex(i => i.FirmId);
        builder.HasIndex(i => i.BranchId);
        builder.HasIndex(i => i.InvoiceDate);
        builder.HasIndex(i => i.InvoiceSeriesId);
    }
}
