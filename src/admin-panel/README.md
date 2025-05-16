# UniConnect Admin Panel

This is the administration panel for the UniConnect Educational Services Marketplace platform. It provides interfaces for both system administrators and service providers to manage their offerings, track orders, and interact with customers.

## Features

- Platform administration

  - User management
  - Service category management
  - Content moderation
  - System configuration

- Provider portal
  - Service listing management
  - Order tracking and fulfillment
  - Customer communication
  - Payment processing and reports
  - Document management

## Technology Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **Storage**: Firebase Cloud Firestore
- **Authentication**: Firebase Auth / Keycloak
- **Hosting**: Firebase Hosting

## Getting Started

### Prerequisites

- Flutter 3.x
- Dart SDK
- Firebase CLI

### Installation

1. Clone the repository
2. Install dependencies:

   ```bash
   cd src/admin-panel
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run -d chrome
   ```

## Project Structure

- `lib/` - Dart source code
  - `core/` - Core functionality and utilities
  - `data/` - Data layer with repositories and data sources
  - `domain/` - Domain layer with entities and use cases
  - `presentation/` - UI components and screens
  - `di/` - Dependency injection

## Development Guidelines

- Follow the clean architecture principles
- Use feature-first organization within presentation layer
- Implement comprehensive unit and widget tests
- Use proper internationalization for all text

## Deployment

The admin panel is automatically deployed to Firebase Hosting through CI/CD pipeline when changes are pushed to the main branch.

## Related Projects

- [Customer App](/src/customer_app)
- [Core API](/src/core-api)
