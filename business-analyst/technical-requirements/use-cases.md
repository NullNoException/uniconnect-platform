# UniConnect Platform Use Cases

## 1. Student Use Cases

### 1.1 Account Management

#### UC-1.1.1: Student Registration

- **Actor**: Student
- **Description**: Student creates a new account on the platform
- **Preconditions**: None
- **Main Flow**:
  1. Student navigates to registration page
  2. Student selects "Create Account"
  3. Student enters email, password, personal information, and selects student account type
  4. System validates input and checks for duplicate accounts
  5. System sends verification email
  6. Student verifies email address by clicking link
  7. System creates verified user account with Student role
  8. System redirects to profile completion page
- **Alternative Flows**:
  - A1: Student registers using social media account
  - A2: Email verification fails
  - A3: Student abandons registration process
- **Postconditions**: Student has a verified account on the platform
- **Business Rules**:
  - Password must meet complexity requirements
  - Email must be unique in the system
  - Account remains limited until email verification is complete

#### UC-1.1.2: Student Profile Completion

- **Actor**: Student
- **Description**: Student completes their profile with educational details
- **Preconditions**: Student has a verified account
- **Main Flow**:
  1. Student navigates to profile section
  2. Student adds/edits personal information
  3. Student adds current/previous education details
  4. Student specifies target education goals and preferred countries
  5. Student uploads profile picture
  6. Student sets communication preferences
  7. System saves profile information
- **Alternative Flows**:
  - A1: Student skips certain optional fields
  - A2: Student uploads invalid file format for profile picture
- **Postconditions**: Student has a complete profile
- **Business Rules**:
  - Profile pictures must be less than 5MB
  - Certain fields are mandatory for profile completion

#### UC-1.1.3: Student Account Settings Management

- **Actor**: Student
- **Description**: Student manages account settings and preferences
- **Preconditions**: Student is logged in
- **Main Flow**:
  1. Student navigates to account settings
  2. Student can update password
  3. Student can set preferred language (English, Arabic, Farsi)
  4. Student can configure notification preferences
  5. Student can manage connected social accounts
  6. Student can set privacy preferences
  7. System saves settings changes
- **Alternative Flows**:
  - A1: Password change requires current password verification
- **Postconditions**: Student account settings are updated
- **Business Rules**:
  - Password changes require confirmation email
  - Language preference affects all system communications

### 1.2 Service Discovery

#### UC-1.2.1: Browse Service Categories

- **Actor**: Student
- **Description**: Student browses available service categories
- **Preconditions**: Student is logged in
- **Main Flow**:
  1. Student navigates to service directory
  2. System displays hierarchical category structure
  3. Student selects category of interest
  4. System displays services within selected category
  5. Student can filter results by various criteria
- **Alternative Flows**:
  - A1: No services available in selected category
- **Postconditions**: Student views services in selected category
- **Business Rules**:
  - Only verified services are displayed
  - Featured services appear at the top

#### UC-1.2.2: Search for Services

- **Actor**: Student
- **Description**: Student searches for specific services
- **Preconditions**: Student is logged in
- **Main Flow**:
  1. Student enters search keywords in search bar
  2. System returns matching services
  3. Student applies filters (university, price range, rating, etc.)
  4. Student sorts results by relevance, price, or rating
  5. System refines displayed results based on filters and sorting
- **Alternative Flows**:
  - A1: No results match search criteria
  - A2: Student uses advanced search options
- **Postconditions**: Student views search results
- **Business Rules**:
  - Search covers service names, descriptions, and keywords
  - Results prioritize keyword matches in title over description

#### UC-1.2.3: View Service Details

- **Actor**: Student
- **Description**: Student views detailed information about a service
- **Preconditions**: Student is logged in
- **Main Flow**:
  1. Student selects a service from search results or browsing
  2. System displays comprehensive service information
  3. Student reviews provider credentials, pricing, and delivery timeframes
  4. Student views ratings and reviews
  5. Student can see sample work if available
