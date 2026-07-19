using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class FirmConfiguration : IEntityTypeConfiguration<Firm>
{
    public void Configure(EntityTypeBuilder<Firm> builder)
    {
        builder.HasKey(f => f.FirmId);

        builder.Property(f => f.Name)
            .IsRequired()
            .HasMaxLength(200);
    }
}