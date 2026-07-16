using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class InvoiceConfiguration : IEntityTypeConfiguration<Invoice>
{
    public void Configure(EntityTypeBuilder<Invoice> builder)
    {
        builder.HasKey(i => i.InvoiceId);

        builder.Property(i => i.InvoiceNumber).IsRequired().HasMaxLength(50);

        // decimal için hassasiyet açıkça belirtilmezse EF Core uyarı verir / SQL Server
        // varsayılan olarak decimal(18,2) kullanmaz, bu yüzden elle set ediyoruz.
        builder.Property(i => i.TotalAmount).HasColumnType("decimal(18,2)");

        builder.HasOne(i => i.Customer)
            .WithMany(c => c.Invoices)
            .HasForeignKey(i => i.CustomerId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(i => i.User)
            .WithMany(u => u.Invoices)
            .HasForeignKey(i => i.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        // Soft delete: IsDeleted = true olan faturalar normal sorgularda otomatik gizlenir.
        // Gerekirse .IgnoreQueryFilters() ile bu filtre bilinçli olarak devre dışı bırakılabilir.
        builder.HasQueryFilter(i => !i.IsDeleted);

        builder.HasIndex(i => i.UserId);
        builder.HasIndex(i => i.InvoiceDate);
    }
}