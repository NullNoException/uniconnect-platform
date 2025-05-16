# GitHub Repository Setup Guide

This document outlines the steps to set up the UniConnect project repository on GitHub with best practices for security, collaboration, and CI/CD.

## Repository Structure

The repository follows this organization:

- `/business-analyst`: Business requirements and specifications
- `/infra`: Infrastructure as Code (Azure and GCP)
- `/src`: Source code for all applications
- `/.github`: CI/CD workflows and GitHub configurations

## Setting Up the Repository

### 1. Create the GitHub Repository

1. Create a new repository on GitHub
   - Name: `uniconnect-platform`
   - Description: "UniConnect Educational Services Marketplace"
   - Visibility: Private
   - Initialize with a README

### 2. Configure Repository Settings

1. **Branch Protection**

   - Navigate to Settings > Branches > Add rule
   - Branch name pattern: `main`
   - Check "Require pull request reviews before merging"
   - Check "Require status checks to pass before merging"
   - Check "Require branches to be up to date before merging"
   - Check "Include administrators"

2. **Security Settings**

   - Enable Dependabot alerts
   - Enable automated security updates
   - Set up code scanning with CodeQL analysis

3. **Collaboration Settings**
   - Set up teams for:
     - Admins (full access)
     - Developers (write access)
     - Reviewers (read access)
   - Configure CODEOWNERS file to automatically assign reviewers

### 3. Configure Repository Secrets

For CI/CD automation, add the following secrets:

1. **Azure Deployment**

   - `AZURE_CREDENTIALS`: Service principal credentials
   - `AZURE_CLIENT_ID`: Service principal client ID
   - `AZURE_CLIENT_SECRET`: Service principal password
   - `AZURE_SUBSCRIPTION_ID`: Azure subscription ID
   - `AZURE_TENANT_ID`: Azure tenant ID

2. **Google Cloud Deployment**

   - `GCP_SA_KEY`: Service account key JSON

3. **Container Registry**

   - `CONTAINER_REGISTRY`: Registry URL
   - `REGISTRY_USERNAME`: Registry username
   - `REGISTRY_PASSWORD`: Registry password

4. **Kubernetes**

   - `KUBE_CONFIG`: Base64 encoded kubeconfig

5. **Firebase**
   - `FIREBASE_SERVICE_ACCOUNT`: Firebase service account credentials

## Local Development Setup

### 1. Clone the Repository

```bash
git clone https://github.com/your-organization/uniconnect-platform.git
cd uniconnect-platform
```

### 2. Configure Git Hooks

Set up Git hooks using Husky to enforce code quality:

```bash
# Git hooks are already configured in the .husky directory
# The configuration is automatically applied when you clone the repository
```

Git hooks that are enabled:

1. **Pre-commit Hook**: Runs before each commit to ensure code quality

   - Formats and lints Dart/Flutter code
   - Formats C# code with dotnet format
   - Runs Python pre-commit hooks for Python files

2. **Commit Message Hook**: Enforces conventional commit message format
   - Format: `type(scope): subject`
   - Example: `feat(api): add user authentication endpoint`
   - Valid types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

To bypass hooks temporarily (not recommended):

```bash
git commit -m "message" --no-verify
# or
HUSKY=0 git push
```

### 3. Branch Naming Convention

- Feature branches: `feature/description`
- Bug fixes: `fix/description`
- Releases: `release/version`
- Hotfixes: `hotfix/description`

### 4. Commit Message Guidelines

- Use the format: `type(scope): subject`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- Example: `feat(api): add user authentication endpoint`

## Contribution Workflow

1. **Create a Branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes and Commit**

   ```bash
   git add .
   git commit -m "Descriptive commit message"
   ```

3. **Push Changes**

   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create a Pull Request**

   - Navigate to the repository on GitHub
   - Click "Compare & pull request"
   - Fill out the PR template
   - Request reviews from appropriate team members

5. **Address Review Comments**

   - Make requested changes
   - Push additional commits to the branch

6. **Merge the Pull Request**
   - Once approved, merge using the "Squash and merge" option
   - Delete the branch after merging

## CI/CD Pipeline

The repository includes GitHub Actions workflows for:

1. **Core API Pipeline** (`.github/workflows/core-api.yml`)

   - Triggered on changes to the Core API code
   - Builds, tests, analyzes, and deploys the API

2. **Flutter Apps Pipeline** (`.github/workflows/flutter-apps.yml`)

   - Triggered on changes to the Flutter applications
   - Builds, tests, and deploys web, Android, and iOS versions

3. **Infrastructure Pipeline** (`.github/workflows/infrastructure.yml`)
   - Triggered on changes to the infrastructure code
   - Validates, plans, and applies Terraform configurations

## Automating Releases

1. **Version Tagging**

   - Create tags for releases: `git tag v1.0.0`
   - Push tags: `git push --tags`

2. **Release Notes**
   - Use GitHub Releases to document changes
   - Link to relevant issues and pull requests

## Security Best Practices

1. **Secret Management**

   - Never commit secrets to the repository
   - Use GitHub Secrets for CI/CD credentials
   - Use environment-specific variable files for configurations

2. **Code Scanning**

   - Automated code scanning with CodeQL is set up via `.github/workflows/codeql-analysis.yml`
   - CodeQL analyzes JavaScript, Python, C#, and Dart code
   - Scans run automatically on push to main, PRs to main, and weekly on Sunday
   - Address security alerts promptly via the Security tab

3. **Dependency Management**
   - Keep dependencies updated
   - Review Dependabot alerts and PRs
