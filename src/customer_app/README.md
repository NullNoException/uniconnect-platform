# UniConnect Mobile Client Application

## Technical Specification Document

### Document Information

- **Project Name**: UniConnect
- **Document Type**: Technical Specification
- **Version**: 1.0
- **Last Updated**: May 14, 2025

---

## 1. Introduction

### 1.1 Purpose

This document provides comprehensive technical specifications for the UniConnect mobile client application, designed to connect university students with educational service providers. The application serves as the primary touchpoint for students accessing the platform's services.

### 1.2 Scope

The mobile application will be developed using Flutter to support iOS, Android, macOS, Windows, and Linux platforms. It will provide full functionality for students to discover services, submit applications, manage documents, track progress, and communicate with service providers.

### 1.3 Target Audience

- Students seeking educational support services
- International applicants to universities
- Domestic students requiring specialized educational services

### 1.4 Business Objectives

- Provide an intuitive, accessible interface for service discovery
- Enable secure document submission and management
- Facilitate clear communication between students and providers
- Support offline usage for low-connectivity environments
- Deliver a consistent experience across multiple devices and platforms

---

## 2. Architecture Overview

### 2.1 Clean Architecture

The application will implement a clean architecture pattern with distinct layers:

#### 2.1.1 Domain Layer

- **Entities**: Core business models that represent key concepts (User, Service, Request, Document)
- **Use Cases**: Business logic operations independent of UI or external dependencies
- **Repository Interfaces**: Abstract definitions of data operations

#### 2.1.2 Data Layer

- **Repositories**: Implementations of repository interfaces that coordinate data from different sources
- **Data Sources**: Implementations for remote API access and local storage
- **DTOs**: Data Transfer Objects for serialization/deserialization

#### 2.1.3 Presentation Layer

- **View Models**: State containers for UI components
- **UI Components**: Widgets for rendering the user interface
- **Event Handlers**: Processing user interactions

### 2.2 State Management with Riverpod

Riverpod will be used as the state management solution due to its advantages:

- **Provider Dependencies**: Automatic tracking of dependencies between providers
- **Family Modifiers**: Parameterized provider instances
- **AsyncValue**: Built-in handling of loading, error, and data states
- **Auto-disposal**: Automatic resource cleanup
- **Testability**: Easy mocking and dependency injection
- **Code Generation**: Reduced boilerplate with `riverpod_generator`

Key Riverpod patterns:

```
// Provider definitions
@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserProfile> build() => _fetchUserProfile();

  Future<void> updateProfile(ProfileUpdateRequest request) async {
    // Implementation
  }
}

// Provider usage
final userProfile = ref.watch(userProfileNotifierProvider);
```

### 2.3 Navigation Framework

The application will use Go Router for declarative routing:

- **Deep linking** support for external app launches
- **Path parameters** for dynamic routes
- **Nested navigation** for complex flows
- **Route guards** for authentication protection
- **Navigation history management**

### 2.4 Dependency Injection

A service locator pattern will be implemented alongside Riverpod for dependency injection:

- Core services registered at application startup
- Feature-specific dependencies provided through Riverpod providers
- Testing facilitated through easy dependency overrides

---

## 3. Offline-First Strategy

### 3.1 Data Persistence

#### 3.1.1 Local Database

- **Drift** (SQLite wrapper) for structured data storage
- Typed data access with code generation
- Complex query support
- Transaction support for data consistency

#### 3.1.2 Synchronization Strategy

- Bidirectional sync with conflict resolution
- Background synchronization when online
- Sync prioritization for critical data
- Sync status indicators for transparency

### 3.2 Offline Operations

#### 3.2.1 Queued Actions

- Persistent queue for operations requiring connectivity
- Automatic retry with exponential backoff
- Operation priority levels
- Conflict resolution strategies

#### 3.2.2 Content Caching

- Pre-fetching of likely needed content
- TTL-based cache expiration
- Size-limited caching with LRU eviction
- Partial updates to reduce bandwidth

