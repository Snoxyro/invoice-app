using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class ProfilePermissionConfiguration : IEntityTypeConfiguration<ProfilePermission>
{
    public void Configure(EntityTypeBuilder<ProfilePermission> builder)
    {
        builder.HasKey(pp => pp.ProfilePermissionId);

        builder.HasIndex(pp => new { pp.ProfileId, pp.PermissionId }).IsUnique();

        builder.HasOne(pp => pp.Profile)
            .WithMany(p => p.ProfilePermissions)
            .HasForeignKey(pp => pp.ProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(pp => pp.Permission)
            .WithMany(p => p.ProfilePermissions)
            .HasForeignKey(pp => pp.PermissionId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}