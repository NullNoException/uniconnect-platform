# Software Requirements Specification (SRS): UniConnect Customer App

## Document Information

- **Version**: 1.0
- **Date**: May 16, 2025
- **Author**: UniConnect Development Team

## 1. Introduction

### 1.1 Purpose

This Software Requirements Specification (SRS) document outlines the functional and non-functional requirements for the UniConnect Customer App. The application serves as the primary interface for students to discover and engage with educational services on the UniConnect platform.

### 1.2 Scope

The UniConnect Customer App encompasses:

- User registration and profile management
- Service discovery and evaluation
- Order placement and tracking
- Communication with service providers
- Review and feedback submission
- Community participation
- Help and support access

### 1.3 Definitions, Acronyms, and Abbreviations

- **API**: Application Programming Interface
- **BRD**: Business Requirements Document
- **CRUD**: Create, Read, Update, Delete
- **JWT**: JSON Web Token
- **SRS**: Software Requirements Specification
- **UI**: User Interface
- **UX**: User Experience

### 1.4 References

- UniConnect Customer App Business Requirements Document (BRD)
- UniConnect System Architecture Document
- Flutter Design Guidelines
- Material Design 3 Specification

### 1.5 Overview

The remaining sections of this document provide a detailed description of the Customer App functionality, interfaces, and quality requirements.

## 2. Overall Description

### 2.1 Product Perspective

The Customer App is a component of the broader UniConnect platform, which includes a Core API and an Admin Panel. It communicates with the Core API for all data operations and integrates with third-party services for payments, notifications, and other functionality.

### 2.2 Product Functions

Primary functions include:

- User authentication and profile management
- Service browsing, searching, and filtering
- Service details viewing and provider evaluation
- Order placement and tracking
- Secure messaging with service providers
- Review and rating submission
- Community engagement

### 2.3 User Classes and Characteristics

#### 2.3.1 University Students

Primary users of the application with varying levels of technical proficiency. They expect an intuitive, reliable, and secure platform for accessing educational services.

#### 2.3.2 Prospective Students

Users exploring educational services before university enrollment. They need clear information about available services.

#### 2.3.3 International Students

Users who may require language support and specialized services for international education.

### 2.4 Operating Environment

- Cross-platform application for iOS, Android, and web
- Support for various screen sizes from mobile to tablet
- Offline capabilities for essential functions
- Integration with mobile device features (camera, notifications, etc.)
- Compatibility with latest and previous OS versions

### 2.5 Design and Implementation Constraints

- Must be developed using Flutter framework
- Must follow material design principles
- Must support multiple languages
- Must comply with accessibility standards
- Must function on mid-range mobile devices

### 2.6 Assumptions and Dependencies

- Reliance on Core API for backend functionality
- Dependency on third-party services for payments
- Assumption of minimum device capabilities
- Dependency on push notification services

## 3. System Features

### 3.1 User Authentication

#### 3.1.1 User Registration

- **FR-3.1.1.1**: The system shall allow users to register using email and password
- **FR-3.1.1.2**: The system shall allow users to register using social media accounts
- **FR-3.1.1.3**: The system shall verify user email addresses
- **FR-3.1.1.4**: The system shall collect basic profile information during registration

#### 3.1.2 User Login

- **FR-3.1.2.1**: The system shall authenticate users via email/password
- **FR-3.1.2.2**: The system shall authenticate users via social login
- **FR-3.1.2.3**: The system shall support biometric authentication where available
- **FR-3.1.2.4**: The system shall implement secure session management
- **FR-3.1.2.5**: The system shall support password reset functionality

### 3.2 User Profile Management

#### 3.2.1 Profile Information

- **FR-3.2.1.1**: The system shall allow users to view and edit their profile information
- **FR-3.2.1.2**: The system shall allow users to upload a profile picture
- **FR-3.2.1.3**: The system shall allow users to add and verify their university affiliation
- **FR-3.2.1.4**: The system shall allow users to manage their areas of academic interest

#### 3.2.2 Account Settings

