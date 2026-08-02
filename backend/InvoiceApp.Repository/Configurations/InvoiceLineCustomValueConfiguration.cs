using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class InvoiceLineCustomValueConfiguration : IEntityTypeConfiguration<InvoiceLineCustomValue>
{
    public void Configure(EntityTypeBuilder<InvoiceLineCustomValue> builder)
    {
        builder.HasKey(v => v.InvoiceLineCustomValueId);

        builder.Property(v => v.Label).IsRequired().HasMaxLength(100);
        builder.Property(v => v.Value).IsRequired().HasMaxLength(500);

        builder.HasOne(v => v.InvoiceLine)
            .WithMany(l => l.CustomValues)
            .HasForeignKey(v => v.InvoiceLineId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasIndex(v => v.InvoiceLineId);
    }
}