- **Alternative Flows**:
  - A1: Student saves service to favorites
- **Postconditions**: Student has viewed service details
- **Business Rules**:
  - Service page shows average rating and review count
  - Price is displayed in student's preferred currency

### 1.3 Service Engagement

#### UC-1.3.1: Contact Service Provider

- **Actor**: Student
- **Description**: Student initiates communication with provider
- **Preconditions**: Student is logged in and viewing a service
- **Main Flow**:
  1. Student clicks "Contact Provider" on service details page
  2. System displays messaging interface
  3. Student composes and sends inquiry
  4. System delivers message to provider
  5. System creates conversation record in database
- **Alternative Flows**:
  - A1: Student includes attachments in message
- **Postconditions**: Message is sent to provider
- **Business Rules**:
  - Students cannot contact suspended providers
  - Message content is scanned for prohibited content

#### UC-1.3.2: Request Service Quote

- **Actor**: Student
- **Description**: Student requests custom quote for a service
- **Preconditions**: Student is logged in and viewing a service
- **Main Flow**:
  1. Student clicks "Request Quote" button
  2. System displays quote request form
  3. Student provides required details about their needs
  4. Student submits quote request
  5. System notifies provider of quote request
  6. Provider receives request and can respond with custom quote
- **Alternative Flows**:
  - A1: Student abandons quote request
- **Postconditions**: Quote request is sent to provider
- **Business Rules**:
  - Quote requests expire after 7 days if not answered
  - Students can have maximum 10 active quote requests

#### UC-1.3.3: Submit Service Application

- **Actor**: Student
- **Description**: Student applies for a service
- **Preconditions**: Student is logged in and viewing a service
- **Main Flow**:
  1. Student clicks "Apply" button on service
  2. System displays application form with service requirements
  3. Student fills in required information
  4. Student uploads required documents (school reports, diploma, passport, etc.)
  5. Student reviews application details
  6. Student submits application
  7. System creates service request record
  8. System notifies provider of new application
- **Alternative Flows**:
  - A1: Student saves application as draft
  - A2: Student uploads invalid document format
- **Postconditions**: Service application is submitted
- **Business Rules**:
  - All required documents must be provided
  - Documents must be in approved formats (PDF, JPG, PNG)
  - Document size limit of 10MB per file

### 1.4 Payment Processing

#### UC-1.4.1: Make Service Payment

- **Actor**: Student
- **Description**: Student makes payment for a service
- **Preconditions**: Student has submitted service application
- **Main Flow**:
  1. Student reviews service cost and details
  2. Student selects payment method (credit card, bank transfer, PayPal, cryptocurrency)
  3. System displays payment form for selected method
  4. Student enters payment details
  5. System processes payment through payment gateway
  6. System places funds in escrow
  7. System updates service request status
  8. System notifies provider of payment
- **Alternative Flows**:
  - A1: Payment processing fails
  - A2: Student cancels during payment
  - A3: Student selects offline payment method
- **Postconditions**: Payment is processed and held in escrow
- **Business Rules**:
  - All payments are held in escrow until service completion
  - Platform fee is calculated based on service type and amount
  - Multiple currency support with real-time conversion

#### UC-1.4.2: Track Escrow Status

- **Actor**: Student
- **Description**: Student tracks the status of funds in escrow
- **Preconditions**: Student has paid for a service
- **Main Flow**:
  1. Student navigates to order details
  2. System displays payment information including escrow status
  3. Student can view payment history and transaction details
  4. System shows estimated release date for escrowed funds
- **Alternative Flows**:
  - A1: Student requests refund for unopened service request
- **Postconditions**: Student has viewed escrow information
- **Business Rules**:
  - Escrow status changes with service status
  - Full transaction history is maintained

### 1.5 Service Monitoring

#### UC-1.5.1: Track Service Progress