### 3.3 Network Connectivity Management

- Connectivity monitoring and status display
- Graceful degradation of features when offline
- Bandwidth-aware operations (e.g., reduced image quality)
- Custom timeouts for different operation types

---

## 4. Cross-Platform Considerations

### 4.1 Platform Support Matrix

| Feature            | Android | iOS | Windows | macOS | Linux |
| ------------------ | ------- | --- | ------- | ----- | ----- |
| Core Functionality | ✓       | ✓   | ✓       | ✓     | ✓     |
| Push Notifications | ✓       | ✓   | ✓       | ✓     | ⚠️    |
| File System Access | ✓       | ✓   | ✓       | ✓     | ✓     |
| Biometric Auth     | ✓       | ✓   | ✓       | ✓     | ⚠️    |
| Deep Linking       | ✓       | ✓   | ✓       | ✓     | ✓     |
| Camera Access      | ✓       | ✓   | ✓       | ✓     | ✓     |

### 4.2 Responsive Design Strategy

- **Adaptive layouts** using LayoutBuilder and MediaQuery
- **Orientation support** for both portrait and landscape
- **Input adaptations** for touch vs. keyboard/mouse
- **Window resizing** support for desktop platforms
- **Safe area management** for different device geometries

### 4.3 Platform-Specific Considerations

#### 4.3.1 Android

- Material Design 3 components
- Adaptive icon support
- Android 13+ themed icons
- Permission request flows
- Back gesture handling

#### 4.3.2 iOS

- Cupertino design elements where appropriate
- iOS accessibility integration
- Apple authentication
- App tracking transparency

#### 4.3.3 Desktop (Windows, macOS, Linux)

- Window management
- Menu bar integration
- Keyboard shortcuts
- Drag and drop support
- High-precision pointer interactions

---

## 5. UI/UX Design System

### 5.1 Design Philosophy

The UniConnect design system emphasizes:

- **Clarity**: Clear information hierarchy and readability
- **Efficiency**: Minimal steps to accomplish tasks
- **Trust**: Design that promotes security and confidence
- **Accessibility**: Inclusive design for all users
- **Cultural Sensitivity**: Appropriate for international users

### 5.2 Color System

#### 5.2.1 Primary Palette

| Color         | Hex     | Usage                             |
| ------------- | ------- | --------------------------------- |
| Primary       | #2563EB | Main brand color, primary actions |
| Primary Dark  | #1E40AF | Hover states, emphasis            |
| Primary Light | #DBEAFE | Backgrounds, highlights           |
| Secondary     | #10B981 | Success states, completion        |
| Accent        | #F59E0B | Attention, calls to action        |
| Error         | #EF4444 | Errors, destructive actions       |

#### 5.2.2 Neutral Palette

| Color           | Hex     | Usage                       |
| --------------- | ------- | --------------------------- |
| Background      | #FFFFFF | Main surfaces               |
| Surface         | #F3F4F6 | Cards, elevated surfaces    |
| On Primary      | #FFFFFF | Text on primary colors      |
| High Emphasis   | #111827 | Primary text                |
| Medium Emphasis | #4B5563 | Secondary text              |
| Low Emphasis    | #9CA3AF | Disabled text, placeholders |
| Divider         | #E5E7EB | Subtle separators           |

#### 5.2.3 Dark Mode Variants

Complete set of dark mode alternatives with proper contrast ratios.

### 5.3 Typography

#### 5.3.1 Font Families

- **Primary**: Inter (Latin, Cyrillic)
- **Arabic**: Cairo
- **Persian**: Vazirmatn
- **Fallback**: System font stack

#### 5.3.2 Type Scale