- **FR-3.2.2.1**: The system shall allow users to update their password
- **FR-3.2.2.2**: The system shall allow users to manage notification preferences
- **FR-3.2.2.3**: The system shall allow users to set privacy preferences
- **FR-3.2.2.4**: The system shall allow users to manage connected accounts

### 3.3 Service Discovery

#### 3.3.1 Browse and Search

- **FR-3.3.1.1**: The system shall display service categories and subcategories
- **FR-3.3.1.2**: The system shall provide a search function with keyword support
- **FR-3.3.1.3**: The system shall support filtering by multiple criteria
- **FR-3.3.1.4**: The system shall support sorting by relevance, rating, price, and date
- **FR-3.3.1.5**: The system shall implement pagination for search results

#### 3.3.2 Recommendations

- **FR-3.3.2.1**: The system shall display personalized service recommendations
- **FR-3.3.2.2**: The system shall show trending and popular services
- **FR-3.3.2.3**: The system shall recommend related services based on viewing history
- **FR-3.3.2.4**: The system shall allow users to save favorite services

### 3.4 Service Details

#### 3.4.1 Service Information

- **FR-3.4.1.1**: The system shall display comprehensive service descriptions
- **FR-3.4.1.2**: The system shall show service pricing and delivery information
- **FR-3.4.1.3**: The system shall display provider information and credentials
- **FR-3.4.1.4**: The system shall show service ratings and review summaries
- **FR-3.4.1.5**: The system shall display sample work or case studies when available

#### 3.4.2 Reviews and Ratings

- **FR-3.4.2.1**: The system shall display user reviews with ratings
- **FR-3.4.2.2**: The system shall allow filtering and sorting of reviews
- **FR-3.4.2.3**: The system shall indicate verified purchase reviews
- **FR-3.4.2.4**: The system shall show provider responses to reviews

### 3.5 Service Engagement

#### 3.5.1 Pre-Purchase Interaction

- **FR-3.5.1.1**: The system shall allow users to contact providers with questions
- **FR-3.5.1.2**: The system shall support scheduling consultations
- **FR-3.5.1.3**: The system shall enable service comparisons
- **FR-3.5.1.4**: The system shall provide service requirement details

#### 3.5.2 Order Placement

- **FR-3.5.2.1**: The system shall implement a shopping cart functionality
- **FR-3.5.2.2**: The system shall collect required information for service delivery
- **FR-3.5.2.3**: The system shall support application of promotional codes
- **FR-3.5.2.4**: The system shall integrate with payment processors
- **FR-3.5.2.5**: The system shall provide order confirmation

### 3.6 Order Management

#### 3.6.1 Order Tracking

- **FR-3.6.1.1**: The system shall display current and past orders
- **FR-3.6.1.2**: The system shall show order status and progress
- **FR-3.6.1.3**: The system shall provide estimated completion dates
- **FR-3.6.1.4**: The system shall notify users of status changes

#### 3.6.2 Order Interaction

- **FR-3.6.2.1**: The system shall enable messaging with providers about orders
- **FR-3.6.2.2**: The system shall allow users to provide additional information
- **FR-3.6.2.3**: The system shall support file uploads related to orders
- **FR-3.6.2.4**: The system shall allow users to approve or request revisions
- **FR-3.6.2.5**: The system shall facilitate dispute resolution if needed

### 3.7 Post-Service Activities

#### 3.7.1 Reviews and Feedback

- **FR-3.7.1.1**: The system shall prompt users to review completed services
- **FR-3.7.1.2**: The system shall allow users to rate services on multiple aspects
- **FR-3.7.1.3**: The system shall support written reviews with optional photos
- **FR-3.7.1.4**: The system shall allow users to edit their reviews

#### 3.7.2 Follow-up Engagement

- **FR-3.7.2.1**: The system shall suggest related or follow-up services
- **FR-3.7.2.2**: The system shall allow users to bookmark providers
- **FR-3.7.2.3**: The system shall support service reordering

### 3.8 Community Features

- **FR-3.8.1**: The system shall provide discussion forums by topic
- **FR-3.8.2**: The system shall allow users to share services with peers
- **FR-3.8.3**: The system shall support knowledge base contributions
- **FR-3.8.4**: The system shall implement moderation for user-generated content

