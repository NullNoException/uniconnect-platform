# Business Requirements Document (BRD): UniConnect Admin Panel

## Document Information

- **Version**: 1.0
- **Date**: May 16, 2025
- **Author**: UniConnect Business Analysis Team

## Executive Summary

The UniConnect Admin Panel serves as the management interface for both platform administrators and service providers. It provides comprehensive tools to manage services, users, transactions, and platform policies. This document outlines the business requirements for the Admin Panel component of the UniConnect Educational Services Marketplace.

## Business Objectives

1. Provide system administrators with tools to manage the entire platform ecosystem
2. Enable service providers to efficiently manage their service offerings and customer interactions
3. Ensure compliance with regulatory requirements and platform policies
4. Generate insights through comprehensive reporting and analytics
5. Streamline operations through workflow automation and notifications
6. Support management of university programs and associated service pricing

## Stakeholders

- **Platform Administrators**: Responsible for overall platform management and policy enforcement
- **Service Providers**: Educational consultancies and independent consultants offering services
- **Customer Support Team**: Staff handling user inquiries and issue resolution
- **Finance Team**: Personnel managing payment processing and financial reporting
- **IT Operations**: Team responsible for platform technical operations
- **University Liaisons**: Staff who maintain relationships with partner universities

## Business Requirements

### 1. System Administration

#### 1.1 User Management

- **BR-1.1.1**: Administrators must be able to view, create, update, and disable user accounts
- **BR-1.1.2**: Administrators must be able to assign and modify user roles and permissions
- **BR-1.1.3**: Administrators must be able to view user activity logs for compliance purposes
- **BR-1.1.4**: Administrators must be able to manage organization-level access and permissions

#### 1.2 Service Category Management

- **BR-1.2.1**: Administrators must be able to create and manage service categories
- **BR-1.2.2**: Administrators must be able to set category-specific policies and requirements
- **BR-1.2.3**: Administrators must be able to feature or hide specific categories

#### 1.3 Provider Management

- **BR-1.3.1**: Administrators must be able to verify and approve service providers
- **BR-1.3.2**: Administrators must be able to review provider compliance documentation
- **BR-1.3.3**: Administrators must be able to suspend or terminate provider accounts
- **BR-1.3.4**: Administrators must be able to view provider performance metrics

#### 1.4 Content Moderation

- **BR-1.4.1**: Administrators must be able to review and approve/reject service listings
- **BR-1.4.2**: Administrators must be able to moderate user-generated content
- **BR-1.4.3**: Administrators must be able to set and enforce content policies

#### 1.5 System Configuration

- **BR-1.5.1**: Administrators must be able to configure platform-wide settings
- **BR-1.5.2**: Administrators must be able to manage payment gateways and fee structures
- **BR-1.5.3**: Administrators must be able to configure notification templates

### 2. Service Provider Portal

#### 2.1 Profile Management

- **BR-2.1.1**: Providers must be able to create and manage their organization profile
- **BR-2.1.2**: Providers must be able to manage team members and permissions
- **BR-2.1.3**: Providers must be able to upload and update compliance documentation
- **BR-2.1.4**: Providers must be able to manage their payment information

#### 2.2 Service Management

- **BR-2.2.1**: Providers must be able to create, update, and unpublish service listings
- **BR-2.2.2**: Providers must be able to set pricing, delivery timeframes, and service details
- **BR-2.2.3**: Providers must be able to customize service requirements and questionnaires
- **BR-2.2.4**: Providers must be able to define service delivery workflows

#### 2.3 Order Management

- **BR-2.3.1**: Providers must be able to view and manage customer orders
- **BR-2.3.2**: Providers must be able to update order status and track progress
- **BR-2.3.3**: Providers must be able to request additional information from customers
- **BR-2.3.4**: Providers must be able to deliver completed work through secure channels

#### 2.4 Customer Communication

- **BR-2.4.1**: Providers must be able to communicate with customers through the platform
- **BR-2.4.2**: Providers must be able to use message templates for common communications
- **BR-2.4.3**: Providers must be able to schedule and send notifications to customers

#### 2.5 Finance Management

- **BR-2.5.1**: Providers must be able to view earnings and payment history
- **BR-2.5.2**: Providers must be able to generate financial reports
- **BR-2.5.3**: Providers must be able to issue refunds and manage disputes
- **BR-2.5.4**: Providers must be able to view and download invoices and tax documents

#### 2.6 University Program Management

- **BR-2.6.1**: Providers must be able to add and manage universities they work with
- **BR-2.6.2**: Providers must be able to specify academic levels (bachelor's, master's, PhD) for each university
- **BR-2.6.3**: Providers must be able to add majors/programs offered by each university
- **BR-2.6.4**: Providers must be able to specify tuition fees for each university program
- **BR-2.6.5**: Providers must be able to set their service prices for each university program per semester
- **BR-2.6.6**: Providers must be able to activate or deactivate university program offerings
- **BR-2.6.7**: Providers must be able to import university program data via Excel spreadsheets
- **BR-2.6.8**: Providers must be able to export their university program data to Excel

### 3. Reporting and Analytics

#### 3.1 Business Intelligence

- **BR-3.1.1**: The system must provide analytics dashboards for administrators
- **BR-3.1.2**: The system must provide performance metrics for service providers
- **BR-3.1.3**: The system must enable custom report generation
- **BR-3.1.4**: The system must allow data export in multiple formats

#### 3.2 Compliance Reporting

- **BR-3.2.1**: The system must generate compliance reports for regulatory requirements
- **BR-3.2.2**: The system must track and report on policy violations
- **BR-3.2.3**: The system must maintain audit trails for sensitive operations

## Business Process Workflows

### Provider Verification Process

1. Provider submits registration and compliance documentation
2. Administrator reviews submission in admin panel
3. Administrator approves or rejects the application
4. System notifies provider of decision
5. If approved, provider gains access to service management functions

### Service Listing Approval

1. Provider creates new service listing
2. Listing enters moderation queue
3. Administrator reviews listing for policy compliance
4. Administrator approves, rejects, or requests changes
5. System notifies provider of decision
6. If approved, listing becomes visible to customers

### Order Fulfillment Process

1. Customer places order
2. Provider receives notification and accepts/rejects order
3. Provider updates order status as work progresses
4. Provider uploads completed deliverables
5. Customer reviews and accepts delivery or requests revisions
6. Upon acceptance, payment is released to provider

## Business Rules

- **Rule-1**: All service providers must be verified before publishing services
- **Rule-2**: Service fees are calculated as a percentage of the transaction value
- **Rule-3**: Providers cannot directly access customer personal information
- **Rule-4**: All financial transactions must be processed through the platform
- **Rule-5**: Communications between providers and customers must be recorded
- **Rule-6**: Document retention policies must comply with legal requirements
- **Rule-7**: Service providers can only manage universities and programs they are authorized to work with
- **Rule-8**: University program data must include the specific semester for which the pricing applies
- **Rule-9**: Service providers must keep program pricing current for each active semester
- **Rule-10**: When importing university data, validation must ensure all required fields are present and data formats are correct

## Assumptions and Constraints

### Assumptions

- Service providers have access to computers and reliable internet
- Providers can upload documents in common file formats
- Providers are proficient in basic computer operations

### Constraints

- System must comply with data protection regulations
- Payment processing must adhere to financial services regulations
- System must maintain high availability for international providers

## Glossary

- **Service Provider**: Educational consultancy or independent consultant offering services
- **Service Listing**: A specific educational service offered through the platform
- **Order**: A customer request for services that has been accepted by a provider
- **Compliance Documentation**: Legal and professional certification documents
