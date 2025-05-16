﻿using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace UniConnect.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class FixTransactionPaymentMethodRelationship : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Transactions_PaymentMethods_PaymentMethodId1",
                table: "Transactions");

            migrationBuilder.DropIndex(
                name: "IX_Transactions_PaymentMethodId1",
                table: "Transactions");

            migrationBuilder.DropColumn(
                name: "PaymentMethodId1",
                table: "Transactions");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "PaymentMethodId1",
                table: "Transactions",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Transactions_PaymentMethodId1",
                table: "Transactions",
                column: "PaymentMethodId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Transactions_PaymentMethods_PaymentMethodId1",
                table: "Transactions",
                column: "PaymentMethodId1",
                principalTable: "PaymentMethods",
                principalColumn: "Id");
        }
    }
}
