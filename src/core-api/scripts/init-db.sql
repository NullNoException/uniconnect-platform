-- Create keycloak database for Keycloak authentication service
CREATE DATABASE keycloak;

-- Grant permissions to the uniconnect user for the keycloak database
GRANT ALL PRIVILEGES ON DATABASE keycloak TO uniconnect;

-- Connect to keycloak database and set up schema
\c keycloak;

-- Grant all privileges on schema
GRANT ALL ON SCHEMA public TO uniconnect;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO uniconnect;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO uniconnect;

-- Set default privileges for future tables and sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO uniconnect;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO uniconnect;