| Style      | Weight | Size | Line Height | Usage                  |
| ---------- | ------ | ---- | ----------- | ---------------------- |
| Heading 1  | 700    | 28px | 1.2         | Main screen titles     |
| Heading 2  | 700    | 24px | 1.2         | Section headers        |
| Heading 3  | 600    | 20px | 1.3         | Card titles, dialogs   |
| Subtitle   | 600    | 16px | 1.4         | Section subheaders     |
| Body       | 400    | 16px | 1.5         | Primary content        |
| Body Small | 400    | 14px | 1.5         | Secondary content      |
| Caption    | 400    | 12px | 1.4         | Supporting information |
| Button     | 600    | 16px | 1.0         | Interactive elements   |

### 5.4 Component Library

#### 5.4.1 Buttons

**Primary Button**

- Background: Primary
- Text: On Primary
- Height: 48px
- Corner radius: 8px
- States: Normal, Hover, Pressed, Loading, Disabled

**Secondary Button**

- Border: Primary
- Text: Primary
- Background: Transparent
- States: Normal, Hover, Pressed, Disabled

**Text Button**

- Text: Primary
- No background or border
- States: Normal, Hover, Pressed, Disabled

#### 5.4.2 Input Fields

**Text Input**

- Height: 56px
- Border: 1px Divider (normal state)
- Corner radius: 8px
- Error state: 1px Error border
- Focus state: 2px Primary border
- Label animation: Float from center to top on focus/content

**Dropdown/Select**

- Appearance matching Text Input
- Custom dropdown overlay with smooth animation
- Support for option groups
- Search capability for long lists

#### 5.4.3 Cards

**Standard Card**

- Background: Surface
- Corner radius: 12px
- Elevation: Subtle shadow (0px 2px 8px rgba(0,0,0,0.05))
- Padding: 16px

**Interactive Card**

- Standard Card +
- Hover state: Slight scale (1.02)
- Pressed state: Inset shadow

#### 5.4.4 Navigation

**Bottom Navigation Bar**

- 5 item maximum
- Active indication with icon fill + label
- Badge support for notifications
- Adaptive to safe areas

**Tab Bar**

- Sliding indicator for active tab
- Scrolling support for many tabs
- Dynamic width based on content

**Navigation Drawer**

- Persistent on tablets/desktop
- Modal on phones
- Header with user information
- Hierarchical navigation support

#### 5.4.5 Feedback Components

**Toast Messages**

- Duration: 3 seconds (configurable)
- Action button support
- Multiple queuing behavior
- Position: Bottom center (mobile), bottom right (desktop)

# UniConnect Mobile Application: Technical Specification Document

## 1. Executive Summary

The UniConnect Mobile Application serves as the primary interface for students seeking educational support services. This document provides comprehensive technical specifications, design guidelines, and implementation strategies for the Flutter-based cross-platform application targeting iOS, Android, macOS, Windows, and Linux platforms.

## 2. Application Architecture

### 2.1 Clean Architecture Overview

The application follows a clean architecture pattern with strict separation of concerns:

![Clean Architecture Diagram]

```
Client Application Structure
├── lib/
│   ├── core/                # Core utilities and shared functionality
│   │   ├── constants/       # App-wide constant values
│   │   ├── errors/          # Error handling and exception models
│   │   ├── network/         # Network connectivity and API client
│   │   ├── theme/           # Theme data and styling
│   │   └── utils/           # Utility functions
│   ├── domain/              # Business logic and entities
│   │   ├── entities/        # Core business models
│   │   ├── repositories/    # Abstract repository interfaces
│   │   └── usecases/        # Business use cases
│   ├── data/                # Data handling implementation
│   │   ├── datasources/     # Remote and local data sources
│   │   ├── models/          # Data models (DTOs)
│   │   └── repositories/    # Repository implementations
│   ├── presentation/        # UI components
│   │   ├── common_widgets/  # Reusable UI components
│   │   ├── screens/         # Application screens
│   │   ├── providers/       # Riverpod providers
│   │   └── routes/          # Navigation routes
│   ├── l10n/                # Localization resources
│   └── main.dart            # Application entry point
```

### 2.2 Layer Responsibilities

