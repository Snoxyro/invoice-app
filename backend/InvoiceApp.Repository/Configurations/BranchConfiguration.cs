using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class BranchConfiguration : IEntityTypeConfiguration<Branch>
{
    public void Configure(EntityTypeBuilder<Branch> builder)
    {
        builder.HasKey(b => b.BranchId);

        builder.Property(b => b.Name).IsRequired().HasMaxLength(200);
        builder.Property(b => b.Address).HasMaxLength(500);
        builder.Property(b => b.City).HasMaxLength(100);
        builder.Property(b => b.TaxOffice).HasMaxLength(100);
        builder.Property(b => b.Phone).HasMaxLength(20);
        builder.Property(b => b.Fax).HasMaxLength(20);
        builder.Property(b => b.Email).HasMaxLength(200);
        builder.Property(b => b.Website).HasMaxLength(200);

        builder.HasOne(b => b.Firm)
            .WithMany(f => f.Branches)
            .HasForeignKey(b => b.FirmId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(b => b.FirmId);
        builder.HasIndex(b => new { b.FirmId, b.Name }).IsUnique();
    }
}
