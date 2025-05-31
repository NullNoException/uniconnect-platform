---
applyTo: '**/*.dart'
---

Coding standards, domain knowledge, and preferences that AI should follow.
Instructions for Building a Multi-Platform Flutter App
This document outlines a comprehensive approach to developing a Flutter application that supports web, Android, iOS, tablet, and desktop platforms, incorporating RTL/LTR, multilingual capabilities, a clean architecture, and Riverpod for state management. The focus is on descriptive text prompts rather than executable code.

1. Project Setup & Configuration
   Initialize Project: Start a new Flutter project, ensuring it's configured for multi-platform development from the outset. This involves using the flutter create command, which by default sets up Android and iOS.

Enable Platforms: Explicitly enable web, Windows, macOS, and Linux desktop support using Flutter configuration commands. This prepares the project structure for building on these additional platforms.

Dependency Management: Define and add essential packages to your pubspec.yaml file. Key dependencies include flutter_riverpod for state management, flutter_localizations and intl for internationalization, and a robust routing solution like go_router for deep linking and web URL handling. Consider device_info_plus for platform-specific checks and responsive_builder for simplifying responsive UI development.

2. Clean Architecture Implementation
   Adopt a clean architecture to ensure your application is modular, testable, and maintainable across different platforms. This involves structuring your codebase into distinct, independent layers.

Folder Structure: Organize your lib directory into logical sections:

core/: For shared utilities, common models, constants, and base classes for error handling and use cases.

features/: This will contain separate modules for each major feature (e.g., authentication, user profiles, product catalog). Each feature module will further be divided into data, domain, and presentation layers.

main.dart: The main entry point of your application.

Layers Description:

Domain Layer: This is the innermost layer, containing the core business logic. It should be entirely independent of any framework, database, or UI.

Entities: Define the core business objects and data structures.

Abstract Repositories: Declare abstract interfaces for data operations. These define what data operations are needed, not how they are performed.

Use Cases (Interactors): Encapsulate specific business rules or actions. Each use case represents a single, well-defined operation that orchestrates data flow between the presentation and data layers.

Data Layer: This layer is responsible for implementing the data operations defined in the domain layer. It handles external data sources.

Data Sources: Implementations for fetching data from remote APIs, local databases, or device storage (e.g., shared preferences).

Concrete Repositories: Implement the abstract repository interfaces from the domain layer. These repositories coordinate data retrieval from various data sources and map it to domain entities.

Presentation Layer: This is the outermost layer, dealing with the user interface and user interactions.

Widgets/Pages: The actual UI components and screens that users interact with.

Riverpod Providers: Manage the state of the UI. These providers will interact with use cases from the domain layer to trigger business logic and update the UI.

3. Riverpod State Management
   Utilize Riverpod for robust and compile-time safe state management, integrating it seamlessly with your clean architecture.

Provider Types: Employ various Riverpod provider types based on your state's complexity:

Provider: For immutable, read-only values.

StateProvider: For simple, mutable pieces of state.

StateNotifierProvider: For managing complex state logic, typically paired with a StateNotifier class. This is ideal for encapsulating business logic related to UI state.

FutureProvider/StreamProvider: For handling asynchronous data operations and their loading/error states.

Integration with Architecture:

UI Interaction: Your UI widgets in the presentation layer will use ref.watch, ref.read, or ref.listen to react to state changes exposed by Riverpod providers.

Business Logic Invocation: The Riverpod providers (especially StateNotifierProviders) will serve as the bridge between the UI and the domain layer. They will call the appropriate use cases to execute business logic and then update their internal state, which in turn updates the UI.

StateNotifier Classes: Create dedicated StateNotifier classes within your presentation layer to manage the state for specific UI components or features. These classes will expose methods that trigger use cases and update the state based on the results.

4. Multilingual & RTL/LTR Support
   Implement comprehensive internationalization (i18n) and localization (l10n) to support multiple languages and text directions.

Core Libraries: Leverage Flutter's built-in flutter_localizations package and the intl package for generating localization artifacts.

Configuration File: Create an l10n.yaml file at the root of your project to configure the localization process, specifying the directory for ARB files and the template file.

ARB Files: Create separate .arb (Application Resource Bundle) files for each language in a designated directory (e.g., lib/l10n). Each file will contain key-value pairs for localized strings, including metadata for context. Ensure you have a base language file (e.g., app_en.arb) and corresponding files for other languages (e.g., app_ar.arb for Arabic).

App Integration: Configure your MaterialApp (or CupertinoApp) in main.dart by providing localizationsDelegates and supportedLocales. Flutter automatically generates the necessary delegates and locale lists based on your ARB files.

