using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class BankAccountConfiguration : IEntityTypeConfiguration<BankAccount>
{
    public void Configure(EntityTypeBuilder<BankAccount> builder)
    {
        builder.HasKey(b => b.BankAccountId);

        builder.Property(b => b.BankName).IsRequired().HasMaxLength(200);
        builder.Property(b => b.Currency).IsRequired().HasMaxLength(3);
        builder.Property(b => b.Iban).IsRequired().HasMaxLength(34);

        builder.HasOne(b => b.Firm)
            .WithMany(f => f.BankAccounts)
            .HasForeignKey(b => b.FirmId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(b => b.FirmId);
    }
}
