# Software Requirements Specification (SRS): UniConnect Admin Panel

I'll update the SRS document to align with the existing core-api code structure and provide detailed technical specifications.

## 1. Introduction

### 1.1 Purpose

This Software Requirements Specification (SRS) document describes the functional and non-functional requirements for the UniConnect Admin Panel. The admin panel serves as the management interface for platform administrators and service providers within the UniConnect Educational Services Marketplace.

### 1.2 Scope

The UniConnect Admin Panel encompasses two main components:

1. **System Administration Interface**: For platform administrators to manage all aspects of the marketplace
2. **Provider Portal**: For educational service providers to manage their services and customer interactions

The system integrates with the existing UniConnect Core API, which is built using .NET Core and follows a Clean Architecture approach.

## 2. System Architecture

### 2.1 Core API Architecture

The UniConnect Core API follows Clean Architecture principles with the following layers:

1. **Domain Layer**

   - Contains business entities and interfaces
   - Implements domain logic without dependencies on external frameworks

2. **Application Layer**

   - Implements CQRS pattern with Commands and Queries
   - Contains DTOs, validators and mappings
   - Handles business logic orchestration

3. **Infrastructure Layer**

   - Implements repositories, services, and external integrations
   - Manages database access through Entity Framework Core
   - Provides implementations for domain interfaces

4. **API Layer**
   - RESTful API controllers
   - Authentication/Authorization handling
   - Request validation
   - Response formatting

### 2.2 Database Architecture

The system uses PostgreSQL with Entity Framework Core as the ORM. The database is configured with the following key components:

1. **ApplicationDbContext**: Main database context that inherits from IdentityDbContext
2. **EntityConfigurations**: Fluent API configurations for all entities
3. **Migrations**: Entity Framework Core migrations for database versioning

## 3. Data Model

### 3.1 Core Entities

#### 3.1.1 User Entity

```
User {
  Id: Guid (PK)
  Email: string
  PasswordHash: string
  UserType: enum (Student, ServiceProvider, Admin)
  Status: enum (Pending, Active, Suspended, Inactive)
  LastLoginDate: DateTime?
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool
  LastModifiedDate: DateTime?
  LastModifiedBy: string?

  // Navigation properties
  Profile: UserProfile
  Student: Student
  ServiceProvider: ServiceProvider
  Admin: Admin
  Addresses: List<Address>
  PaymentMethods: List<PaymentMethod>
  CommunicationPreferences: List<CommunicationChannelPreference>
}
```

#### 3.1.2 UserProfile Entity

```
UserProfile {
  Id: Guid (PK)
  UserId: Guid (FK)
  FirstName: string
  LastName: string
  PhoneNumber: string?
  DateOfBirth: DateTime?
  ProfilePictureUrl: string?
  PreferredLanguage: string
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation property
  User: User

  // Computed property
  FullName: string
}
```

#### 3.1.3 ServiceProvider Entity

```
ServiceProvider {
  Id: Guid (PK)
  UserId: Guid (FK)
  CompanyName: string
  RegistrationNumber: string?
  VerificationStatus: enum
  VerifiedById: Guid?
  VerificationDate: DateTime?
  CompanyLogoUrl: string?
  CompanyWebsite: string?
  YearsInBusiness: int?
  SubscriptionPlanId: Guid?
  SubscriptionStartDate: DateTime?
  SubscriptionEndDate: DateTime?
  BillingAddressId: Guid?
  TaxIdentificationNumber: string?
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  User: User
  VerifiedBy: User?
  SubscriptionPlan: SubscriptionPlan?
  BillingAddress: Address?
  Staff: List<ProviderStaff>
  Services: List<Service>
}
```

#### 3.1.4 Service Entity

```
Service {
  Id: Guid (PK)
  ProviderId: Guid (FK)
  CategoryId: Guid (FK)
  ServiceName: string
  Description: string?
  ShortDescription: string?
  BasePrice: decimal
  CurrencyId: Guid (FK)
  EstimatedDeliveryDays: int?
  IsActive: bool
  FeaturedRank: int?
  ThumbnailUrl: string?
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  Provider: ServiceProvider
  Category: ServiceCategory
  Currency: Currency
  Attributes: List<ServiceAttribute>
  Requirements: List<ServiceRequirement>
  PriceComponents: List<ServicePriceComponent>
  Requests: List<ServiceRequest>
}
```

