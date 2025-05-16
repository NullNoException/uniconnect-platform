terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.80.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.80.0"
    }
  }
  
  backend "gcs" {
    # These values are passed via -backend-config
    # bucket = ""
    # prefix = ""
  }
}

# Variables
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

# Providers
provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs
resource "google_project_service" "required_services" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "firestore.googleapis.com",
    "firebase.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudfunctions.googleapis.com",
    "storage.googleapis.com",
  ])

  service = each.value
  disable_on_destroy = false
}

# Firebase project setup
resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.project_id
  depends_on = [google_project_service.required_services]
}

# Firebase web app
resource "google_firebase_web_app" "customer_app" {
  provider     = google-beta
  project      = var.project_id
  display_name = "UniConnect Customer App"
  depends_on   = [google_firebase_project.default]
}

resource "google_firebase_web_app" "admin_app" {
  provider     = google-beta
  project      = var.project_id
  display_name = "UniConnect Admin Panel"
  depends_on   = [google_firebase_project.default]
}

# Create hosting sites
resource "google_firebase_hosting_site" "customer_site" {
  provider = google-beta
  project  = var.project_id
  site_id  = "uniconnect-customer-${var.environment}"
  app_id   = google_firebase_web_app.customer_app.app_id
  depends_on = [google_firebase_web_app.customer_app]
}

resource "google_firebase_hosting_site" "admin_site" {
  provider = google-beta
  project  = var.project_id
  site_id  = "uniconnect-admin-${var.environment}"
  app_id   = google_firebase_web_app.admin_app.app_id
  depends_on = [google_firebase_web_app.admin_app]
}

# GCS Bucket for document storage
resource "google_storage_bucket" "documents" {
  name          = "uniconnect-documents-${var.environment}"
  location      = var.region
  force_destroy = var.environment != "prod"
  
  uniform_bucket_level_access = true
  
  versioning {
    enabled = true
  }
  
  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }
}

# Artifact Registry for Docker images
resource "google_artifact_registry_repository" "uniconnect_repo" {
  provider = google-beta

  location = var.region
  repository_id = "uniconnect-${var.environment}"
  description = "Docker repository for UniConnect services"
  format = "DOCKER"
  
  depends_on = [google_project_service.required_services]
}

# Cloud Run service for API
resource "google_cloud_run_v2_service" "api_service" {
  name     = "uniconnect-api-${var.environment}"
  location = var.region
  
  template {
    containers {
      image = "us-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.uniconnect_repo.repository_id}/core-api:latest"
      
      env {
        name  = "ASPNETCORE_ENVIRONMENT"
        value = title(var.environment)
      }
      
      env {
        name  = "GOOGLE_PROJECT_ID"
        value = var.project_id
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }

    scaling {
      max_instance_count = 10
    }
  }
  
  depends_on = [google_project_service.required_services]
}

# Make the API public
resource "google_cloud_run_v2_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.api_service.location
  name     = google_cloud_run_v2_service.api_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Firestore database
resource "google_firestore_database" "database" {
  project     = var.project_id
  name        = "(default)"
  location_id = var.region
  type        = "FIRESTORE_NATIVE"
  
  depends_on = [google_project_service.required_services]
}

# Secret Manager for sensitive configurations
resource "google_secret_manager_secret" "api_key" {
  secret_id = "api-key-${var.environment}"
  
  replication {
    auto {
      customer_managed_encryption {
        kms_key_name = google_kms_crypto_key.crypto_key.id
      }
    }
  }
  
  depends_on = [google_project_service.required_services]
}

# KMS for encryption
resource "google_kms_key_ring" "keyring" {
  name     = "uniconnect-keyring-${var.environment}"
  location = var.region
  
  depends_on = [google_project_service.required_services]
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "uniconnect-key-${var.environment}"
  key_ring = google_kms_key_ring.keyring.id
  
  purpose = "ENCRYPT_DECRYPT"
  
  version_template {
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level = "SOFTWARE"
  }
  
  lifecycle {
    prevent_destroy = false
  }
}

# Outputs
output "firebase_customer_app_id" {
  value = google_firebase_web_app.customer_app.app_id
}

output "firebase_admin_app_id" {
  value = google_firebase_web_app.admin_app.app_id
}

output "api_url" {
  value = google_cloud_run_v2_service.api_service.uri
}

output "artifact_registry_repo" {
  value = google_artifact_registry_repository.uniconnect_repo.name
}

output "document_storage_bucket" {
  value = google_storage_bucket.documents.name
}