using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class InvoiceLineCustomColumnDefinitionConfiguration : IEntityTypeConfiguration<InvoiceLineCustomColumnDefinition>
{
    public void Configure(EntityTypeBuilder<InvoiceLineCustomColumnDefinition> builder)
    {
        builder.HasKey(c => c.InvoiceLineCustomColumnDefinitionId);

        builder.Property(c => c.Label).IsRequired().HasMaxLength(100);

        builder.HasOne(c => c.Firm)
            .WithMany(f => f.CustomColumnDefinitions)
            .HasForeignKey(c => c.FirmId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(c => c.FirmId);
    }
}