#### 3.1.5 ServiceRequest Entity

```
ServiceRequest {
  Id: Guid (PK)
  StudentId: Guid (FK)
  ServiceId: Guid (FK)
  RequestStatus: enum
  InitiatedDate: DateTime
  RequiredByDate: DateTime?
  CompletedDate: DateTime?
  CancelledDate: DateTime?
  CancellationReason: string?
  Notes: string?
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  Student: Student
  Service: Service
  Documents: List<RequestDocument>
  Milestones: List<RequestMilestone>
  Transactions: List<Transaction>
  Conversations: List<Conversation>
  Reviews: List<Review>
}
```

#### 3.1.6 Transaction Entity

```
Transaction {
  Id: Guid (PK)
  RequestId: Guid (FK)
  TransactionType: string
  Amount: decimal
  CurrencyId: Guid (FK)
  ExchangeRate: decimal?
  Status: string
  PaymentMethodId: Guid? (FK)
  PaymentGatewayTransactionId: string?
  EscrowReleaseDate: DateTime?
  PlatformFeeAmount: decimal
  ProviderAmount: decimal
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  Request: ServiceRequest
  Currency: Currency
  PaymentMethod: PaymentMethod?
}
```

#### 3.1.7 University Entity

```
University {
  Id: Guid (PK)
  Name: string
  CountryId: Guid (FK)
  AddressId: Guid (FK)
  Website: string
  Description: string
  LogoUrl: string
  IsActive: bool
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  Country: Country
  Address: Address
  Programs: List<UniversityProgram>
}
```

#### 3.1.8 AcademicLevel Entity

```
AcademicLevel {
  Id: Guid (PK)
  Name: string
  Description: string
  SortOrder: int
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  Programs: List<UniversityProgram>
}
```

#### 3.1.9 Major Entity

```
Major {
  Id: Guid (PK)
  Name: string
  Description: string
  FieldOfStudyId: Guid (FK)
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  FieldOfStudy: FieldOfStudy
  Programs: List<UniversityProgram>
}
```

#### 3.1.10 UniversityProgram Entity

```
UniversityProgram {
  Id: Guid (PK)
  UniversityId: Guid (FK)
  MajorId: Guid (FK)
  AcademicLevelId: Guid (FK)
  TuitionFee: decimal
  CurrencyId: Guid (FK)
  IsActive: bool
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  University: University
  Major: Major
  AcademicLevel: AcademicLevel
  Currency: Currency
  ProviderPrograms: List<ProviderUniversityProgram>
}
```

#### 3.1.11 Semester Entity

```
Semester {
  Id: Guid (PK)
  Name: string
  StartDate: DateTime
  EndDate: DateTime
  ApplicationDeadline: DateTime?
  IsActive: bool
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  ProviderPrograms: List<ProviderUniversityProgram>
}
```

#### 3.1.12 ProviderUniversityProgram Entity

```
ProviderUniversityProgram {
  Id: Guid (PK)
  ServiceProviderId: Guid (FK)
  UniversityProgramId: Guid (FK)
  SemesterId: Guid (FK)
  ServicePrice: decimal
  ServiceDescription: string
  IsActive: bool
  CreatedAt: DateTime
  CreatedBy: string
  UpdatedAt: DateTime?
  UpdatedBy: string?
  IsDeleted: bool

  // Navigation properties
  ServiceProvider: ServiceProvider
  UniversityProgram: UniversityProgram
  Semester: Semester
  Currency: Currency
}
```

### 3.2 Complete Entity Relationships