#### 2.2.1 Domain Layer

- Contains pure business logic, independent of any framework
- Defines entities representing core business objects
- Specifies repository interfaces
- Implements use cases that orchestrate business flows
- Has no dependencies on other layers

#### 2.2.2 Data Layer

- Implements repository interfaces from domain layer
- Handles data fetching, parsing, and storage
- Manages API communication and local persistence
- Transforms between DTOs and domain entities
- Implements caching strategies for offline functionality

#### 2.2.3 Presentation Layer

- Manages UI state through Riverpod providers
- Contains screen widgets and navigation logic
- Handles user input and events
- Consumes use cases from domain layer
- Implements responsive UI for different screen sizes

## 3. State Management with Riverpod

### 3.1 Riverpod Implementation

The application uses Riverpod (version 2.x) for state management with the following provider types:

#### 3.1.1 Provider Types

- **Provider**: For simple immutable values and dependencies
- **StateProvider**: For simple state that can be mutated directly
- **StateNotifierProvider**: For complex state with controlled mutations
- **FutureProvider**: For asynchronous values loaded once
- **StreamProvider**: For reactive data streams
- **ChangeNotifierProvider**: Used sparingly for legacy integrations

### 3.2 State Persistence

For preserving application state across sessions:

- **Riverpod Persistence**: Integration with `riverpod_persistence` for automatic state restoration
- **Hydrated Storage**: Custom implementation for selectively persisting provider states
- **State Synchronization**: Mechanisms to reconcile local state with server state

## 4. Offline-First Implementation

### 4.1 Local Data Storage

- **Drift/Moor**: SQL-based local database for structured data
- **Hive**: NoSQL storage for document-based data
- **Secure Storage**: For sensitive information like authentication tokens

### 4.2 Synchronization Strategy

1. **Optimistic Updates**: Update UI immediately while sending changes to server
2. **Background Sync**: Queue failed operations for retry when connectivity returns
3. **Conflict Resolution**: Strategy for handling server-client data conflicts:
   - Client-wins: Local changes override server changes
   - Server-wins: Server data takes precedence
   - Last-write-wins: Most recent update is preserved
   - Manual resolution: User prompted to resolve conflicts

### 4.4 Offline Operations Queue

## 5. UI/UX Design System

### 5.1 Design System Components

#### 5.1.1 Colors

Primary palette:

- **Primary Color**: #1E88E5 (Blue)
- **Primary Light**: #6AB7FF
- **Primary Dark**: #005CB2
- **Secondary Color**: #FF6D00 (Orange)
- **Secondary Light**: #FF9E40
- **Secondary Dark**: #C43C00
- **Background**: #FFFFFF
- **Surface**: #F5F5F5
- **Error**: #B00020

Semantic colors:

- **Success**: #4CAF50
- **Info**: #2196F3
- **Warning**: #FB8C00
- **Dark Text**: #212121 (87% opacity)
- **Medium Text**: #424242 (60% opacity)
- **Light Text**: #757575 (38% opacity)

#### 5.1.2 Typography

Font families:

- **Primary**: Roboto
- **Secondary**: Open Sans
- **Arabic**: Cairo
- **Persian**: Vazir

Text styles:

- **Headline 1**: 96px, Light, -1.5 letter spacing
- **Headline 2**: 60px, Light, -0.5 letter spacing
- **Headline 3**: 48px, Regular, 0 letter spacing
- **Headline 4**: 34px, Regular, 0.25 letter spacing
- **Headline 5**: 24px, Regular, 0 letter spacing
- **Headline 6**: 20px, Medium, 0.15 letter spacing
- **Subtitle 1**: 16px, Regular, 0.15 letter spacing
- **Subtitle 2**: 14px, Medium, 0.1 letter spacing
- **Body 1**: 16px, Regular, 0.5 letter spacing
- **Body 2**: 14px, Regular, 0.25 letter spacing
- **Button**: 14px, Medium, 1.25 letter spacing, all caps
- **Caption**: 12px, Regular, 0.4 letter spacing
- **Overline**: 10px, Regular, 1.5 letter spacing, all caps

