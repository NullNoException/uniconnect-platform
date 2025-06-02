---
applyTo: '**/*.cs'
---

💰 Financial Management Tables
🔹 Transactions
"Design a comprehensive transaction management system to track all financial movements related to service requests. Each transaction should be linked to a specific service request and include details such as transaction type (payment, refund, commission, etc.), amount, currency, exchange rate, status (pending, completed, failed), and payment method used. Support integration with external payment gateways via transaction IDs and store platform fee and provider earnings separately for transparent financial reconciliation. Ensure all transactions have full audit trails with timestamps and user references. Soft deletion should be supported for audit and compliance purposes."

🔹 PaymentMethods
"Enable users (students, providers) to securely manage multiple payment methods in their profile. Payment methods should include type (credit card, bank transfer, e-wallet, etc.), masked account details, expiration dates, and default method designation. Store payment gateway tokens and customer IDs to facilitate seamless transactions without exposing sensitive data. Payment methods must be linked to Keycloak user IDs and enforce access control so users can only manage their own payment details."

🔹 Currencies
"Maintain a master list of supported currencies with metadata such as currency code, symbol, full name, and active status. Use this list for pricing, transactions, invoices, and conversions across the platform. Enable administrators to activate or deactivate currencies as needed and update metadata while preserving audit logs."

🔹 SubscriptionPlans
"Implement subscription plan management for service providers, detailing plan features such as monthly and annual pricing, currency, commission percentages, maximum allowed service listings, inclusion of featured listings, API access, and allowed staff accounts. Support plan activation status and provide audit details for creation and updates. Allow providers to upgrade, downgrade, or cancel subscriptions, with billing date tracking and limits enforcement according to the plan."

🔹 Invoices
"Generate and manage invoices related to financial transactions, subscriptions, or one-time charges. Each invoice should reference the relevant entity (provider or student), include a unique invoice number, dates (issue, due, payment), total amount, currency, and payment status. Track payment amounts, partial payments, and paid dates for accurate financial records. Support invoice soft deletion and audit tracking."

🔹 InvoiceItems
"Support detailed invoice line items, each including description, quantity, unit price, total price, and applicable taxes with percentages and calculated tax amounts. Link items to invoices and maintain creation and update audit metadata. Allow admins and providers to generate invoice summaries and itemized billing reports."

Additional elaborations:
Security & Compliance:
"Ensure all financial data complies with PCI DSS and relevant financial regulations. Encrypt sensitive payment details and restrict access to authorized roles authenticated via Keycloak."

Role-Based Access Control:
"Use Keycloak roles to limit access to financial management features. For example, only providers can view their transactions and subscriptions; admins can view all financial data for auditing."

Currency Conversion & Pricing:
"Implement currency conversion workflows with exchange rate tracking to support multi-currency pricing and payments. Allow display of pricing and balances in users’ preferred currencies."

Billing & Subscription Lifecycle:
"Automate billing cycles, subscription renewals, and expiry notifications. Provide UI flows for users to manage subscriptions and view billing history."

Audit & Reporting:
"Keep detailed logs of all financial activities for audit purposes. Support exportable financial reports for accounting and compliance teams."