```mermaid
erDiagram
    User {
        Guid Id PK
        string Email
        string PasswordHash
        enum UserType
        enum Status
        DateTime LastLoginDate
        DateTime CreatedAt
        string CreatedBy
        DateTime UpdatedAt
        string UpdatedBy
        bool IsDeleted
        DateTime LastModifiedDate
        string LastModifiedBy
    }

    UserProfile {
        Guid Id PK
        Guid UserId FK
        string FirstName
        string LastName
        string PhoneNumber
        DateTime DateOfBirth
        string ProfilePictureUrl
        string PreferredLanguage
        DateTime CreatedAt
        string CreatedBy
        DateTime UpdatedAt
        string UpdatedBy
        bool IsDeleted
    }

    ServiceProvider {
        Guid Id PK
        Guid UserId FK
        string CompanyName
        string RegistrationNumber
        enum VerificationStatus
        Guid VerifiedById
        DateTime VerificationDate
        string CompanyLogoUrl
        string CompanyWebsite
        int YearsInBusiness
        Guid SubscriptionPlanId
        DateTime SubscriptionStartDate
        DateTime SubscriptionEndDate
        Guid BillingAddressId
        string TaxIdentificationNumber
        DateTime CreatedAt
        string CreatedBy
        DateTime UpdatedAt
        string UpdatedBy
        bool IsDeleted
    }

    Service {
        Guid Id PK
        Guid ProviderId FK
        Guid CategoryId FK
        string ServiceName
        string Description
        string ShortDescription
        decimal BasePrice
        Guid CurrencyId FK
        int EstimatedDeliveryDays
        bool IsActive
        int FeaturedRank
        string ThumbnailUrl
        DateTime CreatedAt
        string CreatedBy
        DateTime UpdatedAt
        string UpdatedBy
        bool IsDeleted
    }

    ServiceRequest {
        Guid Id PK
        Guid StudentId FK
        Guid ServiceId FK
        enum RequestStatus
        DateTime InitiatedDate
        DateTime RequiredByDate
        DateTime CompletedDate
        DateTime CancelledDate
        string CancellationReason
        string Notes
        DateTime CreatedAt
        string CreatedBy
        DateTime UpdatedAt
        string UpdatedBy
        bool IsDeleted
    }

    Transaction {
        Guid Id PK
        Guid RequestId FK
        string TransactionType
        decimal Amount
        Guid CurrencyId FK
        decimal ExchangeRate
        string Status
        Guid PaymentMethodId
        string PaymentGatewayTransactionId
        DateTime EscrowReleaseDate
        decimal PlatformFeeAmount
        decimal ProviderAmount
        DateTime CreatedAt
        string CreatedBy
        DateTime UpdatedAt
        string UpdatedBy
        bool IsDeleted
    }

    University {
        Guid Id PK
        string Name
        Guid CountryId FK
        Guid AddressId FK
        string Website
        string Description
        string LogoUrl
        bool IsActive
    }

    AcademicLevel {
        Guid Id PK
        string Name
        string Description
        int SortOrder
    }

    Major {
        Guid Id PK
        string Name
        string Description
        Guid FieldOfStudyId FK
    }

    UniversityProgram {
        Guid Id PK
        Guid UniversityId FK
        Guid MajorId FK
        Guid AcademicLevelId FK
        decimal TuitionFee
        Guid CurrencyId FK
        bool IsActive
    }

    Semester {
        Guid Id PK
        string Name
        DateTime StartDate
        DateTime EndDate
        DateTime ApplicationDeadline
        bool IsActive
    }

    ProviderUniversityProgram {
        Guid Id PK
        Guid ServiceProviderId FK
        Guid UniversityProgramId FK
        Guid SemesterId FK
        decimal ServicePrice
        string ServiceDescription
        bool IsActive
    }

    Address {
        Guid Id PK
        string Street
        string City
        string State
        string ZipCode
        string Country
    }

    PaymentMethod {
        Guid Id PK
        string Type
        string Provider
        string AccountNumber
        string Expiry
    }

    CommunicationChannelPreference {
        Guid Id PK
        string Channel
        bool IsEnabled
    }

    Student {
        Guid Id PK
        Guid UserId FK
    }

    Admin {
        Guid Id PK
        Guid UserId FK
    }

    RequestDocument {
        Guid Id PK
        Guid RequestId FK
        string DocumentUrl
    }

    RequestMilestone {
        Guid Id PK
        Guid RequestId FK
        string Milestone
        DateTime DueDate
    }

    Conversation {
        Guid Id PK
        Guid RequestId FK
    }

    Message {
        Guid Id PK
        Guid ConversationId FK
        string Content
    }

    Review {
        Guid Id PK
        Guid RequestId FK
        string Feedback
        int Rating
    }

    SubscriptionPlan {
        Guid Id PK
        string Name
        decimal Price
    }

    Currency {
        Guid Id PK
        string Code
        string Symbol
    }

    ServiceCategory {
        Guid Id PK
        string Name
    }

    ServiceAttribute {
        Guid Id PK
        Guid ServiceId FK
        string Key
        string Value
    }

    ServiceRequirement {
        Guid Id PK
        Guid ServiceId FK
        string Requirement
    }

    ServicePriceComponent {
        Guid Id PK
        Guid ServiceId FK
        string Name
        decimal Amount
    }

    ProviderStaff {
        Guid Id PK
        Guid ProviderId FK
        string Name
    }

    %% Relationships
    User ||--o| UserProfile : has
    User ||--o| ServiceProvider : "can be"
    User ||--o| Student : "can be"
    User ||--o| Admin : "can be"
    User ||--o{ Address : has
    User ||--o{ PaymentMethod : has
    User ||--o{ CommunicationChannelPreference : prefers

    ServiceProvider ||--o{ Service : offers
    ServiceProvider ||--o{ ProviderStaff : employs
    ServiceProvider ||--|| SubscriptionPlan : subscribes
    ServiceProvider ||--o| Address : bills_to

    Service ||--o{ ServiceRequest : requested_by
    Service ||--|| ServiceCategory : categorized_as
    Service ||--|| Currency : priced_in
    Service ||--o{ ServiceAttribute : has
    Service ||--o{ ServiceRequirement : requires
    Service ||--o{ ServicePriceComponent : includes

    ServiceRequest ||--|| Student : made_by
    ServiceRequest ||--|| Service : for
    ServiceRequest ||--o{ Transaction : pays
    ServiceRequest ||--o{ RequestDocument : includes
    ServiceRequest ||--o{ RequestMilestone : has
    ServiceRequest ||--o{ Conversation : has
    ServiceRequest ||--o{ Review : results_in

    Conversation ||--o{ Message : contains
    Transaction ||--|| Currency : in
    Transaction ||--o| PaymentMethod : uses

    University ||--o{ UniversityProgram : offers
    AcademicLevel ||--o{ UniversityProgram : categorizes
    Major ||--o{ UniversityProgram : specializes
    UniversityProgram ||--o{ ProviderUniversityProgram : provided_by
    ServiceProvider ||--o{ ProviderUniversityProgram : offers
    Semester ||--o{ ProviderUniversityProgram : available_in
    Currency ||--|| UniversityProgram : denominated_in
    FieldOfStudy ||--o{ Major : contains

```