#### 5.1.3 Component Library

1. **Buttons**:

   - Primary Button
   - Secondary Button
   - Text Button
   - Icon Button
   - Floating Action Button

2. **Input Controls**:

   - Text Field
   - Dropdown
   - Checkbox
   - Radio Button
   - Toggle Switch
   - Date Picker
   - File Upload

3. **Navigation**:

   - Bottom Navigation Bar
   - Tabs
   - Drawer
   - App Bar
   - Navigation Rail (desktop)
   - Breadcrumbs

4. **Content Containers**:

   - Cards
   - Lists
   - Expansion Panels
   - Dividers
   - Chips

5. **Feedback Components**:
   - Progress Indicators
   - Snackbars
   - Dialogs
   - Tooltips
   - Skeleton Loaders

### 5.2 Implementation Strategy

The design system will be implemented using:

1. **ThemeData**: Flutter's built-in theming system
2. **Custom Components**: Extension of Flutter widgets with consistent styling
3. **Design Tokens**: Extraction of values to constants for consistency
4. **Responsive Layouts**: Adaptable UI for different screen sizes
5. **Accessibility**: Support for screen readers, high contrast modes, and text scaling

## 6. Navigation and Routing

### 6.1 Routing Architecture

The application uses GoRouter for declarative routing with the following features:

- Path-based navigation
- Deep linking support
- Nested navigation
- Route guards for authentication
- Transition animations

### 6.2 Screen Transitions

Custom transitions between screens based on platform conventions:

- iOS: Horizontal slide transitions
- Android: Material transitions
- Desktop: Fade transitions

### 6.3 Deep Linking

Support for deep links to specific content:

- Universal links (iOS)
- App links (Android)
- Custom URL scheme
- Dynamic links for sharing

## 7. API Integration

### 7.1 API Client

Implementation of a robust API client with:

- Authentication header injection
- Request/response interceptors
- Error handling
- Retry logic
- Timeout management

### 7.2 Error Handling Strategy

A centralized error handling strategy with:

- Error categorization (network, authentication, validation, server)
- User-friendly error messages
- Error reporting to monitoring systems
- Retry mechanisms for transient failures

```dart
class AppError {
  final ErrorType type;
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppError({
    required this.type,
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  String getUserFriendlyMessage() {
    switch (type) {
      case ErrorType.network:
        return 'Please check your internet connection and try again.';
      case ErrorType.authentication:
        return 'Your session has expired. Please login again.';
      case ErrorType.validation:
        return 'There was a problem with the submitted information.';
      case ErrorType.server:
        return 'We\'re experiencing server issues. Please try again later.';
      case ErrorType.unknown:
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}

enum ErrorType {
  network,
  authentication,
  validation,
  server,
  unknown,
}

class ErrorHandler {
  final ErrorReportingService _reportingService;

  ErrorHandler(this._reportingService);

  AppError handleError(dynamic error) {
    // Convert various error types to AppError
    if (error is DioError) {
      return _handleDioError(error);
    }

    // Handle other error types

    // Default case
    return AppError(
      type: ErrorType.unknown,
      message: 'An unexpected error occurred',
      originalError: error,
    );
  }

  AppError _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return AppError(
          type: ErrorType.network,
          message: 'Connection timed out',
          originalError: error,
        );
      case DioErrorType.response:
        // Handle different status codes
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return AppError(
            type: ErrorType.authentication,
            message: 'Authentication required',
            code: 'AUTH_REQUIRED',
            originalError: error,
          );
        } else if (statusCode == 400) {
          return AppError(
            type: ErrorType.validation,
            message: 'Validation error',
            code: 'VALIDATION_ERROR',
            originalError: error,
          );
        } else if (statusCode != null && statusCode >= 500) {
          return AppError(
            type: ErrorType.server,
            message: 'Server error',
            code: 'SERVER_ERROR',
            originalError: error,
          );
        }
        break;
      case DioErrorType.cancel:
        return AppError(
          type: ErrorType.unknown,
          message: 'Request was cancelled',
          originalError: error,
        );
      case DioErrorType.other:
        if (error.error is SocketException) {
          return AppError(
            type: ErrorType.network,
            message: 'No internet connection',
            originalError: error,
          );
        }
        break;
      default:
        break;
    }

    // Default case
    return AppError(
      type: ErrorType.unknown,
      message: error.message,
      originalError: error,
    );
  }

  Future<void> reportError(AppError error) async {
    await _reportingService.reportError(
      error.message,
      error.originalError,
      error.stackTrace,
    );
  }
}
```

