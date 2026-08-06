using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InvoiceApp.Repository.Migrations
{
    /// <inheritdoc />
    public partial class RenameInvoiceSettingsToInvoiceCustomization : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 21,
                column: "Resource",
                value: "InvoiceCustomization");

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 22,
                column: "Resource",
                value: "InvoiceCustomization");

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 23,
                column: "Resource",
                value: "InvoiceCustomization");

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 24,
                column: "Resource",
                value: "InvoiceCustomization");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 21,
                column: "Resource",
                value: "InvoiceSettings");

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 22,
                column: "Resource",
                value: "InvoiceSettings");

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 23,
                column: "Resource",
                value: "InvoiceSettings");

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 24,
                column: "Resource",
                value: "InvoiceSettings");
        }
    }
}