- **Actor**: Student
- **Description**: Student monitors the progress of their service request
- **Preconditions**: Student has an active service request
- **Main Flow**:
  1. Student navigates to "My Services" section
  2. Student selects specific service request
  3. System displays current status and progress indicators
  4. Student views timeline of service milestones
  5. Student can see estimated completion date
- **Alternative Flows**:
  - A1: Service is delayed beyond estimated completion
- **Postconditions**: Student has viewed service progress
- **Business Rules**:
  - Status updates require provider confirmation
  - Automatic notifications sent for status changes

#### UC-1.5.2: Communicate During Service Fulfillment

- **Actor**: Student
- **Description**: Student communicates with provider during service fulfillment
- **Preconditions**: Student has an active service request
- **Main Flow**:
  1. Student navigates to service request details
  2. Student opens messaging interface
  3. Student composes and sends message regarding the service
  4. System delivers message to provider
  5. Provider can respond to message
  6. Messages are logged in the service request history
- **Alternative Flows**:
  - A1: Student uploads additional documents
  - A2: Student responds to provider queries
- **Postconditions**: Communication is logged in service record
- **Business Rules**:
  - All communications are recorded for dispute resolution
  - File attachments are allowed in service-related messages

#### UC-1.5.3: Receive Service Updates

- **Actor**: Student
- **Description**: Student receives updates about service progress
- **Preconditions**: Student has an active service request
- **Main Flow**:
  1. Provider updates service status or milestone
  2. System generates notification for student
  3. System sends notification via preferred channels (in-app, email, WhatsApp, Telegram)
  4. Student receives and views notification
  5. Student can access service request to see detailed update
- **Alternative Flows**:
  - A1: Student has disabled certain notification channels
- **Postconditions**: Student is informed of service progress
- **Business Rules**:
  - Critical updates are sent through all available channels
  - Notification frequency is configurable

### 1.6 Service Completion

#### UC-1.6.1: Review Completed Service

- **Actor**: Student
- **Description**: Student reviews completed service deliverables
- **Preconditions**: Provider has marked service as complete
- **Main Flow**:
  1. Student receives completion notification
  2. Student navigates to service request details
  3. Student reviews final deliverables and documents
  4. Student can download or view all submitted materials
  5. Student decides to accept completion or request revisions
- **Alternative Flows**:
  - A1: Student requests revisions
  - A2: Student does not respond within timeframe
- **Postconditions**: Student has reviewed deliverables
- **Business Rules**:
  - Student has 7 days to review before automatic acceptance
  - Maximum 3 revision requests allowed per service

#### UC-1.6.2: Accept Service Completion

- **Actor**: Student
- **Description**: Student accepts service as complete
- **Preconditions**: Student has reviewed completed service
- **Main Flow**:
  1. Student clicks "Accept Completion" button
  2. System displays confirmation dialog
  3. Student confirms acceptance
  4. System updates service request status to completed
  5. System notifies administrator to release escrow
  6. System prompts student to provide review
- **Alternative Flows**:
  - A1: Student declines to provide review
- **Postconditions**: Service is marked as complete
- **Business Rules**:
  - Escrow release requires admin approval
  - Service warranty period begins after acceptance

#### UC-1.6.3: Rate and Review Service

- **Actor**: Student
- **Description**: Student rates and reviews completed service
- **Preconditions**: Student has accepted service completion
- **Main Flow**:
  1. Student navigates to completed service
  2. System displays rating and review form
  3. Student provides star rating for different aspects
  4. Student writes review text
  5. Student can upload photos of results (optional)
  6. Student submits review
  7. System publishes review after moderation
- **Alternative Flows**:
  - A1: Student edits review within allowed timeframe
- **Postconditions**: Service is rated and reviewed
- **Business Rules**:
  - Reviews can be edited within 30 days
  - Provider can respond to reviews
  - Fake or inappropriate reviews will be removed

## 2. Provider Use Cases

### 2.1 Account Management

#### UC-2.1.1: Provider Registration

