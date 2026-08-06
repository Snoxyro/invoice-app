using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InvoiceApp.Repository.Migrations
{
    /// <inheritdoc />
    public partial class AddInvoiceTypePermissions : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "CanCreateReturnInvoices",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: true);

            migrationBuilder.AddColumn<bool>(
                name: "CanCreateSalesInvoices",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CanCreateReturnInvoices",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanCreateSalesInvoices",
                table: "Profiles");
        }
    }
}
