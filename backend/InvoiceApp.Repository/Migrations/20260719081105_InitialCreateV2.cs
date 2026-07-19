using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace InvoiceApp.Repository.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreateV2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Firms",
                columns: table => new
                {
                    FirmId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Firms", x => x.FirmId);
                });

            migrationBuilder.CreateTable(
                name: "Permissions",
                columns: table => new
                {
                    PermissionId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Resource = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Action = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Permissions", x => x.PermissionId);
                });

            migrationBuilder.CreateTable(
                name: "VatRates",
                columns: table => new
                {
                    VatRateId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Rate = table.Column<decimal>(type: "decimal(5,2)", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VatRates", x => x.VatRateId);
                });

            migrationBuilder.CreateTable(
                name: "Customers",
                columns: table => new
                {
                    CustomerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TaxNumber = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Title = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Address = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    FirmId = table.Column<int>(type: "int", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Customers", x => x.CustomerId);
                    table.ForeignKey(
                        name: "FK_Customers_Firms_FirmId",
                        column: x => x.FirmId,
                        principalTable: "Firms",
                        principalColumn: "FirmId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Profiles",
                columns: table => new
                {
                    ProfileId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirmId = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    IsSystem = table.Column<bool>(type: "bit", nullable: false),
                    MinInvoiceAmount = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    MaxInvoiceAmount = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Profiles", x => x.ProfileId);
                    table.ForeignKey(
                        name: "FK_Profiles_Firms_FirmId",
                        column: x => x.FirmId,
                        principalTable: "Firms",
                        principalColumn: "FirmId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ProfilePermissions",
                columns: table => new
                {
                    ProfilePermissionId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProfileId = table.Column<int>(type: "int", nullable: false),
                    PermissionId = table.Column<int>(type: "int", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProfilePermissions", x => x.ProfilePermissionId);
                    table.ForeignKey(
                        name: "FK_ProfilePermissions_Permissions_PermissionId",
                        column: x => x.PermissionId,
                        principalTable: "Permissions",
                        principalColumn: "PermissionId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ProfilePermissions_Profiles_ProfileId",
                        column: x => x.ProfileId,
                        principalTable: "Profiles",
                        principalColumn: "ProfileId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProfileVatRates",
                columns: table => new
                {
                    ProfileVatRateId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProfileId = table.Column<int>(type: "int", nullable: false),
                    VatRateId = table.Column<int>(type: "int", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProfileVatRates", x => x.ProfileVatRateId);
                    table.ForeignKey(
                        name: "FK_ProfileVatRates_Profiles_ProfileId",
                        column: x => x.ProfileId,
                        principalTable: "Profiles",
                        principalColumn: "ProfileId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProfileVatRates_VatRates_VatRateId",
                        column: x => x.VatRateId,
                        principalTable: "VatRates",
                        principalColumn: "VatRateId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    UserId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserName = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Role = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    FirmId = table.Column<int>(type: "int", nullable: true),
                    ProfileId = table.Column<int>(type: "int", nullable: true),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.UserId);
                    table.ForeignKey(
                        name: "FK_Users_Firms_FirmId",
                        column: x => x.FirmId,
                        principalTable: "Firms",
                        principalColumn: "FirmId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Users_Profiles_ProfileId",
                        column: x => x.ProfileId,
                        principalTable: "Profiles",
                        principalColumn: "ProfileId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Invoices",
                columns: table => new
                {
                    InvoiceId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CustomerId = table.Column<int>(type: "int", nullable: false),
                    InvoiceNumber = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    InvoiceDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    TotalAmount = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    FirmId = table.Column<int>(type: "int", nullable: false),
                    CreatedByUserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    DeletedDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Invoices", x => x.InvoiceId);
                    table.ForeignKey(
                        name: "FK_Invoices_Customers_CustomerId",
                        column: x => x.CustomerId,
                        principalTable: "Customers",
                        principalColumn: "CustomerId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Invoices_Firms_FirmId",
                        column: x => x.FirmId,
                        principalTable: "Firms",
                        principalColumn: "FirmId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Invoices_Users_CreatedByUserId",
                        column: x => x.CreatedByUserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "InvoiceLines",
                columns: table => new
                {
                    InvoiceLineId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    InvoiceId = table.Column<int>(type: "int", nullable: false),
                    ItemName = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Quantity = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_InvoiceLines", x => x.InvoiceLineId);
                    table.ForeignKey(
                        name: "FK_InvoiceLines_Invoices_InvoiceId",
                        column: x => x.InvoiceId,
                        principalTable: "Invoices",
                        principalColumn: "InvoiceId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_InvoiceLines_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Permissions",
                columns: new[] { "PermissionId", "Action", "CreatedDate", "Resource", "UpdatedDate" },
                values: new object[,]
                {
                    { 1, "Create", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Users", null },
                    { 2, "Read", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Users", null },
                    { 3, "Update", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Users", null },
                    { 4, "Delete", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Users", null },
                    { 5, "Create", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Profiles", null },
                    { 6, "Read", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Profiles", null },
                    { 7, "Update", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Profiles", null },
                    { 8, "Delete", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Profiles", null },
                    { 9, "Create", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Customers", null },
                    { 10, "Read", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Customers", null },
                    { 11, "Update", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Customers", null },
                    { 12, "Delete", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Customers", null },
                    { 13, "Create", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Invoices", null },
                    { 14, "Read", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Invoices", null },
                    { 15, "Update", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Invoices", null },
                    { 16, "Delete", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Invoices", null }
                });

            migrationBuilder.InsertData(
                table: "VatRates",
                columns: new[] { "VatRateId", "CreatedDate", "Rate", "UpdatedDate" },
                values: new object[,]
                {
                    { 1, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), 1m, null },
                    { 2, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), 10m, null },
                    { 3, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), 20m, null }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Customers_FirmId",
                table: "Customers",
                column: "FirmId");

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceLines_InvoiceId",
                table: "InvoiceLines",
                column: "InvoiceId");

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceLines_UserId",
                table: "InvoiceLines",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Invoices_CreatedByUserId",
                table: "Invoices",
                column: "CreatedByUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Invoices_CustomerId",
                table: "Invoices",
                column: "CustomerId");

            migrationBuilder.CreateIndex(
                name: "IX_Invoices_FirmId",
                table: "Invoices",
                column: "FirmId");

            migrationBuilder.CreateIndex(
                name: "IX_Invoices_InvoiceDate",
                table: "Invoices",
                column: "InvoiceDate");

            migrationBuilder.CreateIndex(
                name: "IX_Permissions_Resource_Action",
                table: "Permissions",
                columns: new[] { "Resource", "Action" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ProfilePermissions_PermissionId",
                table: "ProfilePermissions",
                column: "PermissionId");

            migrationBuilder.CreateIndex(
                name: "IX_ProfilePermissions_ProfileId_PermissionId",
                table: "ProfilePermissions",
                columns: new[] { "ProfileId", "PermissionId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Profiles_FirmId",
                table: "Profiles",
                column: "FirmId");

            migrationBuilder.CreateIndex(
                name: "IX_Profiles_FirmId_Name",
                table: "Profiles",
                columns: new[] { "FirmId", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ProfileVatRates_ProfileId_VatRateId",
                table: "ProfileVatRates",
                columns: new[] { "ProfileId", "VatRateId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ProfileVatRates_VatRateId",
                table: "ProfileVatRates",
                column: "VatRateId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_FirmId",
                table: "Users",
                column: "FirmId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_ProfileId",
                table: "Users",
                column: "ProfileId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_UserName",
                table: "Users",
                column: "UserName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_VatRates_Rate",
                table: "VatRates",
                column: "Rate",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "InvoiceLines");

            migrationBuilder.DropTable(
                name: "ProfilePermissions");

            migrationBuilder.DropTable(
                name: "ProfileVatRates");

            migrationBuilder.DropTable(
                name: "Invoices");

            migrationBuilder.DropTable(
                name: "Permissions");

            migrationBuilder.DropTable(
                name: "VatRates");

            migrationBuilder.DropTable(
                name: "Customers");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Profiles");

            migrationBuilder.DropTable(
                name: "Firms");
        }
    }
}
