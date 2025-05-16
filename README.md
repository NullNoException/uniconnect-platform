# UniConnect Educational Services Marketplace

UniConnect is a comprehensive educational services marketplace designed to connect university students with educational service providers. The platform facilitates the discovery, engagement, and delivery of educational support services through a secure and efficient ecosystem.

## Project Structure

- `/business-analyst` - Business requirements and specifications
- `/docs` - Project documentation and guides
- `/infra` - Infrastructure as Code (Azure and GCP)
- `/src` - Source code for all applications
  - `/core-api` - .NET 9 backend API services
  - `/customer_app` - Flutter-based cross-platform client application
  - `/admin-panel` - Flutter-based administration panel
- `/.github` - CI/CD workflows and GitHub configurations

## Applications

### Core API

The Core API provides the central backend services for the UniConnect platform, built with .NET 9 using a clean architecture approach. It implements a modular microservices structure with services for identity, catalog, orders, documents, payments, communications, and analytics.

### Customer App

A Flutter-based cross-platform application for students to discover and engage with educational service providers. The app supports offline capabilities, multiple languages, and provides a seamless experience across iOS, Android, and web platforms.

### Admin Panel

A Flutter-based administrative portal for platform administrators and service providers to manage their offerings, track orders, and handle customer interactions.

## Development

### Prerequisites

- .NET 9 SDK
- Flutter 3.x
- Docker and Docker Compose
- Terraform 1.5+
- Azure CLI
- Google Cloud SDK

### Getting Started

1. Clone the repository
2. Set up the development environment

   ```bash
   # Core API
   cd src/core-api
   ./start-docker.sh

   # Customer App
   cd src/customer_app
   flutter pub get
   flutter run

   # Admin Panel
   cd src/admin-panel
   flutter pub get
   flutter run
   ```

3. Infrastructure deployment
   ```bash
   cd infra/azure
   terraform init
   terraform apply
   ```

## CI/CD Pipeline

The project uses GitHub Actions for continuous integration and deployment with separate workflows for each component:

- **Core API Pipeline**: Builds, tests, and deploys the .NET backend services
- **Flutter Apps Pipeline**: Builds and deploys the customer app and admin panel for web, Android, and iOS
- **Infrastructure Pipeline**: Validates, plans, and applies Terraform configurations

See `.github/workflows` for specific pipeline configurations.

## GitHub Repository Setup

This project follows GitHub best practices for collaboration and security:

- Branch protection rules for `main`
- Pull request reviews required for all changes
- Automated CI/CD with GitHub Actions
- Issue and pull request templates
- Comprehensive contribution guidelines

For detailed setup instructions, see the [GitHub Repository Setup Guide](docs/github-repository-setup.md).

## Infrastructure as Code

The infrastructure is managed using Terraform with support for both Azure and Google Cloud:

- Multi-environment configuration (dev, staging, production)
- Kubernetes clusters for service deployment
- Managed databases and storage
- CDN for static content delivery
- Comprehensive security controls

For deployment instructions, see the [Infrastructure Deployment Guide](docs/infrastructure-deployment-guide.md).

## Documentation

### Business Analysis

Comprehensive business documentation is available in the `/business-analyst` directory:

- Business Requirements Documents (BRD)
- Software Requirements Specifications (SRS)
- System architecture design
- Feature lists

### Technical Documentation

Technical guides and references are available in the `/docs` directory:

- Implementation summaries
- Deployment guides
- Development workflows
- Operational procedures

## Contributing

Please read our [Contributing Guidelines](.github/CONTRIBUTING.md) and [Code of Conduct](.github/CODE_OF_CONDUCT.md) before submitting contributions.

## License

[Specify your license here]
