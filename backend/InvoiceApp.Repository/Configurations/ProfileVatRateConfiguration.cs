using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class ProfileVatRateConfiguration : IEntityTypeConfiguration<ProfileVatRate>
{
    public void Configure(EntityTypeBuilder<ProfileVatRate> builder)
    {
        builder.HasKey(pv => pv.ProfileVatRateId);

        builder.HasIndex(pv => new { pv.ProfileId, pv.VatRateId }).IsUnique();

        builder.HasOne(pv => pv.Profile)
            .WithMany(p => p.ProfileVatRates)
            .HasForeignKey(pv => pv.ProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(pv => pv.VatRate)
            .WithMany(v => v.ProfileVatRates)
            .HasForeignKey(pv => pv.VatRateId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}