using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class ProfileConfiguration : IEntityTypeConfiguration<Profile>
{
    public void Configure(EntityTypeBuilder<Profile> builder)
    {
        builder.HasKey(p => p.ProfileId);

        builder.Property(p => p.Name)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(p => p.MinInvoiceAmount)
            .HasColumnType("decimal(18,2)");

        builder.Property(p => p.MaxInvoiceAmount)
            .HasColumnType("decimal(18,2)");

        builder.HasOne(p => p.Firm)
            .WithMany(f => f.Profiles)
            .HasForeignKey(p => p.FirmId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(p => p.FirmId);
        builder.HasIndex(p => new { p.FirmId, p.Name }).IsUnique();
    }
}