---
applyTo: '**/*.cs'
---

👤 User Identity, Profiles & Admin Management (via Keycloak)
🔹 Users (Managed by Keycloak)
"Integrate with Keycloak for user authentication and access control. Sync minimal user identity details from Keycloak, such as user ID, email, and roles. Avoid storing passwords. Use Keycloak as the authority for login, logout, registration, and token validation."

🔹 UserTypes (Mapped from Keycloak Roles)
"Map Keycloak roles to internal user types (e.g., Student, Provider, Admin). Keep this mapping configurable so platform features can use internal user type logic while relying on Keycloak for actual role enforcement."

🔹 UserProfiles
"Allow users authenticated via Keycloak to manage their personal profiles within the platform (e.g., name, phone, date of birth, preferred language, profile photo). Each profile should link to the Keycloak user ID and support audit tracking and soft deletion."

🔹 Students
"Design a student module that links to the Keycloak-authenticated user ID. Store educational preferences like current and target levels, preferred countries, and fields of study. Enable students to update this data via their dashboard."

🔹 ServiceProviders
"Enable provider accounts to be created post-authentication from Keycloak. Store business-related details like company name, registration info, verification status, subscription plan, and branding. Link each provider to a user ID from Keycloak."

🔹 ProviderStaff
"Allow provider accounts to add staff using Keycloak user records. Assign staff-specific roles, positions, and optional supervisors. Store permission scopes at the application level, while role enforcement remains within Keycloak."

🔹 Admins
"Use Keycloak roles to identify platform administrators. Store internal metadata (e.g., department, audit trail) for admins within the application, but rely on Keycloak for authentication and role checking."

🔹 Addresses
"Support a universal address model for linking geographic details to various entity types (students, providers, universities). Manage address metadata in the app, independent of Keycloak."

🔹 Countries
"Maintain a centralized list of countries with support for phone code, currency, and region mapping. Use this list in dropdowns and validations across profile, provider, and service forms."

🔹 Universities
"Build a module to manage university records, linked to countries and addresses. Enable admins to create, update, verify, or deactivate universities, while students and providers may view them via filters."

🔹 FieldsOfStudy
"Provide a structured academic discipline tree to categorize programs and student interests. Support hierarchical data for filtering and recommendation engines."
