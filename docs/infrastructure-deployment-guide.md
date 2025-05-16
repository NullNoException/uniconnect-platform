# Infrastructure Deployment Guide

This document provides detailed instructions for deploying the UniConnect infrastructure using Terraform on both Azure and Google Cloud Platform (GCP).

## Prerequisites

Before beginning deployment, ensure you have the following:

1. **Local Tools**

   - Terraform v1.5 or later
   - Azure CLI (for Azure deployment)
   - Google Cloud SDK (for GCP deployment)
   - Git

2. **Azure Requirements**

   - An Azure subscription
   - Service principal with Contributor access
   - Storage account for Terraform state

3. **GCP Requirements**
   - GCP project
   - Service account with required permissions
   - GCS bucket for Terraform state

## Repository Structure

```
/infra/
  /azure/
    main.tf                 # Main Terraform configuration
    variables.tf            # Input variables
    outputs.tf              # Output values
    /environments/
      dev.tfvars            # Development environment variables
      staging.tfvars        # Staging environment variables
      production.tfvars     # Production environment variables
    /modules/
      # Azure-specific modules
  /gcp/
    main.tf                 # Main Terraform configuration
    variables.tf            # Input variables
    outputs.tf              # Output values
    /environments/
      dev.tfvars            # Development environment variables
      staging.tfvars        # Staging environment variables
      production.tfvars     # Production environment variables
    /modules/
      # GCP-specific modules
```

## Azure Deployment

### 1. Authentication Setup

Set up Azure authentication for Terraform:

```bash
# Login to Azure
az login

# Set the subscription
az account set --subscription <subscription_id>

# Create Service Principal (if not already created)
az ad sp create-for-rbac --name "UniConnect-Terraform" --role Contributor \
  --scopes /subscriptions/<subscription_id>
```

Note the output containing appId, password, and tenant - these will be used for Terraform authentication.

### 2. Backend Configuration

Create a storage account for Terraform state:

```bash
# Create Resource Group
az group create --name terraform-state-rg --location eastus

# Create Storage Account
az storage account create --name uniconnectterraform \
  --resource-group terraform-state-rg --location eastus \
  --sku Standard_LRS

# Create Storage Container
az storage container create --name terraform-state \
  --account-name uniconnectterraform
```

Create a backend configuration file `azure-backend.hcl`:

```hcl
storage_account_name = "uniconnectterraform"
container_name       = "terraform-state"
key                  = "azure/dev.tfstate"
```

### 3. Initialize Terraform

```bash
cd infra/azure

# Set environment variables for authentication
export ARM_CLIENT_ID="<service_principal_app_id>"
export ARM_CLIENT_SECRET="<service_principal_password>"
export ARM_SUBSCRIPTION_ID="<subscription_id>"
export ARM_TENANT_ID="<tenant_id>"

# Initialize Terraform with backend configuration
terraform init -backend-config=azure-backend.hcl
```

### 4. Terraform Plan

Review the changes that will be applied:

```bash
# For development environment
terraform plan -var-file=environments/dev.tfvars -out=tfplan

# For staging environment
# terraform plan -var-file=environments/staging.tfvars -out=tfplan

# For production environment
# terraform plan -var-file=environments/production.tfvars -out=tfplan
```

### 5. Terraform Apply

Apply the infrastructure changes:

```bash
terraform apply tfplan
```

## Google Cloud Platform Deployment

### 1. Authentication Setup

Set up GCP authentication for Terraform:

```bash
# Login to Google Cloud
gcloud auth login

# Set the project
gcloud config set project <project_id>

# Create Service Account (if not already created)
gcloud iam service-accounts create terraform \
  --display-name "Terraform Service Account"

# Assign required roles to the service account
gcloud projects add-iam-policy-binding <project_id> \
  --member="serviceAccount:terraform@<project_id>.iam.gserviceaccount.com" \
  --role="roles/owner"

# Create and download a key
gcloud iam service-accounts keys create gcp-terraform-key.json \
  --iam-account=terraform@<project_id>.iam.gserviceaccount.com
```

### 2. Backend Configuration

Create a GCS bucket for Terraform state:

```bash
# Create a GCS bucket
gsutil mb -l us-central1 gs://uniconnect-terraform-state/

# Enable versioning
gsutil versioning set on gs://uniconnect-terraform-state/
```

Create a backend configuration file `gcp-backend.hcl`:

```hcl
bucket = "uniconnect-terraform-state"
prefix = "gcp/dev"
```

### 3. Initialize Terraform

```bash
cd infra/gcp

# Set environment variable for authentication
export GOOGLE_CREDENTIALS="$(pwd)/gcp-terraform-key.json"

# Initialize Terraform with backend configuration
terraform init -backend-config=gcp-backend.hcl
```

### 4. Terraform Plan

Review the changes that will be applied:

```bash
# For development environment
terraform plan -var-file=environments/dev.tfvars -out=tfplan

# For staging environment
# terraform plan -var-file=environments/staging.tfvars -out=tfplan

# For production environment
# terraform plan -var-file=environments/production.tfvars -out=tfplan
```

### 5. Terraform Apply

Apply the infrastructure changes:

```bash
terraform apply tfplan
```

## Automated Deployment with GitHub Actions

The repository includes GitHub Actions workflows for automated infrastructure deployment:

1. **Validation**: Run on pull requests to validate Terraform configurations
2. **Planning**: Generate and store Terraform plans
3. **Application**: Apply Terraform plans when changes are merged to main

To use this automation:

1. Set up the required GitHub Secrets:

   - For Azure: `AZURE_CREDENTIALS`, `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_SUBSCRIPTION_ID`, `AZURE_TENANT_ID`
   - For GCP: `GCP_SA_KEY`

2. Use the workflow dispatch feature to manually trigger deployments for specific environments

## Infrastructure Management

### Viewing Outputs

After deployment, view the outputs:

```bash
terraform output
```

### Making Changes

To make changes to the infrastructure:

1. Update the Terraform configuration files
2. Run `terraform plan` to review changes
3. Run `terraform apply` to apply changes

### Destroying Resources

When needed, destroy resources (use with caution):

```bash
# For Azure
cd infra/azure
terraform destroy -var-file=environments/dev.tfvars

# For GCP
cd infra/gcp
terraform destroy -var-file=environments/dev.tfvars
```

## Best Practices

1. **State Management**

   - Never edit the Terraform state files manually
   - Use remote state locking to prevent concurrent modifications

2. **Secret Management**

   - Store sensitive values using Azure Key Vault or Google Secret Manager
   - Never commit credentials to the repository

3. **Module Versioning**

   - Pin module versions for stability
   - Update modules systematically with testing

4. **Documentation**

   - Document all non-obvious configuration decisions
   - Maintain up-to-date diagrams of the infrastructure

5. **Testing**
   - Test infrastructure changes in lower environments first
   - Use terraform-validator for policy compliance

## Troubleshooting

### Common Issues

1. **Authentication Failures**

   - Verify environment variables are correctly set
   - Check service principal/account permissions

2. **State Lock Issues**

   - Force unlock if necessary: `terraform force-unlock <lock_id>`

3. **Resource Dependencies**
   - Ensure proper dependency management between resources
   - Use `depends_on` attribute when necessary

### Getting Help

For assistance:

1. Review Terraform documentation and provider documentation
2. Check the infrastructure team's internal knowledge base
3. Submit an issue to the infrastructure repository
