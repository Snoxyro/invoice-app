using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class InvoiceSeriesConfiguration : IEntityTypeConfiguration<InvoiceSeries>
{
    public void Configure(EntityTypeBuilder<InvoiceSeries> builder)
    {
        builder.HasKey(s => s.InvoiceSeriesId);

        builder.Property(s => s.Prefix).IsRequired().HasMaxLength(3);

        builder.HasOne(s => s.Branch)
            .WithMany(b => b.InvoiceSeries)
            .HasForeignKey(s => s.BranchId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasIndex(s => s.BranchId);
        builder.HasIndex(s => new { s.BranchId, s.Prefix }).IsUnique();
    }
}
