using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace InvoiceApp.Repository.Migrations
{
    /// <inheritdoc />
    public partial class AddInvoiceSnapshotAndBrandingModel : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsExemption",
                table: "VatRates",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "InvoiceTypeCode",
                table: "Invoices",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "OriginalInvoiceId",
                table: "Invoices",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ExemptionReason",
                table: "InvoiceLines",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "AccentColorHex",
                table: "Firms",
                type: "nvarchar(9)",
                maxLength: 9,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "FontFamily",
                table: "Firms",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "LogoBase64",
                table: "Firms",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "StampBase64",
                table: "Firms",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "BankAccounts",
                columns: table => new
                {
                    BankAccountId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirmId = table.Column<int>(type: "int", nullable: false),
                    BankName = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Currency = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false),
                    Iban = table.Column<string>(type: "nvarchar(34)", maxLength: 34, nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BankAccounts", x => x.BankAccountId);
                    table.ForeignKey(
                        name: "FK_BankAccounts_Firms_FirmId",
                        column: x => x.FirmId,
                        principalTable: "Firms",
                        principalColumn: "FirmId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "InvoiceLineCustomColumnDefinitions",
                columns: table => new
                {
                    InvoiceLineCustomColumnDefinitionId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirmId = table.Column<int>(type: "int", nullable: false),
                    Label = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    DisplayOrder = table.Column<int>(type: "int", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
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

            migrationBuilder.CreateTable(
                name: "InvoiceLineCustomValues",
                columns: table => new
                {
                    InvoiceLineCustomValueId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    InvoiceLineId = table.Column<int>(type: "int", nullable: false),
                    ColumnDefinitionId = table.Column<int>(type: "int", nullable: false),
                    ColumnLabel = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Value = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_InvoiceLineCustomValues", x => x.InvoiceLineCustomValueId);
                    table.ForeignKey(
                        name: "FK_InvoiceLineCustomValues_InvoiceLineCustomColumnDefinitions_ColumnDefinitionId",
                        column: x => x.ColumnDefinitionId,
                        principalTable: "InvoiceLineCustomColumnDefinitions",
                        principalColumn: "InvoiceLineCustomColumnDefinitionId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_InvoiceLineCustomValues_InvoiceLines_InvoiceLineId",
                        column: x => x.InvoiceLineId,
                        principalTable: "InvoiceLines",
                        principalColumn: "InvoiceLineId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Permissions",
                columns: new[] { "PermissionId", "Action", "CreatedDate", "Resource", "UpdatedDate" },
                values: new object[,]
                {
                    { 21, "Create", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "InvoiceSettings", null },
                    { 22, "Read", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "InvoiceSettings", null },
                    { 23, "Update", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "InvoiceSettings", null },
                    { 24, "Delete", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "InvoiceSettings", null }
                });

            migrationBuilder.UpdateData(
                table: "VatRates",
                keyColumn: "VatRateId",
                keyValue: 1,
                column: "IsExemption",
                value: false);

            migrationBuilder.UpdateData(
                table: "VatRates",
                keyColumn: "VatRateId",
                keyValue: 2,
                column: "IsExemption",
                value: false);

            migrationBuilder.UpdateData(
                table: "VatRates",
                keyColumn: "VatRateId",
                keyValue: 3,
                column: "IsExemption",
                value: false);

            migrationBuilder.InsertData(
                table: "VatRates",
                columns: new[] { "VatRateId", "CreatedDate", "IsExemption", "Rate", "UpdatedDate" },
                values: new object[] { 4, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), true, 0m, null });

            migrationBuilder.CreateIndex(
                name: "IX_Invoices_OriginalInvoiceId",
                table: "Invoices",
                column: "OriginalInvoiceId");

            migrationBuilder.CreateIndex(
                name: "IX_BankAccounts_FirmId",
                table: "BankAccounts",
                column: "FirmId");

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceLineCustomColumnDefinitions_FirmId",
                table: "InvoiceLineCustomColumnDefinitions",
                column: "FirmId");

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceLineCustomValues_ColumnDefinitionId",
                table: "InvoiceLineCustomValues",
                column: "ColumnDefinitionId");

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceLineCustomValues_InvoiceLineId",
                table: "InvoiceLineCustomValues",
                column: "InvoiceLineId");

            migrationBuilder.AddForeignKey(
                name: "FK_Invoices_Invoices_OriginalInvoiceId",
                table: "Invoices",
                column: "OriginalInvoiceId",
                principalTable: "Invoices",
                principalColumn: "InvoiceId",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Invoices_Invoices_OriginalInvoiceId",
                table: "Invoices");

            migrationBuilder.DropTable(
                name: "BankAccounts");

            migrationBuilder.DropTable(
                name: "InvoiceLineCustomValues");

            migrationBuilder.DropTable(
                name: "InvoiceLineCustomColumnDefinitions");

            migrationBuilder.DropIndex(
                name: "IX_Invoices_OriginalInvoiceId",
                table: "Invoices");

            migrationBuilder.DeleteData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Permissions",
                keyColumn: "PermissionId",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "VatRates",
                keyColumn: "VatRateId",
                keyValue: 4);

            migrationBuilder.DropColumn(
                name: "IsExemption",
                table: "VatRates");

            migrationBuilder.DropColumn(
                name: "InvoiceTypeCode",
                table: "Invoices");

            migrationBuilder.DropColumn(
                name: "OriginalInvoiceId",
                table: "Invoices");

            migrationBuilder.DropColumn(
                name: "ExemptionReason",
                table: "InvoiceLines");

            migrationBuilder.DropColumn(
                name: "AccentColorHex",
                table: "Firms");

            migrationBuilder.DropColumn(
                name: "FontFamily",
                table: "Firms");

            migrationBuilder.DropColumn(
                name: "LogoBase64",
                table: "Firms");

            migrationBuilder.DropColumn(
                name: "StampBase64",
                table: "Firms");
        }
    }
}
