using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace UniConnect.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class UpdateTransactionEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Add new columns to Transaction table
            migrationBuilder.AddColumn<Guid>(
                name: "ServiceRequestId",
                table: "Transactions",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<Guid>(
                name: "StudentId",
                table: "Transactions",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<Guid>(
                name: "ProviderId",
                table: "Transactions",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<DateTime>(
                name: "ProcessedDate",
                table: "Transactions",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Notes",
                table: "Transactions",
                type: "character varying(1000)",
                maxLength: 1000,
                nullable: true);

            // Convert Status column from string to integer (for enum)
            // First, add a temporary column
            migrationBuilder.AddColumn<int>(
                name: "Status_New",
                table: "Transactions",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            // Update the new column based on existing string values
            migrationBuilder.Sql(@"
                UPDATE ""Transactions"" 
                SET ""Status_New"" = CASE 
                    WHEN ""Status"" = 'Pending' THEN 0
                    WHEN ""Status"" = 'Escrowed' THEN 1
                    WHEN ""Status"" = 'Completed' THEN 2
                    WHEN ""Status"" = 'Released' THEN 3
                    WHEN ""Status"" = 'Refunded' THEN 4
                    WHEN ""Status"" = 'Failed' THEN 5
                    WHEN ""Status"" = 'Disputed' THEN 6
                    WHEN ""Status"" = 'Cancelled' THEN 7
                    ELSE 0
                END");

            // Drop the old Status column
            migrationBuilder.DropColumn(
                name: "Status",
                table: "Transactions");

            // Rename the new column to Status
            migrationBuilder.RenameColumn(
                name: "Status_New",
                table: "Transactions",
                newName: "Status");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            // Remove new columns
            migrationBuilder.DropColumn(
                name: "ServiceRequestId",
                table: "Transactions");

            migrationBuilder.DropColumn(
                name: "StudentId",
                table: "Transactions");

            migrationBuilder.DropColumn(
                name: "ProviderId",
                table: "Transactions");

            migrationBuilder.DropColumn(
                name: "ProcessedDate",
                table: "Transactions");

            migrationBuilder.DropColumn(
                name: "Notes",
                table: "Transactions");

            // Convert Status back to string
            migrationBuilder.AddColumn<string>(
                name: "Status_Old",
                table: "Transactions",
                type: "character varying(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "Pending");

            // Update the string column based on integer values
            migrationBuilder.Sql(@"
                UPDATE ""Transactions"" 
                SET ""Status_Old"" = CASE 
                    WHEN ""Status"" = 0 THEN 'Pending'
                    WHEN ""Status"" = 1 THEN 'Escrowed'
                    WHEN ""Status"" = 2 THEN 'Completed'
                    WHEN ""Status"" = 3 THEN 'Released'
                    WHEN ""Status"" = 4 THEN 'Refunded'
                    WHEN ""Status"" = 5 THEN 'Failed'
                    WHEN ""Status"" = 6 THEN 'Disputed'
                    WHEN ""Status"" = 7 THEN 'Cancelled'
                    ELSE 'Pending'
                END");

            migrationBuilder.DropColumn(
                name: "Status",
                table: "Transactions");

            migrationBuilder.RenameColumn(
                name: "Status_Old",
                table: "Transactions",
                newName: "Status");
        }
    }
}
