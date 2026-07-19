using InvoiceApp.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace InvoiceApp.Repository.Configurations;

public class PermissionConfiguration : IEntityTypeConfiguration<Permission>
{
    private static readonly DateTime SeedDate = new(2026, 1, 1, 0, 0, 0, DateTimeKind.Utc);

    public void Configure(EntityTypeBuilder<Permission> builder)
    {
        builder.HasKey(p => p.PermissionId);

        builder.Property(p => p.Resource)
            .HasConversion<string>()
            .HasMaxLength(30);

        builder.Property(p => p.Action)
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.HasIndex(p => new { p.Resource, p.Action }).IsUnique();

        builder.HasData(
            new Permission { PermissionId = 1, Resource = PermissionResource.Users, Action = PermissionAction.Create, CreatedDate = SeedDate },
            new Permission { PermissionId = 2, Resource = PermissionResource.Users, Action = PermissionAction.Read, CreatedDate = SeedDate },
            new Permission { PermissionId = 3, Resource = PermissionResource.Users, Action = PermissionAction.Update, CreatedDate = SeedDate },
            new Permission { PermissionId = 4, Resource = PermissionResource.Users, Action = PermissionAction.Delete, CreatedDate = SeedDate },
            new Permission { PermissionId = 5, Resource = PermissionResource.Profiles, Action = PermissionAction.Create, CreatedDate = SeedDate },
            new Permission { PermissionId = 6, Resource = PermissionResource.Profiles, Action = PermissionAction.Read, CreatedDate = SeedDate },
            new Permission { PermissionId = 7, Resource = PermissionResource.Profiles, Action = PermissionAction.Update, CreatedDate = SeedDate },
            new Permission { PermissionId = 8, Resource = PermissionResource.Profiles, Action = PermissionAction.Delete, CreatedDate = SeedDate },
            new Permission { PermissionId = 9, Resource = PermissionResource.Customers, Action = PermissionAction.Create, CreatedDate = SeedDate },
            new Permission { PermissionId = 10, Resource = PermissionResource.Customers, Action = PermissionAction.Read, CreatedDate = SeedDate },
            new Permission { PermissionId = 11, Resource = PermissionResource.Customers, Action = PermissionAction.Update, CreatedDate = SeedDate },
            new Permission { PermissionId = 12, Resource = PermissionResource.Customers, Action = PermissionAction.Delete, CreatedDate = SeedDate },
            new Permission { PermissionId = 13, Resource = PermissionResource.Invoices, Action = PermissionAction.Create, CreatedDate = SeedDate },
            new Permission { PermissionId = 14, Resource = PermissionResource.Invoices, Action = PermissionAction.Read, CreatedDate = SeedDate },
            new Permission { PermissionId = 15, Resource = PermissionResource.Invoices, Action = PermissionAction.Update, CreatedDate = SeedDate },
            new Permission { PermissionId = 16, Resource = PermissionResource.Invoices, Action = PermissionAction.Delete, CreatedDate = SeedDate }
        );
    }
}