### 3.9 Support and Help

- **FR-3.9.1**: The system shall provide searchable help documentation
- **FR-3.9.2**: The system shall offer in-app customer support chat
- **FR-3.9.3**: The system shall allow users to report issues
- **FR-3.9.4**: The system shall support ticket tracking for support requests

## 4. External Interface Requirements

### 4.1 User Interfaces

- **UI-4.1.1**: The app shall follow material design guidelines
- **UI-4.1.2**: The app shall adapt to different screen sizes and orientations
- **UI-4.1.3**: The app shall provide consistent navigation patterns
- **UI-4.1.4**: The app shall implement loading states and error feedback

### 4.2 Software Interfaces

- **SI-4.2.1**: The app shall communicate with the Core API via REST endpoints
- **SI-4.2.2**: The app shall integrate with payment processing services
- **SI-4.2.3**: The app shall connect to push notification services
- **SI-4.2.4**: The app shall integrate with social media platforms for sharing

### 4.3 Hardware Interfaces

- **HI-4.3.1**: The app shall access device camera for profile photos and document uploads
- **HI-4.3.2**: The app shall utilize device storage for offline data
- **HI-4.3.3**: The app shall interact with biometric sensors if available

### 4.4 Communications Interfaces

- **CI-4.4.1**: The app shall use HTTPS for all API communications
- **CI-4.4.2**: The app shall implement efficient data synchronization
- **CI-4.4.3**: The app shall handle varying network conditions gracefully

## 5. Non-Functional Requirements

### 5.1 Performance Requirements

- **NFR-5.1.1**: The app shall launch within 3 seconds on target devices
- **NFR-5.1.2**: The app shall respond to user interactions within 100ms
- **NFR-5.1.3**: The app shall load content lists within 2 seconds
- **NFR-5.1.4**: The app shall operate efficiently on devices with 3GB RAM

### 5.2 Safety Requirements

- **NFR-5.2.1**: The app shall prevent accidental data loss
- **NFR-5.2.2**: The app shall confirm before irreversible actions
- **NFR-5.2.3**: The app shall validate user inputs to prevent errors

### 5.3 Security Requirements

- **NFR-5.3.1**: The app shall securely store authentication tokens
- **NFR-5.3.2**: The app shall encrypt sensitive local data
- **NFR-5.3.3**: The app shall implement certificate pinning
- **NFR-5.3.4**: The app shall detect jailbroken or rooted devices
- **NFR-5.3.5**: The app shall enforce session timeouts for security

### 5.4 Software Quality Attributes

- **NFR-5.4.1**: The app shall achieve 99.5% crash-free sessions
- **NFR-5.4.2**: The app shall maintain UI responsiveness during background operations
- **NFR-5.4.3**: The app shall function correctly after OS updates
- **NFR-5.4.4**: The app shall provide clear error messages and recovery options

### 5.5 Usability Requirements

- **NFR-5.5.1**: The app shall comply with WCAG 2.1 AA accessibility standards
- **NFR-5.5.2**: The app shall support multiple languages
- **NFR-5.5.3**: The app shall provide instructional hints for first-time users
- **NFR-5.5.4**: The app shall maintain consistency across all platforms

## 6. Other Requirements

### 6.1 Offline Capabilities

- **OR-6.1.1**: The app shall cache critical data for offline access
- **OR-6.1.2**: The app shall queue actions performed offline for later synchronization
- **OR-6.1.3**: The app shall indicate online/offline status to users

### 6.2 Localization

- **OR-6.2.1**: The app shall support multiple languages
- **OR-6.2.2**: The app shall adapt to local date, time, and currency formats

### 6.3 Analytics and Monitoring

- **OR-6.3.1**: The app shall track user engagement metrics
- **OR-6.3.2**: The app shall report crashes and exceptions
- **OR-6.3.3**: The app shall monitor performance metrics

## Appendix A: Glossary

[List of terms and definitions]

## Appendix B: Analysis Models

[Reference to wireframes, user flows, etc.]

## Appendix C: Issues List

[Known issues and considerations]