- **Actor**: Service Provider
- **Description**: Provider creates a new account on the platform
- **Preconditions**: None
- **Main Flow**:
  1. Provider navigates to registration page
  2. Provider selects "Create Provider Account"
  3. Provider enters company information, email, password
  4. System validates input and checks for duplicate accounts
  5. System sends verification email
  6. Provider verifies email address
  7. System creates unverified provider account
  8. System prompts for verification documents
- **Alternative Flows**:
  - A1: Provider abandons registration process
- **Postconditions**: Provider has an unverified account
- **Business Rules**:
  - Providers cannot list services until verified
  - Company name must be unique in the system

#### UC-2.1.2: Provider Verification

- **Actor**: Service Provider
- **Description**: Provider completes verification process
- **Preconditions**: Provider has an unverified account
- **Main Flow**:
  1. Provider navigates to verification section
  2. Provider uploads required business documents
  3. Provider completes business profile
  4. Provider submits verification request
  5. System notifies administrators of pending verification
  6. Administrators review verification request
  7. System updates provider status to verified
  8. System notifies provider of verification approval
- **Alternative Flows**:
  - A1: Verification request is rejected
  - A2: Additional documents are requested
- **Postconditions**: Provider is verified and can list services
- **Business Rules**:
  - Verification requires specific business documentation
  - Verification expires after 1 year and must be renewed

#### UC-2.1.3: Staff Account Management

- **Actor**: Provider Administrator
- **Description**: Provider manages staff accounts
- **Preconditions**: Provider is verified
- **Main Flow**:
  1. Provider admin navigates to staff management section
  2. Provider admin can add new staff members with email
  3. System sends invitation to staff email
  4. Staff member creates account with provider association
  5. Provider admin assigns roles and permissions to staff
  6. Provider admin can edit or deactivate staff accounts
- **Alternative Flows**:
  - A1: Staff invitation expires
  - A2: Staff account is suspended
- **Postconditions**: Staff accounts are managed
- **Business Rules**:
  - Number of staff accounts depends on subscription plan
  - Staff permissions are inherited from assigned roles

### 2.2 Service Management

#### UC-2.2.1: Create Service Listing

- **Actor**: Service Provider
- **Description**: Provider creates a new service listing
- **Preconditions**: Provider is verified
- **Main Flow**:
  1. Provider navigates to service management section
  2. Provider selects "Create New Service"
  3. Provider enters service details (name, description, category)
  4. Provider sets pricing information
  5. Provider defines service requirements and deliverables
  6. Provider uploads service images or examples
  7. Provider submits service for approval
  8. System notifies administrators of pending service
- **Alternative Flows**:
  - A1: Provider saves service as draft
  - A2: Service is rejected during approval
- **Postconditions**: New service is created and pending approval
- **Business Rules**:
  - Services require admin approval before being public
  - Service descriptions must meet minimum content requirements

#### UC-2.2.2: Manage University Programs

- **Actor**: Service Provider
- **Description**: Provider manages university program offerings
- **Preconditions**: Provider is verified
- **Main Flow**:
  1. Provider navigates to university program section
  2. Provider can add/select universities they work with
  3. Provider can define academic levels for each university
  4. Provider can add majors/programs for each academic level
  5. Provider sets tuition fees for each program
  6. Provider configures service pricing for each program by semester
  7. System saves program configurations
- **Alternative Flows**:
  - A1: Provider imports program data via Excel
  - A2: Provider exports program data to Excel
- **Postconditions**: University programs are configured
- **Business Rules**:
  - Program pricing must be updated each semester
  - Universities must exist in system database before selection

#### UC-2.2.3: Update Service Listing

- **Actor**: Service Provider
- **Description**: Provider updates existing service listing
- **Preconditions**: Provider has existing services
- **Main Flow**:
  1. Provider navigates to service management section
  2. Provider selects service to edit
  3. Provider updates service details
  4. Provider submits updated service
  5. System flags major changes for admin review
  6. System updates service listing
