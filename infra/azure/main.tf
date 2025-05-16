terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
    }
  }
  
  backend "azurerm" {
    # These values are passed via -backend-config
    # storage_account_name = ""
    # container_name       = ""
    # key                  = ""
    # access_key           = ""
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

# Variables
variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "uniconnectacr"
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = true

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# App Service Plan
resource "azurerm_service_plan" "app_plan" {
  name                = "uniconnect-plan-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = var.environment == "prod" ? "P1v2" : "B1"

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# Core API App Service
resource "azurerm_linux_web_app" "core_api" {
  name                = "uniconnect-api-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    application_stack {
      docker_image     = "${azurerm_container_registry.acr.login_server}/uniconnect/core-api"
      docker_image_tag = "latest"
    }
    always_on        = true
    health_check_path = "/health"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = azurerm_container_registry.acr.admin_password
    "ASPNETCORE_ENVIRONMENT"              = title(var.environment)
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# Azure Storage Account for documents
resource "azurerm_storage_account" "storage" {
  name                     = "uniconnectstore${var.environment}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# Storage container for documents
resource "azurerm_storage_container" "documents" {
  name                  = "documents"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# Azure SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "uniconnect-sqlserver-${var.environment}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "sqlsystemadmin"
  administrator_login_password = "P@ssw0rd1234!" # Should be moved to Key Vault in production

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# Azure SQL Database
resource "azurerm_mssql_database" "sql_db" {
  name      = "UniConnectDB"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.environment == "prod" ? "S1" : "Basic"

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = "uniconnect-kv-${var.environment}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  tags = {
    environment = var.environment
    application = "uniconnect"
  }
}

# Get current client config for Key Vault access policies
data "azurerm_client_config" "current" {}

# Key vault access policy for the deploying user
resource "azurerm_key_vault_access_policy" "user" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create", "Delete", "Get", "List", "Purge", "Recover", "Update",
  ]

  secret_permissions = [
    "Set", "Get", "Delete", "List", "Purge", "Recover",
  ]

  certificate_permissions = [
    "Create", "Delete", "Get", "List", "Update",
  ]
}

# Key vault access policy for the Core API
resource "azurerm_key_vault_access_policy" "api" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_linux_web_app.core_api.identity[0].principal_id

  secret_permissions = [
    "Get", "List",
  ]
}

# Database connection string secret
resource "azurerm_key_vault_secret" "db_connection" {
  name         = "DbConnectionString"
  value        = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_db.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sql_server.administrator_login};Password=${azurerm_mssql_server.sql_server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_key_vault_access_policy.user
  ]
}

# Outputs
output "core_api_url" {
  value = "https://${azurerm_linux_web_app.core_api.default_hostname}"
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.key_vault.vault_uri
}

output "sql_server_name" {
  value = azurerm_mssql_server.sql_server.name
}

output "sql_database_name" {
  value = azurerm_mssql_database.sql_db.name
}