using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InvoiceApp.Repository.Migrations
{
    /// <inheritdoc />
    public partial class RemoveCustomColumnCatalog : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_InvoiceLineCustomValues_InvoiceLineCustomColumnDefinitions_ColumnDefinitionId",
                table: "InvoiceLineCustomValues");

            migrationBuilder.DropTable(
                name: "InvoiceLineCustomColumnDefinitions");

            migrationBuilder.DropIndex(
                name: "IX_InvoiceLineCustomValues_ColumnDefinitionId",
                table: "InvoiceLineCustomValues");

            migrationBuilder.RenameColumn(
                name: "ColumnLabel",
                table: "InvoiceLineCustomValues",
                newName: "Label");

            migrationBuilder.RenameColumn(
                name: "ColumnDefinitionId",
                table: "InvoiceLineCustomValues",
                newName: "DisplayOrder");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Label",
                table: "InvoiceLineCustomValues",
                newName: "ColumnLabel");

            migrationBuilder.RenameColumn(
                name: "DisplayOrder",
                table: "InvoiceLineCustomValues",
                newName: "ColumnDefinitionId");

            migrationBuilder.CreateTable(
                name: "InvoiceLineCustomColumnDefinitions",
                columns: table => new
                {
                    InvoiceLineCustomColumnDefinitionId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirmId = table.Column<int>(type: "int", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DisplayOrder = table.Column<int>(type: "int", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    Label = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_InvoiceLineCustomColumnDefinitions", x => x.InvoiceLineCustomColumnDefinitionId);
                    table.ForeignKey(
                        name: "FK_InvoiceLineCustomColumnDefinitions_Firms_FirmId",
                        column: x => x.FirmId,
                        principalTable: "Firms",
                        principalColumn: "FirmId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceLineCustomValues_ColumnDefinitionId",
                table: "InvoiceLineCustomValues",
                column: "ColumnDefinitionId");

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceLineCustomColumnDefinitions_FirmId",
                table: "InvoiceLineCustomColumnDefinitions",
                column: "FirmId");

            migrationBuilder.AddForeignKey(
                name: "FK_InvoiceLineCustomValues_InvoiceLineCustomColumnDefinitions_ColumnDefinitionId",
                table: "InvoiceLineCustomValues",
                column: "ColumnDefinitionId",
                principalTable: "InvoiceLineCustomColumnDefinitions",
                principalColumn: "InvoiceLineCustomColumnDefinitionId",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