- **Alternative Flows**:
  - A1: Provider deactivates service temporarily
  - A2: Major changes require admin approval
- **Postconditions**: Service listing is updated
- **Business Rules**:
  - Price increases over 20% require admin approval
  - Service category changes require admin approval

### 2.3 Application Management

#### UC-2.3.1: Receive Student Application

- **Actor**: Service Provider
- **Description**: Provider receives and reviews student application
- **Preconditions**: Student has submitted application
- **Main Flow**:
  1. System notifies provider of new application
  2. Provider navigates to applications dashboard
  3. Provider reviews application details and documents
  4. Provider accepts or rejects application
  5. System notifies student of application decision
- **Alternative Flows**:
  - A1: Provider requests additional information
  - A2: Provider proposes modified service terms
- **Postconditions**: Application is processed
- **Business Rules**:
  - Applications must be processed within 48 hours
  - Rejections require providing a reason

#### UC-2.3.2: Process Service Request

- **Actor**: Service Provider
- **Description**: Provider processes an accepted service request
- **Preconditions**: Provider has accepted application and payment is in escrow
- **Main Flow**:
  1. Provider updates service status to "In Progress"
  2. Provider performs required service work
  3. Provider updates service milestones as completed
  4. Provider communicates with student as needed
  5. Provider uploads interim deliverables if applicable
  6. Provider marks service as complete when finished
  7. System notifies student of completion
- **Alternative Flows**:
  - A1: Provider requests deadline extension
  - A2: Provider requires additional information from student
- **Postconditions**: Service request is processed to completion
- **Business Rules**:
  - Milestone updates must include progress notes
  - Completion requires all deliverables to be uploaded

#### UC-2.3.3: Handle Revision Requests

- **Actor**: Service Provider
- **Description**: Provider processes revision requests from student
- **Preconditions**: Student has requested revisions
- **Main Flow**:
  1. Provider receives revision request notification
  2. Provider reviews requested changes
  3. Provider makes necessary revisions
  4. Provider uploads revised deliverables
  5. Provider marks revisions as complete
  6. System notifies student of completed revisions
- **Alternative Flows**:
  - A1: Provider declines certain revision requests
  - A2: Provider requests clarification on revisions
- **Postconditions**: Revisions are completed
- **Business Rules**:
  - Revisions must be completed within original service terms
  - Excessive revisions may require additional payment

### 2.4 Financial Management

#### UC-2.4.1: View Earnings and Transactions

- **Actor**: Service Provider
- **Description**: Provider views earnings and transaction history
- **Preconditions**: Provider is logged in
- **Main Flow**:
  1. Provider navigates to financial dashboard
  2. System displays summary of earnings, pending payments, and completed transactions
  3. Provider can filter transactions by date, status, or service
  4. Provider can view detailed breakdown of platform fees
  5. Provider can export transaction records
- **Alternative Flows**:
  - A1: Provider views dispute history
- **Postconditions**: Provider has viewed financial information
- **Business Rules**:
  - Earnings are calculated after platform fees
  - Transaction history is retained for 7 years

#### UC-2.4.2: Manage Payment Methods

- **Actor**: Service Provider
- **Description**: Provider configures payment reception methods
- **Preconditions**: Provider is verified
- **Main Flow**:
  1. Provider navigates to payment settings
  2. Provider adds/edits bank account information
  3. Provider configures alternative payment methods (PayPal, cryptocurrency)
  4. Provider sets default payment method
  5. System validates and saves payment methods
- **Alternative Flows**:
  - A1: Payment method validation fails
- **Postconditions**: Payment methods are configured
- **Business Rules**:
  - At least one payment method is required
  - Payment methods require verification

#### UC-2.4.3: Receive Escrow Payments