## 8. Local Data Persistence

### 8.1 Database Structure

Using Drift (formally Moor) for structured data storage:

### 8.2 Secure Storage

Implementation for sensitive information:

### 8.3 File Storage

Management of locally stored files:

## 9. Multi-platform Implementation

### 9.1 Responsive Design

Implementation of responsive layouts using:

- LayoutBuilder for widget-level responsiveness
- MediaQuery for screen-level information
- Adaptive widgets for platform-specific behavior
- Custom breakpoint system for different screen sizes

### 9.2 Platform-Specific Implementations

Strategy for handling platform differences:

- Platform detection for conditional logic
- Platform-specific UI components when needed
- Feature detection for capability differences
- Graceful degradation for unsupported features

### 9.3 Desktop Features

Enhanced functionality for desktop platforms:

- Keyboard shortcuts
- Mouse hover effects
- Context menus
- Drag and drop
- Window management
- File system integration

## 10. Performance Optimization

### 10.1 Image Optimization

Strategies for efficient image handling:

- Cached network images
- Progressive loading
- Resolution-appropriate assets
- Lazy loading
- Memory management

### 10.2 List Optimization

Techniques for efficient list rendering:

- Virtualized lists with ListView.builder
- Pagination for large data sets
- Optimized list item rebuilds
- Caching of list data

### 10.3 Memory Management

Techniques for efficient memory usage:

- Image caching policies
- Object pooling for frequent allocations
- Dispose pattern implementation
- Stream subscription management
- Garbage collection hints

### 10.4 BuildContext Optimization

Strategies to minimize unnecessary rebuilds:

- const constructors
- Selective state updates
- Memoization of expensive computations
- Extension methods for common operations

## 11. Internationalization

### 11.1 Localization Setup

Implementation of localization

### 11.2 RTL Support

Implementation of right-to-left text direction support:

- Directionality widgets
- Text alignment
- Margin and padding adjustments
- Icon mirroring
- Widget order flipping

### 11.3 Language Selection

User interface for language selection and persistence:

- Language picker in settings
- Automatic detection of system language
- Fallback to default language if translation is missing
- Language change persistence across sessions

## 12. Testing Strategy

### 12.1 Unit Testing

### 12.2 Widget Testing

### 12.3 Integration Testing

### 12.4 Performance Testing

## 13. Deployment Pipeline

### 13.1 Build Configurations

### 13.2 CI/CD Configuration

Example GitHub Actions workflow:

```yaml
name: Flutter Build and Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    name: Test and Analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.10.0'
          channel: 'stable'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test

  build-android:
    name: Build Android APK
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.10.0'
          channel: 'stable'
      - uses: actions/setup-java@v2
        with:
          distribution: 'zulu'
          java-version: '11'
      - run: flutter pub get
      - run: flutter build apk --flavor production --dart-define=FLAVOR=production
      - uses: actions/upload-artifact@v3
        with:
          name: android-release
          path: build/app/outputs/flutter-apk/app-production-release.apk

  build-ios:
    name: Build iOS IPA
    needs: test
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.10.0'
          channel: 'stable'
      - run: flutter pub get
      - run: flutter build ios --no-codesign --flavor production --dart-define=FLAVOR=production
      # Additional steps for code signing and IPA generation
```

