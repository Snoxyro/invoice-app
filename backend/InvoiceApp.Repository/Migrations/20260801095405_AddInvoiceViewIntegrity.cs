using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InvoiceApp.Repository.Migrations
{
    /// <inheritdoc />
    public partial class AddInvoiceViewIntegrity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "SentXmlContent",
                table: "Invoices",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "VatRatePercentage",
                table: "InvoiceLines",
                type: "decimal(5,2)",
                nullable: false,
                defaultValue: 0m);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "SentXmlContent",
                table: "Invoices");

            migrationBuilder.DropColumn(
                name: "VatRatePercentage",
                table: "InvoiceLines");
        }
    }
}