- **Actor**: Service Provider
- **Description**: Provider receives released escrow payments
- **Preconditions**: Admin has approved escrow release
- **Main Flow**:
  1. System processes escrow release
  2. System transfers funds to provider's account
  3. System generates payment receipt
  4. System notifies provider of payment
  5. Provider can view updated balance and transaction
- **Alternative Flows**:
  - A1: Payment processing encounters delay
- **Postconditions**: Provider receives payment
- **Business Rules**:
  - Platform fees are deducted automatically
  - Payment processing time depends on payment method

## 3. Admin Use Cases

### 3.1 Provider Management

#### UC-3.1.1: Verify Provider

- **Actor**: Administrator
- **Description**: Admin verifies a provider registration
- **Preconditions**: Provider has submitted verification request
- **Main Flow**:
  1. Admin navigates to provider verification queue
  2. Admin selects provider to review
  3. Admin reviews business information and documents
  4. Admin approves or rejects verification
  5. Admin adds notes to provider record
  6. System updates provider status and notifies provider
- **Alternative Flows**:
  - A1: Admin requests additional documentation
- **Postconditions**: Provider verification status is updated
- **Business Rules**:
  - Verification requires checking against business registries
  - Verified status is applied immediately upon approval

#### UC-3.1.2: Monitor Provider Performance

- **Actor**: Administrator
- **Description**: Admin reviews provider performance metrics
- **Preconditions**: Provider is active on platform
- **Main Flow**:
  1. Admin navigates to provider management section
  2. Admin selects provider to review
  3. System displays performance metrics (completion rate, ratings, response time)
  4. Admin reviews customer feedback and disputes
  5. Admin can contact provider about performance issues
- **Alternative Flows**:
  - A1: Admin places provider on probation
  - A2: Admin suspends provider for violations
- **Postconditions**: Provider performance is reviewed
- **Business Rules**:
  - Providers below performance thresholds receive warnings
  - Three warnings may result in suspension

### 3.2 Service Management

#### UC-3.2.1: Approve Service Listing

- **Actor**: Administrator
- **Description**: Admin reviews and approves service listings
- **Preconditions**: Provider has submitted service for approval
- **Main Flow**:
  1. Admin navigates to service approval queue
  2. Admin selects service to review
  3. Admin reviews service details, pricing, and requirements
  4. Admin approves or rejects service listing
  5. System updates service status and notifies provider
- **Alternative Flows**:
  - A1: Admin requests modifications before approval
- **Postconditions**: Service listing status is updated
- **Business Rules**:
  - Services must comply with platform policies
  - Services in restricted categories require additional review

#### UC-3.2.2: Manage Service Categories

- **Actor**: Administrator
- **Description**: Admin manages service category taxonomy
- **Preconditions**: Admin is logged in
- **Main Flow**:
  1. Admin navigates to category management
  2. Admin can create new categories or subcategories
  3. Admin can edit category names and descriptions
  4. Admin can merge or split categories
  5. Admin can deactivate categories
  6. System updates category structure
- **Alternative Flows**:
  - A1: Admin moves services between categories
- **Postconditions**: Category structure is updated
- **Business Rules**:
  - Category changes affect service visibility
  - Categories cannot be deleted if they contain services

### 3.3 Financial Management

#### UC-3.3.1: Release Escrow Payment

- **Actor**: Administrator
- **Description**: Admin approves release of escrow funds
- **Preconditions**: Student has accepted service completion
- **Main Flow**:
  1. Admin navigates to escrow management
  2. Admin reviews completed service details
  3. Admin verifies service delivery and student acceptance
  4. Admin approves escrow release
  5. System processes payment to provider
  6. System records transaction details
- **Alternative Flows**:
  - A1: Admin holds payment pending dispute resolution
- **Postconditions**: Escrow payment is released
- **Business Rules**:
  - Escrow release requires verification of completion
  - Platform fees are automatically calculated

#### UC-3.3.2: Manage Refunds and Disputes