### 13.3 App Store Deployment

Fastlane configuration for iOS deployment:

```ruby
# Fastfile example
default_platform(:ios)

platform :ios do
  desc "Push a new release build to TestFlight"
  lane :beta do
    build_app(
      workspace: "ios/Runner.xcworkspace",
      scheme: "production",
      export_method: "app-store"
    )
    upload_to_testflight
  end

  desc "Push a new release build to the App Store"
  lane :release do
    build_app(
      workspace: "ios/Runner.xcworkspace",
      scheme: "production",
      export_method: "app-store"
    )
    upload_to_app_store(
      submit_for_review: true,
      automatic_release: true,
      force: true
    )
  end
end
```

### 13.4 Play Store Deployment

Fastlane configuration for Android deployment:

```ruby
# Fastfile example
default_platform(:android)

platform :android do
  desc "Deploy to Play Store Beta track"
  lane :beta do
    gradle(
      task: "clean assembleRelease",
      build_type: "Release",
      flavor: "production",
      properties: {
        "android.injected.signing.store.file" => ENV["KEYSTORE_PATH"],
        "android.injected.signing.store.password" => ENV["STORE_PASSWORD"],
        "android.injected.signing.key.alias" => ENV["KEY_ALIAS"],
        "android.injected.signing.key.password" => ENV["KEY_PASSWORD"],
      }
    )
    upload_to_play_store(
      track: "beta",
      aab: "../build/app/outputs/bundle/productionRelease/app-production-release.aab"
    )
  end

  desc "Deploy to Play Store Production track"
  lane :release do
    gradle(
      task: "clean bundleRelease",
      build_type: "Release",
      flavor: "production",
      properties: {
        "android.injected.signing.store.file" => ENV["KEYSTORE_PATH"],
        "android.injected.signing.store.password" => ENV["STORE_PASSWORD"],
        "android.injected.signing.key.alias" => ENV["KEY_ALIAS"],
        "android.injected.signing.key.password" => ENV["KEY_PASSWORD"],
      }
    )
    upload_to_play_store(
      track: "production",
      aab: "../build/app/outputs/bundle/productionRelease/app-production-release.aab"
    )
  end
end
```

## 14. Conclusion

The UniConnect Flutter application provides a comprehensive, cross-platform solution for students seeking educational support services. By implementing clean architecture patterns, optimized performance strategies, and a robust offline-first approach, the application delivers a seamless user experience across mobile and desktop platforms.

The detailed design system ensures consistency in user experience while supporting multilingual interfaces, including right-to-left languages. The testing strategy and deployment pipeline ensure high-quality releases and efficient delivery to all target platforms.

This technical specification document serves as the foundation for development, ensuring all team members understand the architecture, design decisions, and implementation strategies for the UniConnect client application.

## Appendices

### Appendix A: Third-Party Libraries

- **State Management**: flutter_riverpod
- **Navigation**: go_router
- **Local Database**: drift (moor)
- **API Client**: dio
- **Secure Storage**: flutter_secure_storage
- **Image Handling**: cached_network_image
- **Internationalization**: flutter_localizations
- **Form Handling**: reactive_forms
- **UI Components**: flutter_widgets
- **Testing**: mockito, integration_test

### Appendix B: Development Environment Setup

1. Install Flutter SDK (latest stable version)
2. Configure platform development tools:
   - Android Studio for Android development
   - Xcode for iOS development
   - Visual Studio Code with Flutter extensions
3. Clone repository and install dependencies:
   ```
   git clone https://github.com/uniconnect/mobile-app.git
   cd mobile-app
   flutter pub get
   ```
4. Configure environment variables for different flavors
5. Run the application in development mode:
   ```
   flutter run --flavor development --dart-define=FLAVOR=development
   ```

### Appendix C: Design System Assets

- **Figma Design Files**:
