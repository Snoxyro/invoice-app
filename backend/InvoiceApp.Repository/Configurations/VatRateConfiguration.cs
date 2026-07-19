using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class VatRateConfiguration : IEntityTypeConfiguration<VatRate>
{
    private static readonly DateTime SeedDate = new(2026, 1, 1, 0, 0, 0, DateTimeKind.Utc);

    public void Configure(EntityTypeBuilder<VatRate> builder)
    {
        builder.HasKey(v => v.VatRateId);

        builder.Property(v => v.Rate)
            .HasColumnType("decimal(5,2)");

        builder.HasIndex(v => v.Rate).IsUnique();

        builder.HasData(
            new VatRate { VatRateId = 1, Rate = 1m, CreatedDate = SeedDate },
            new VatRate { VatRateId = 2, Rate = 10m, CreatedDate = SeedDate },
            new VatRate { VatRateId = 3, Rate = 20m, CreatedDate = SeedDate }
        );
    }
}