- **Actor**: Administrator
- **Description**: Admin handles refund requests and disputes
- **Preconditions**: Student or provider has raised dispute
- **Main Flow**:
  1. Admin navigates to dispute management
  2. Admin reviews dispute details and communication history
  3. Admin communicates with both parties as needed
  4. Admin makes determination on dispute
  5. Admin processes full or partial refund if warranted
  6. System updates transaction records and notifies parties
- **Alternative Flows**:
  - A1: Admin offers compromise solution
  - A2: Admin escalates to senior management
- **Postconditions**: Dispute is resolved
- **Business Rules**:
  - Disputes must be resolved within 14 days
  - Partial refunds are calculated based on delivery stage

### 3.4 System Management

#### UC-3.4.1: Configure Platform Settings

- **Actor**: Administrator
- **Description**: Admin configures global platform settings
- **Preconditions**: Admin has system configuration access
- **Main Flow**:
  1. Admin navigates to system configuration
  2. Admin can update fee structures and commission rates
  3. Admin can configure service workflows
  4. Admin can modify notification templates
  5. Admin can set platform policies
  6. System applies and stores configuration changes
- **Alternative Flows**:
  - A1: Admin schedules changes for future date
- **Postconditions**: Platform settings are updated
- **Business Rules**:
  - Some settings changes require senior approval
  - Configuration history is maintained for auditing

#### UC-3.4.2: Manage University Data

- **Actor**: Administrator
- **Description**: Admin manages university database
- **Preconditions**: Admin has university management access
- **Main Flow**:
  1. Admin navigates to university management
  2. Admin can add new universities with details
  3. Admin can update university information
  4. Admin can add/edit academic levels and majors
  5. Admin can review provider-university relationships
  6. System stores updated university data
- **Alternative Flows**:
  - A1: Admin imports university data in bulk
  - A2: Admin verifies university information
- **Postconditions**: University data is updated
- **Business Rules**:
  - Universities must be verified before appearing in system
  - Academic program structures follow standardized format

## 4. Integration Use Cases

### 4.1 Communication Channels

#### UC-4.1.1: Send Email Notification

- **Actor**: System
- **Description**: System sends email notification to user
- **Preconditions**: Notification event is triggered
- **Main Flow**:
  1. System generates notification content
  2. System checks user notification preferences
  3. System formats email using appropriate template
  4. System sends email through email service
  5. System records notification delivery attempt
- **Alternative Flows**:
  - A1: Email delivery fails
  - A2: User has opted out of email notifications
- **Postconditions**: Email notification is sent
- **Business Rules**:
  - Emails use user's preferred language
  - Critical notifications are sent regardless of preferences

#### UC-4.1.2: Send WhatsApp/Telegram Notification

- **Actor**: System
- **Description**: System sends notification via WhatsApp or Telegram
- **Preconditions**: User has linked WhatsApp/Telegram account
- **Main Flow**:
  1. System generates notification content
  2. System checks user notification preferences
  3. System formats message for messaging platform
  4. System sends message through appropriate API
  5. System records notification delivery attempt
- **Alternative Flows**:
  - A1: Messaging API unavailable
  - A2: User has unlinked messaging account
- **Postconditions**: Messaging notification is sent
- **Business Rules**:
  - Message formatting follows platform requirements
  - User must opt-in specifically for messaging notifications

### 4.2 Payment Processing

#### UC-4.2.1: Process Credit Card Payment

- **Actor**: System
- **Description**: System processes credit card payment
- **Preconditions**: Student has selected credit card payment
- **Main Flow**:
  1. System collects credit card details
  2. System sends payment request to payment gateway
  3. Payment gateway processes transaction
  4. System receives transaction confirmation
  5. System records payment details
  6. System updates service request status
- **Alternative Flows**:
  - A1: Payment gateway declines transaction
  - A2: Network error during processing
- **Postconditions**: Credit card payment is processed
- **Business Rules**:
  - Credit card details are not stored on platform
  - Failed transactions trigger retry options

#### UC-4.2.2: Process Cryptocurrency Payment

