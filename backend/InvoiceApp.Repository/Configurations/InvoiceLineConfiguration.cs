using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class InvoiceLineConfiguration : IEntityTypeConfiguration<InvoiceLine>
{
    public void Configure(EntityTypeBuilder<InvoiceLine> builder)
    {
        builder.HasKey(il => il.InvoiceLineId);

        builder.Property(il => il.ItemName).IsRequired().HasMaxLength(200);
        builder.Property(il => il.Quantity).HasColumnType("decimal(18,2)");
        builder.Property(il => il.Price).HasColumnType("decimal(18,2)");

        builder.HasOne(il => il.Invoice)
            .WithMany(i => i.InvoiceLines)
            .HasForeignKey(il => il.InvoiceId)
            // Cascade: bir Invoice (hard delete senaryosunda) silinirse kalemlerinin de
            // silinmesi mantıklı, çünkü kalemler faturasız bir anlam taşımıyor.
            .OnDelete(DeleteBehavior.Cascade);
    }
}