RTL/LTR Handling: Flutter inherently handles Directionality based on the active locale. For custom widgets or layouts that need to adapt explicitly, use Directionality.of(context) to query the current text direction and adjust elements accordingly (e.g., mirroring icons or layout order).

Usage: Access localized strings throughout your application using the generated AppLocalizations class, typically via AppLocalizations.of(context)!.yourStringKey.

5. Responsive Design for All Platforms
   Design your user interface to adapt seamlessly across various screen sizes, resolutions, and orientations, from small mobile phones to large desktop monitors.

Fundamental Layout Widgets: Utilize Flutter's powerful layout widgets:

MediaQuery: To obtain global screen information like size, orientation, and pixel density.

LayoutBuilder: To get the constraints of a parent widget, allowing you to build different UI sub-trees based on available space.

FractionallySizedBox: For sizing widgets as a percentage of their parent's available space.

Expanded and Flexible: Essential for creating flexible spacing within Row and Column layouts.

GridView: For displaying collections of items in a responsive grid format.

CustomScrollView with Sliver widgets: For highly customized and performant scrolling experiences that adapt to content and screen size.

Defining Breakpoints: Establish clear breakpoints (e.g., specific pixel widths) to categorize different screen types (mobile, tablet, desktop). This allows you to apply different UI logic or widget compositions based on the current screen size.

Adaptive UI Patterns:

Master-Detail Flow: Implement a pattern where a list (master) and its corresponding detail view are displayed side-by-side on larger screens (tablets, desktops), while on smaller screens (mobile), navigation occurs between the master list and the detail view.

Navigation Adapting: Use Drawer for mobile and potentially tablet interfaces, and consider NavigationBar (bottom navigation) for mobile or NavigationRail / custom side navigation for tablet and desktop layouts.

Text Scaling: Adjust font sizes dynamically to ensure readability on both small and large displays.

Conditional Rendering: Show or hide specific widgets or entire UI sections based on the detected platform or screen size.

Helper Packages: Consider using packages like responsive_builder which provides widgets like ScreenTypeLayout to simplify conditional UI rendering based on screen size, or flutter_screenutil for more precise pixel-based scaling (use with caution to avoid overly rigid designs).

6. Platform-Specific Code (If Necessary)
   When a feature requires direct interaction with native platform capabilities not exposed by Flutter's core framework, implement platform-specific code.

Platform Channels: Utilize MethodChannel to establish communication between your Dart code and native platform code (Kotlin/Java for Android, Swift/Objective-C for iOS, C++/C# for desktop). This allows you to invoke native methods from Dart and receive results.

Federated Plugins: For more complex or reusable platform-specific functionalities, consider structuring your code as a federated plugin. This separates the platform-agnostic Dart API from platform-specific implementations.

Conditional Execution: Use kIsWeb from flutter/foundation.dart to check if the app is running on the web, or Platform.isAndroid, Platform.isIOS, etc., from dart:io to determine the mobile or desktop operating system. This allows you to conditionally import or execute code relevant to a specific platform.

7. Testing Strategy
   Implement a comprehensive testing strategy to ensure the quality, reliability, and correct behavior of your application across all supported platforms.

Unit Tests: Focus on testing individual functions, classes, and business logic components, particularly within your domain and data layers, in isolation.

Widget Tests: Verify the correct rendering and behavior of your UI widgets in the presentation layer. These tests simulate user interactions and assert on the visual output and state changes.

Integration Tests: Test the entire flow of a feature, from user interaction with the UI through the business logic and data layers, ensuring all components work together as expected.

Golden Tests: For visual regression testing, capture "golden" images of your UI components and compare them against future renders to detect unintended visual changes.

8. Deployment Considerations
   Plan for the deployment of your application to various platforms, understanding the unique requirements of each.

Web Deployment: Build your web application using flutter build web. Configure your web server (e.g., Nginx, Apache, Firebase Hosting) to correctly serve the Flutter single-page application (SPA) by redirecting all unknown paths to index.html.

Mobile Deployment (Android/iOS): Follow the standard procedures for publishing to the Google Play Store and Apple App Store, including signing, bundling, and submitting your app.

Desktop Deployment: Build native executables for Windows, macOS, and Linux using flutter build windows, flutter build macos, and flutter build linux respectively. Prepare the necessary installers or distribution packages for each operating system.

CI/CD Pipelines: Set up Continuous Integration/Continuous Deployment (CI/CD) pipelines using services like GitHub Actions, GitLab CI/CD, or Codemagic. These pipelines will automate the building, testing, and deployment processes for all your target platforms, ensuring consistent and efficient releases.
