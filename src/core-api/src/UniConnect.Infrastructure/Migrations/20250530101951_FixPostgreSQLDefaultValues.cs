using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace UniConnect.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class FixPostgreSQLDefaultValues : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Fix all default value expressions using SQL Server's GETUTCDATE() function
            // Replace with PostgreSQL's NOW() function for timestamp default values

            // Update CreatedAt default values in all tables that use it
            migrationBuilder.Sql("DO $$ " +
                "DECLARE " +
                "    r RECORD; " +
                "BEGIN " +
                "    FOR r IN SELECT table_name, column_name " +
                "             FROM information_schema.columns " +
                "             WHERE table_schema = 'public' " +
                "               AND column_name = 'CreatedAt' " +
                "               AND column_default LIKE '%GETUTCDATE%' " +
                "    LOOP " +
                "        EXECUTE FORMAT('ALTER TABLE \"%s\" ALTER COLUMN \"%s\" SET DEFAULT NOW()', " +
                "                       r.table_name, r.column_name); " +
                "    END LOOP; " +
                "END $$;");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            // No rollback needed since we're just fixing default value expressions
        }
    }
}
