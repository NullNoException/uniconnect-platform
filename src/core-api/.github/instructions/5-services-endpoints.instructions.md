---
applyTo: '**/*.cs'
---

🛠 Service Management Tables
🔹 ServiceCategories
"Create a hierarchical service category system with support for parent-child relationships. Allow admins to define category names, descriptions, icons, display order, and active status. Categories should be filterable and manageable via an admin UI."

🔹 Services
"Enable providers (authenticated via Keycloak) to create and manage service offerings. Each service should include category linkage, descriptive fields (name, short and full description), pricing details (base price and currency), delivery time estimates, and active status. Support featured ranking and thumbnails."

🔹 ServiceAttributes
"Allow providers to add customizable key-value attribute pairs for each service. These attributes can describe specific features or options relevant to the service. Include creation and update audit trails."

🔹 ServiceRequirements
"Implement a system where services can define mandatory or optional requirements, such as documents or conditions. Requirements should support descriptions and optionally link to document types. Allow flagging mandatory status and support soft deletion."

🔹 ServicePriceComponents
"Provide granular pricing components within services, such as optional add-ons or included features. Each component should have a name, description, price, and optional flag to indicate if it’s mandatory or optional. Support audit metadata."
📦 Order Management Tables
🔹 ServiceRequests
"Build a service request management system to track orders placed by students for various services. Each request should link to the student’s Keycloak user ID and the selected service. Implement request lifecycle states such as initiated, in progress, completed, cancelled, etc., with timestamps for initiation, completion, and cancellation. Support recording cancellation reasons and internal notes visible to admins and providers. Track all creation and modification metadata. Enable soft deletion for data integrity."

🔹 RequestDocuments
"Create a document upload and management system tied to service requests. Support multiple document types per request with metadata including file name, size, upload date, and verification status. Allow documents to be verified by authorized users with logging of verifier ID, date, and notes. Support status updates (e.g., pending, approved, rejected) and soft deletion. Ensure secure file storage and access control, respecting user permissions managed via Keycloak."

🔹 DocumentTypes
"Define a catalog of document types that can be required or optional for service requests. Include attributes like name, description, allowed file extensions, and maximum file size. Flag documents as personal ID or educational documents for categorization. Maintain audit fields and support soft deletion for obsolete types."

🔹 RequestMilestones
"Implement a milestone tracking system for service requests to monitor progress. Milestones should have descriptive names, detailed descriptions, due dates, completion dates, and status indicators (e.g., pending, completed, overdue). Each milestone links to a service request and includes audit metadata. Support notifications or alerts based on milestone status changes or approaching due dates."

Additional elaborations:
Status Management & Workflow:
"Design a flexible status workflow for service requests and milestones, enabling transitions between various stages with permission checks based on user roles defined in Keycloak (e.g., only providers or admins can mark milestones complete)."

User Notifications:
"Trigger email or in-app notifications when milestones are reached, documents are uploaded or verified, requests are cancelled, or statuses change. Ensure notification preferences can be configured by users."

Audit Trail & History:
"Maintain a detailed audit trail for requests and documents, including who performed actions, when, and any notes or comments added."

Soft Deletion & Data Retention:
"Support soft deletion for all entities to enable data recovery and comply with retention policies. Provide admins with tools to permanently purge data if needed."