#### Key Relationships:

1. User (1) → UserProfile (1)
2. User (1) → Student (0..1)
3. User (1) → ServiceProvider (0..1)
4. User (1) → Admin (0..1)
5. User (1) → Addresses (0..\*)
6. ServiceProvider (1) → Services (0..\*)
7. Service (1) → ServiceRequests (0..\*)
8. ServiceRequest (1) → Transactions (0..\*)
9. ServiceRequest (1) → RequestDocuments (0..\*)
10. ServiceRequest (1) → Conversations (0..\*)
11. Conversation (1) → Messages (0..\*)
12. University (1) → UniversityPrograms (0..\*)
13. AcademicLevel (1) → UniversityPrograms (0..\*)
14. Major (1) → UniversityPrograms (0..\*)
15. UniversityProgram (1) → ProviderUniversityPrograms (0..\*)
16. ServiceProvider (1) → ProviderUniversityPrograms (0..\*)
17. Semester (1) → ProviderUniversityPrograms (0..\*)
18. FieldOfStudy (1) → Majors (0..\*)

## 4. API Endpoints

### 4.1 Authentication Endpoints

#### 4.1.1 Login

- **Endpoint**: POST /api/v1/auth/login
- **Request Body**:
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```
- **Response**:
  ```json
  {
    "token": "string",
    "refreshToken": "string",
    "expiresAt": "datetime",
    "userId": "guid",
    "email": "string",
    "roles": ["string"]
  }
  ```
- **Status Codes**: 200 OK, 401 Unauthorized

#### 4.1.2 Refresh Token

- **Endpoint**: POST /api/v1/auth/refresh
- **Request Body**:
  ```json
  {
    "refreshToken": "string"
  }
  ```
- **Response**: Same as login response
- **Status Codes**: 200 OK, 401 Unauthorized

#### 4.1.3 Forgot Password

- **Endpoint**: POST /api/v1/auth/forgot-password
- **Request Body**:
  ```json
  {
    "email": "string"
  }
  ```
- **Response**: Success message
- **Status Codes**: 200 OK

#### 4.1.4 Reset Password

- **Endpoint**: POST /api/v1/auth/reset-password
- **Request Body**:
  ```json
  {
    "email": "string",
    "token": "string",
    "newPassword": "string",
    "confirmPassword": "string"
  }
  ```
- **Response**: Success message
- **Status Codes**: 200 OK, 400 Bad Request

#### 4.1.5 Change Password

- **Endpoint**: POST /api/v1/auth/change-password
- **Request Body**:
  ```json
  {
    "currentPassword": "string",
    "newPassword": "string",
    "confirmPassword": "string"
  }
  ```
- **Authorization**: JWT Bearer token required
- **Response**: Success message
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized

### 4.2 User Management Endpoints

#### 4.2.1 Register User

- **Endpoint**: POST /api/v1/users/register
- **Request Body**:
  ```json
  {
    "email": "string",
    "password": "string",
    "confirmPassword": "string",
    "firstName": "string",
    "lastName": "string",
    "userType": "enum",
    "phoneNumber": "string",
    "preferredLanguage": "string"
  }
  ```
- **Response**: User DTO
- **Status Codes**: 200 OK, 400 Bad Request

#### 4.2.2 Get User by ID

- **Endpoint**: GET /api/v1/users/{id}
- **Authorization**: JWT Bearer token required
- **Response**: User DTO
- **Status Codes**: 200 OK, 404 Not Found, 401 Unauthorized

#### 4.2.3 Get Users (Paginated)

- **Endpoint**: GET /api/v1/users
- **Authorization**: JWT Bearer token with Admin role required
- **Query Parameters**:
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - searchString: string (optional)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of User DTOs
- **Status Codes**: 200 OK, 401 Unauthorized, 403 Forbidden

### 4.3 Service Management Endpoints

#### 4.3.1 Create Service

- **Endpoint**: POST /api/v1/services
- **Authorization**: JWT Bearer token with Provider role required
- **Request Body**: Service creation details
- **Response**: Service DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized

#### 4.3.2 Get Service by ID

- **Endpoint**: GET /api/v1/services/{id}
- **Authorization**: None required for public services
- **Response**: Service DTO
- **Status Codes**: 200 OK, 404 Not Found

#### 4.3.3 Update Service

- **Endpoint**: PUT /api/v1/services/{id}
- **Authorization**: JWT Bearer token with Provider role required
- **Request Body**: Service update details
- **Response**: Updated Service DTO
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found

#### 4.3.4 Delete Service

- **Endpoint**: DELETE /api/v1/services/{id}
- **Authorization**: JWT Bearer token with Provider or Admin role required
- **Response**: 204 No Content
- **Status Codes**: 204 No Content, 401 Unauthorized, 403 Forbidden, 404 Not Found

#### 4.3.5 Get Services (Paginated)

- **Endpoint**: GET /api/v1/services
- **Query Parameters**:
  - categoryId: guid (optional)
  - providerId: guid (optional)
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - searchString: string (optional)
  - priceMin: decimal (optional)
  - priceMax: decimal (optional)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of Service DTOs
- **Status Codes**: 200 OK

### 4.4 Service Request Management Endpoints

#### 4.4.1 Create Service Request

- **Endpoint**: POST /api/v1/servicerequests
- **Authorization**: JWT Bearer token with Student role required
- **Request Body**: Service request creation details
- **Response**: Service Request DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized

#### 4.4.2 Get Service Request by ID

- **Endpoint**: GET /api/v1/servicerequests/{id}
- **Authorization**: JWT Bearer token with access to the request required
- **Response**: Service Request DTO
- **Status Codes**: 200 OK, 401 Unauthorized, 403 Forbidden, 404 Not Found

#### 4.4.3 Update Service Request Status

- **Endpoint**: PATCH /api/v1/servicerequests/{id}/status
- **Authorization**: JWT Bearer token with access to the request required
- **Request Body**:
  ```json
  {
    "status": "enum",
    "notes": "string"
  }
  ```
- **Response**: Updated Service Request DTO
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found

#### 4.4.4 Get Service Requests (Paginated)

- **Endpoint**: GET /api/v1/servicerequests
- **Authorization**: JWT Bearer token required
- **Query Parameters**:
  - userId: guid (optional)
  - serviceId: guid (optional)
  - status: string (optional)
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of Service Request DTOs
- **Status Codes**: 200 OK, 401 Unauthorized

### 4.5 Transaction Management Endpoints

#### 4.5.1 Create Transaction

- **Endpoint**: POST /api/v1/transactions
- **Authorization**: JWT Bearer token required
- **Request Body**: Transaction creation details
- **Response**: Transaction DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized

#### 4.5.2 Get Transaction by ID

- **Endpoint**: GET /api/v1/transactions/{id}
- **Authorization**: JWT Bearer token with access to the transaction required
- **Response**: Transaction DTO
- **Status Codes**: 200 OK, 401 Unauthorized, 403 Forbidden, 404 Not Found

#### 4.5.3 Update Transaction Status

- **Endpoint**: PATCH /api/v1/transactions/{id}/status
- **Authorization**: JWT Bearer token with Admin role required
- **Request Body**:
  ```json
  {
    "status": "string",
    "notes": "string"
  }
  ```
- **Response**: Updated Transaction DTO
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found

### 4.6 University Management Endpoints

#### 4.6.1 Create University

- **Endpoint**: POST /api/v1/universities
- **Authorization**: JWT Bearer token with Admin role required
- **Request Body**:
  ```json
  {
    "name": "string",
    "countryId": "guid",
    "website": "string",
    "description": "string",
    "logoUrl": "string",
    "address": {
      "addressLine1": "string",
      "addressLine2": "string",
      "city": "string",
      "stateProvince": "string",
      "postalCode": "string",
      "countryId": "guid"
    },
    "isActive": true
  }
  ```
- **Response**: University DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized, 403 Forbidden

#### 4.6.2 Get University by ID

- **Endpoint**: GET /api/v1/universities/{id}
- **Authorization**: JWT Bearer token required
- **Response**: University DTO
- **Status Codes**: 200 OK, 404 Not Found, 401 Unauthorized

#### 4.6.3 Update University

- **Endpoint**: PUT /api/v1/universities/{id}
- **Authorization**: JWT Bearer token with Admin role required
- **Request Body**: Same as Create University
- **Response**: Updated University DTO
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found

#### 4.6.4 Get Universities (Paginated)

- **Endpoint**: GET /api/v1/universities
- **Query Parameters**:
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - searchString: string (optional)
  - countryId: guid (optional)
  - isActive: boolean (optional)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of University DTOs
- **Status Codes**: 200 OK

### 4.7 Academic Level Management Endpoints

#### 4.7.1 Create Academic Level

- **Endpoint**: POST /api/v1/academiclevels
- **Authorization**: JWT Bearer token with Admin role required
- **Request Body**:
  ```json
  {
    "name": "string",
    "description": "string",
    "sortOrder": 0
  }
  ```
- **Response**: AcademicLevel DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized, 403 Forbidden

#### 4.7.2 Get Academic Levels

- **Endpoint**: GET /api/v1/academiclevels
- **Authorization**: JWT Bearer token required
- **Response**: List of AcademicLevel DTOs
- **Status Codes**: 200 OK, 401 Unauthorized

### 4.8 Major Management Endpoints

#### 4.8.1 Create Major

- **Endpoint**: POST /api/v1/majors
- **Authorization**: JWT Bearer token with Admin role required
- **Request Body**:
  ```json
  {
    "name": "string",
    "description": "string",
    "fieldOfStudyId": "guid"
  }
  ```
- **Response**: Major DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized, 403 Forbidden

#### 4.8.2 Get Majors (Paginated)

- **Endpoint**: GET /api/v1/majors
- **Query Parameters**:
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - searchString: string (optional)
  - fieldOfStudyId: guid (optional)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of Major DTOs
- **Status Codes**: 200 OK

### 4.9 University Program Management Endpoints

#### 4.9.1 Create University Program

- **Endpoint**: POST /api/v1/universityprograms
- **Authorization**: JWT Bearer token with Admin role required
- **Request Body**:
  ```json
  {
    "universityId": "guid",
    "majorId": "guid",
    "academicLevelId": "guid",
    "tuitionFee": 0,
    "currencyId": "guid",
    "isActive": true
  }
  ```
- **Response**: UniversityProgram DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized, 403 Forbidden

#### 4.9.2 Get University Programs (Paginated)

- **Endpoint**: GET /api/v1/universityprograms
- **Query Parameters**:
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - universityId: guid (optional)
  - majorId: guid (optional)
  - academicLevelId: guid (optional)
  - isActive: boolean (optional)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of UniversityProgram DTOs
- **Status Codes**: 200 OK

### 4.10 Semester Management Endpoints

#### 4.10.1 Create Semester

- **Endpoint**: POST /api/v1/semesters
- **Authorization**: JWT Bearer token with Admin role required
- **Request Body**:
  ```json
  {
    "name": "string",
    "startDate": "datetime",
    "endDate": "datetime",
    "applicationDeadline": "datetime",
    "isActive": true
  }
  ```
- **Response**: Semester DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized, 403 Forbidden

#### 4.10.2 Get Semesters (Paginated)

- **Endpoint**: GET /api/v1/semesters
- **Query Parameters**:
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - isActive: boolean (optional)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of Semester DTOs
- **Status Codes**: 200 OK

### 4.11 Provider University Program Endpoints

#### 4.11.1 Create Provider University Program

- **Endpoint**: POST /api/v1/providers/{providerId}/programs
- **Authorization**: JWT Bearer token with Provider role or Admin role required
- **Request Body**:
  ```json
  {
    "universityProgramId": "guid",
    "semesterId": "guid",
    "servicePrice": 0,
    "serviceDescription": "string",
    "isActive": true
  }
  ```
- **Response**: ProviderUniversityProgram DTO
- **Status Codes**: 201 Created, 400 Bad Request, 401 Unauthorized, 403 Forbidden

#### 4.11.2 Get Provider University Programs (Paginated)

- **Endpoint**: GET /api/v1/providers/{providerId}/programs
- **Query Parameters**:
  - pageNumber: int (default: 1)
  - pageSize: int (default: 10)
  - universityId: guid (optional)
  - majorId: guid (optional)
  - academicLevelId: guid (optional)
  - semesterId: guid (optional)
  - isActive: boolean (optional)
  - sortBy: string (optional)
  - sortDescending: boolean (optional)
- **Response**: Paginated list of ProviderUniversityProgram DTOs
- **Status Codes**: 200 OK, 401 Unauthorized, 403 Forbidden

#### 4.11.3 Import Provider University Programs

- **Endpoint**: POST /api/v1/providers/{providerId}/programs/import
- **Authorization**: JWT Bearer token with Provider role or Admin role required
- **Request Body**: Multipart form with Excel file
- **Response**: Import results summary
- **Status Codes**: 200 OK, 400 Bad Request, 401 Unauthorized, 403 Forbidden

#### 4.11.4 Export Provider University Programs

- **Endpoint**: GET /api/v1/providers/{providerId}/programs/export
- **Authorization**: JWT Bearer token with Provider role or Admin role required
- **Query Parameters**: Same as Get Provider University Programs
- **Response**: Excel file download
- **Status Codes**: 200 OK, 401 Unauthorized, 403 Forbidden

## 5. Authentication and Security

### 5.1 JWT Authentication

The system uses JSON Web Tokens (JWT) for authentication with the following characteristics:

1. **Token Composition**:

   - User ID claim
   - Email claim
   - Role claims
   - JWT ID claim
   - Issuer, Audience, and Expiration claims

2. **Token Management**:

   - Access tokens have configurable expiration (default 60 minutes)
   - Refresh tokens valid for 30 days
   - Refresh tokens are single-use and stored in the database
   - Token revocation support

3. **Security Measures**:
   - HTTPS required in production
   - Rate limiting for authentication attempts
   - Secure cookie handling
   - Password policies enforced

### 5.2 Role-Based Access Control

The system implements the following roles:

1. **Student**: Can access and manage their own profile, place service requests
2. **ServiceProvider**: Can manage their organization profile, services, and respond to requests
3. **ProviderStaff**: Limited access to provider functions based on assigned permissions
4. **Admin**: Full system access
5. **Moderator**: Content moderation and limited administrative functions

### 5.3 Data Protection

1. **Encryption**:

   - Passwords stored as hashes using ASP.NET Core Identity
   - Sensitive data encrypted at rest
   - All communications over HTTPS

2. **API Security**:
   - CSRF protection
   - CORS properly configured
   - Input validation and sanitization

## 6. Integration Services

### 6.1 Email Service

- Transactional emails for notifications
- Email templates support
- Email delivery tracking

### 6.2 SMS Service

- SMS notifications for critical alerts
- SMS verification codes

### 6.3 Storage Service

- Minio integration for document and media storage
- Secure file upload/download
- Access control for stored files

### 6.4 Payment Service

- Integration with payment gateways
- Secure payment processing
- Transaction recording

### 6.5 Cache Service

- Redis integration for caching
- Distributed cache for scalability
- Cache invalidation strategies

## 7. Non-Functional Requirements

### 7.1 Performance Requirements

1. **Response Time**:

   - API endpoints should respond within 500ms for standard operations
   - Batch operations may take up to 5 seconds
   - Monitoring via PerformanceBehaviour pipeline

2. **Throughput**:

   - Support for at least 100 requests per second
   - Graceful degradation under heavy load

3. **Scalability**:
   - Horizontal scaling through containerization
   - Stateless design for the API layer

### 7.2 Security Requirements

1. **Authentication**:

   - Multi-factor authentication for administrative access
   - JWT with refresh token rotation
   - Password complexity requirements

2. **Authorization**:

   - Fine-grained RBAC
   - Resource-based access control

3. **Data Protection**:
   - Encryption at rest for sensitive data
   - Secure deletion policies

### 7.3 Reliability Requirements

1. **Availability**:

   - 99.9% uptime target
   - Automated health checks

2. **Fault Tolerance**:

   - Graceful error handling
   - Retry policies for external services
   - Circuit breakers for degraded services

3. **Data Integrity**:
   - Transactional database operations
   - Audit trails for all changes

### 7.4 Compatibility Requirements

1. **API Versioning**:

   - Support for multiple API versions
   - Backwards compatibility guarantees

2. **Client Compatibility**:
   - API compatible with modern web browsers
   - Mobile client support

## Appendix A: Database Schema

### Identity Tables

- AspNetUsers
- AspNetRoles
- AspNetUserRoles
- AspNetUserClaims
- AspNetRoleClaims
- AspNetUserLogins
- AspNetUserTokens

### Core Domain Tables

- Users
- UserProfiles
- Students
- ServiceProviders
- ProviderStaff
- Admins
- Addresses
- Countries
- Universities
- FieldsOfStudy
- ServiceCategories
- Services
- ServiceAttributes
- ServiceRequirements
- ServicePriceComponents
- ServiceRequests
- RequestDocuments
- DocumentTypes
- RequestMilestones
- Currencies
- Transactions
- PaymentMethods
- SubscriptionPlans
- Invoices
- InvoiceItems
- Messages
- Conversations
- ConversationParticipants
- Notifications
- CommunicationChannelPreferences
- SystemLogs
- ErrorCodes
- ApiKeys
- FeatureToggles
- Reviews
- ReviewResponses
- RefreshTokens

## Appendix B: Implementation Classes

### Domain Layer

- Base Entity Classes (BaseEntity, AuditableEntity)
- Domain Entities (User, Service, Transaction, etc.)
- Domain Interfaces (IRepository, IDateTime, etc.)

### Application Layer

- CQRS Commands and Queries
- DTOs and Mapping Profiles
- Validators
- Behaviors (Validation, Performance, Exception Handling)
- Interfaces (IApplicationDbContext, ICacheService, etc.)

### Infrastructure Layer

- Database Context (ApplicationDbContext)
- Entity Configurations
- Repositories (Repository<T>, UnitOfWork)
- Services (EmailService, SmsService, etc.)
- Identity (ApplicationUser, IdentityService)

### API Layer

- Controllers (AuthController, UsersController, etc.)
- Middleware
- Filters
- Exception Handling