- **Actor**: System
- **Description**: System processes cryptocurrency payment
- **Preconditions**: Student has selected cryptocurrency payment
- **Main Flow**:
  1. System generates cryptocurrency payment address
  2. System displays payment instructions to student
  3. System monitors address for incoming transaction
  4. System confirms transaction on blockchain
  5. System records payment details
  6. System updates service request status
- **Alternative Flows**:
  - A1: Transaction not received within timeframe
  - A2: Transaction received with incorrect amount
- **Postconditions**: Cryptocurrency payment is processed
- **Business Rules**:
  - Exchange rate is locked for specific time period
  - Minimum confirmations required before acceptance

## 5. Document Management Use Cases

### 5.1 Document Processing

#### UC-5.1.1: Upload Document

- **Actor**: Student or Provider
- **Description**: User uploads document to the platform
- **Preconditions**: User is logged in
- **Main Flow**:
  1. User navigates to document upload section
  2. User selects document type (passport, diploma, etc.)
  3. User selects file from their device
  4. System validates file format and size
  5. System scans file for malware
  6. System uploads file to storage
  7. System creates document record in database
- **Alternative Flows**:
  - A1: File validation fails
  - A2: Malware detected in file
- **Postconditions**: Document is uploaded and stored
- **Business Rules**:
  - Allowed file formats: PDF, JPG, PNG
  - Maximum file size: 10MB
  - Document types must match predefined categories

#### UC-5.1.2: Share Document

- **Actor**: Student or Provider
- **Description**: User shares document with another user
- **Preconditions**: User has uploaded document
- **Main Flow**:
  1. User navigates to document management
  2. User selects document to share
  3. User specifies recipient (associated with service request)
  4. User sets sharing permissions and duration
  5. System creates sharing record
  6. System notifies recipient of shared document
- **Alternative Flows**:
  - A1: User revokes sharing access
- **Postconditions**: Document is shared with recipient
- **Business Rules**:
  - Documents can only be shared with users in active relationship
  - Sharing expires after service completion unless extended

#### UC-5.1.3: View Document

- **Actor**: Student or Provider
- **Description**: User views shared document
- **Preconditions**: Document has been shared with user
- **Main Flow**:
  1. User navigates to shared documents section
  2. User selects document to view
  3. System verifies access permissions
  4. System displays document in viewer
  5. System logs document access
- **Alternative Flows**:
  - A1: Access permissions have expired
  - A2: Document requires download for viewing
- **Postconditions**: User has viewed document
- **Business Rules**:
  - Document access is logged for security
  - Certain documents may be view-only without download option

## 6. Report and Analytics Use Cases

### 6.1 Analytics Dashboard

#### UC-6.1.1: View Provider Analytics

- **Actor**: Service Provider
- **Description**: Provider views performance analytics
- **Preconditions**: Provider is logged in
- **Main Flow**:
  1. Provider navigates to analytics dashboard
  2. System displays key performance metrics
  3. Provider can filter data by date range and service
  4. Provider can view trends in inquiries, conversions, and ratings
  5. Provider can export analytics data
- **Alternative Flows**:
  - A1: No data available for selected criteria
- **Postconditions**: Provider has viewed analytics
- **Business Rules**:
  - Analytics data is updated daily
  - Sensitive financial data is protected

#### UC-6.1.2: View Platform Analytics

- **Actor**: Administrator
- **Description**: Admin views platform-wide analytics
- **Preconditions**: Admin has analytics access
- **Main Flow**:
  1. Admin navigates to platform analytics dashboard
  2. System displays key platform metrics
  3. Admin can drill down by service category, provider, or region
  4. Admin can view financial performance and trends
  5. Admin can generate custom reports
- **Alternative Flows**:
  - A1: Admin exports data for external analysis
- **Postconditions**: Admin has viewed platform analytics
- **Business Rules**:
  - User data is anonymized in certain reports
  - Financial data access requires specific permissions
