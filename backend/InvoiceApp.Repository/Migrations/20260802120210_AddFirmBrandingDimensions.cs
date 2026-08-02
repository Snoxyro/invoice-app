using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InvoiceApp.Repository.Migrations
{
    /// <inheritdoc />
    public partial class AddFirmBrandingDimensions : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "LogoHeightPx",
                table: "Firms",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "LogoWidthPx",
                table: "Firms",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "StampHeightPx",
                table: "Firms",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "StampWidthPx",
                table: "Firms",
                type: "int",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "LogoHeightPx",
                table: "Firms");

            migrationBuilder.DropColumn(
                name: "LogoWidthPx",
                table: "Firms");

            migrationBuilder.DropColumn(
                name: "StampHeightPx",
                table: "Firms");

            migrationBuilder.DropColumn(
                name: "StampWidthPx",
                table: "Firms");
        }
    }
}
