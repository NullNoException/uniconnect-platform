using System;
using System.Collections.Generic;

namespace UniConnect.Application.Admin.DTOs
{
    /// <summary>
    /// DTO for platform configuration settings
    /// </summary>
    public class PlatformSettingsDto
    {
        /// <summary>
        /// General platform configuration
        /// </summary>
        public GeneralSettings General { get; set; }

        /// <summary>
        /// Payment and financial settings
        /// </summary>
        public PaymentSettings Payment { get; set; }

        /// <summary>
        /// Security and authentication settings
        /// </summary>
        public SecuritySettings Security { get; set; }

        /// <summary>
        /// Notification and communication settings
        /// </summary>
        public NotificationSettings Notifications { get; set; }

        /// <summary>
        /// Service management settings
        /// </summary>
        public ServiceSettings Services { get; set; }

        /// <summary>
        /// University integration settings
        /// </summary>
        public UniversitySettings Universities { get; set; }

        /// <summary>
        /// Search and discovery settings
        /// </summary>
        public SearchSettings Search { get; set; }

        /// <summary>
        /// File upload and storage settings
        /// </summary>
        public StorageSettings Storage { get; set; }

        /// <summary>
        /// When the settings were last updated
        /// </summary>
        public DateTime LastUpdated { get; set; }

        /// <summary>
        /// Admin who last updated the settings
        /// </summary>
        public string UpdatedBy { get; set; } = string.Empty;

        public PlatformSettingsDto()
        {
            General = new GeneralSettings();
            Payment = new PaymentSettings();
            Security = new SecuritySettings();
            Notifications = new NotificationSettings();
            Services = new ServiceSettings();
            Universities = new UniversitySettings();
            Search = new SearchSettings();
            Storage = new StorageSettings();
        }
    }

    /// <summary>
    /// General platform configuration
    /// </summary>
    public class GeneralSettings
    {
        public string PlatformName { get; set; } = string.Empty;
        public string PlatformDescription { get; set; } = string.Empty;
        public string SupportEmail { get; set; } = string.Empty;
        public string ContactPhone { get; set; } = string.Empty;
        public string WebsiteUrl { get; set; } = string.Empty;
        public string LogoUrl { get; set; } = string.Empty;
        public bool MaintenanceMode { get; set; }
        public string MaintenanceMessage { get; set; } = string.Empty;
        public List<string> SupportedLanguages { get; set; }
        public string DefaultLanguage { get; set; } = "en";
        public string DefaultTimezone { get; set; } = "UTC";

        public GeneralSettings()
        {
            SupportedLanguages = new List<string>();
        }
    }

    /// <summary>
    /// Payment and financial configuration
    /// </summary>
    public class PaymentSettings
    {
        public decimal PlatformFeePercentage { get; set; }
        public decimal MinimumTransactionAmount { get; set; }
        public decimal MaximumTransactionAmount { get; set; }
        public int EscrowHoldDays { get; set; }
        public bool AutoReleaseEnabled { get; set; }
        public decimal RefundProcessingFee { get; set; }
        public List<string> AcceptedCurrencies { get; set; }
        public string DefaultCurrency { get; set; } = "USD";
        public List<string> PaymentMethods { get; set; }
        public PaymentProviderSettings StripeSettings { get; set; }
        public PaymentProviderSettings PayPalSettings { get; set; }

        public PaymentSettings()
        {
            AcceptedCurrencies = new List<string>();
            PaymentMethods = new List<string>();
            StripeSettings = new PaymentProviderSettings();
            PayPalSettings = new PaymentProviderSettings();
        }
    }

    /// <summary>
    /// Security and authentication configuration
    /// </summary>
    public class SecuritySettings
    {
        public bool TwoFactorEnabled { get; set; }
        public int PasswordMinLength { get; set; }
        public bool PasswordRequireSpecialChar { get; set; }
        public bool PasswordRequireNumber { get; set; }
        public bool PasswordRequireUppercase { get; set; }
        public int LoginAttemptLimit { get; set; }
        public int AccountLockoutMinutes { get; set; }
        public int SessionTimeoutMinutes { get; set; }
        public bool RequireEmailVerification { get; set; }
        public bool RequirePhoneVerification { get; set; }
        public List<string> AllowedDomains { get; set; }
        public List<string> BlockedDomains { get; set; }

        public SecuritySettings()
        {
            AllowedDomains = new List<string>();
            BlockedDomains = new List<string>();
        }
    }

    /// <summary>
    /// Notification and communication settings
    /// </summary>
    public class NotificationSettings
    {
        public bool EmailNotificationsEnabled { get; set; }
        public bool SmsNotificationsEnabled { get; set; }
        public bool PushNotificationsEnabled { get; set; }
        public EmailSettings EmailSettings { get; set; }
        public SmsSettings SmsSettings { get; set; }
        public NotificationTemplates Templates { get; set; }
        public int NotificationRetryAttempts { get; set; }
        public int NotificationRetryDelayMinutes { get; set; }

        public NotificationSettings()
        {
            EmailSettings = new EmailSettings();
            SmsSettings = new SmsSettings();
            Templates = new NotificationTemplates();
        }
    }

    /// <summary>
    /// Service management configuration
    /// </summary>
    public class ServiceSettings
    {
        public bool AutoApprovalEnabled { get; set; }
        public int ServiceApprovalTimeoutHours { get; set; }
        public int MaxServicesPerProvider { get; set; }
        public decimal MinimumServicePrice { get; set; }
        public decimal MaximumServicePrice { get; set; }
        public List<string> RequiredDocuments { get; set; }
        public List<string> AllowedCategories { get; set; }
        public int MaxServiceImages { get; set; }
        public int MaxServiceVideos { get; set; }
        public List<string> AllowedFileTypes { get; set; }

        public ServiceSettings()
        {
            RequiredDocuments = new List<string>();
            AllowedCategories = new List<string>();
            AllowedFileTypes = new List<string>();
        }
    }

    /// <summary>
    /// University integration settings
    /// </summary>
    public class UniversitySettings
    {
        public bool AutoSyncEnabled { get; set; }
        public int SyncIntervalHours { get; set; }
        public List<string> SupportedUniversities { get; set; }
        public bool RequireUniversityVerification { get; set; }
        public string UniversityApiKey { get; set; } = string.Empty;
        public string UniversityApiUrl { get; set; } = string.Empty;
        public int UniversityApiTimeoutSeconds { get; set; }
        public bool EnableGradeSync { get; set; }
        public bool EnableCourseSync { get; set; }

        public UniversitySettings()
        {
            SupportedUniversities = new List<string>();
        }
    }

    /// <summary>
    /// Search and discovery configuration
    /// </summary>
    public class SearchSettings
    {
        public bool SearchEnabled { get; set; }
        public string SearchProvider { get; set; } = "MeiliSearch";
        public int MaxSearchResults { get; set; }
        public int SearchTimeoutSeconds { get; set; }
        public bool FuzzySearchEnabled { get; set; }
        public List<string> SearchableFields { get; set; }
        public List<string> SortableFields { get; set; }
        public List<string> FilterableFields { get; set; }
        public bool AutoCompleteEnabled { get; set; }
        public int AutoCompleteMinChars { get; set; }

        public SearchSettings()
        {
            SearchableFields = new List<string>();
            SortableFields = new List<string>();
            FilterableFields = new List<string>();
        }
    }

    /// <summary>
    /// File storage configuration
    /// </summary>
    public class StorageSettings
    {
        public string StorageProvider { get; set; } = "Azure";
        public long MaxFileSize { get; set; }
        public List<string> AllowedMimeTypes { get; set; }
        public string StorageContainer { get; set; } = string.Empty;
        public string CdnUrl { get; set; } = string.Empty;
        public bool VirusScanningEnabled { get; set; }
        public int FileRetentionDays { get; set; }
        public bool CompressImages { get; set; }
        public int ImageQuality { get; set; }

        public StorageSettings()
        {
            AllowedMimeTypes = new List<string>();
        }
    }

    /// <summary>
    /// Payment provider specific settings
    /// </summary>
    public class PaymentProviderSettings
    {
        public bool Enabled { get; set; }
        public string PublicKey { get; set; } = string.Empty;
        public string SecretKey { get; set; } = string.Empty;
        public string WebhookSecret { get; set; } = string.Empty;
        public bool SandboxMode { get; set; }
        public string ApiVersion { get; set; } = string.Empty;
    }

    /// <summary>
    /// Email service configuration
    /// </summary>
    public class EmailSettings
    {
        public string SmtpServer { get; set; } = string.Empty;
        public int SmtpPort { get; set; }
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public bool UseSSL { get; set; }
        public string FromEmail { get; set; } = string.Empty;
        public string FromName { get; set; } = string.Empty;
    }

    /// <summary>
    /// SMS service configuration
    /// </summary>
    public class SmsSettings
    {
        public string Provider { get; set; } = string.Empty;
        public string ApiKey { get; set; } = string.Empty;
        public string ApiSecret { get; set; } = string.Empty;
        public string FromNumber { get; set; } = string.Empty;
        public bool Enabled { get; set; }
    }

    /// <summary>
    /// Notification template configuration
    /// </summary>
    public class NotificationTemplates
    {
        public Dictionary<string, string> EmailTemplates { get; set; }
        public Dictionary<string, string> SmsTemplates { get; set; }
        public Dictionary<string, string> PushTemplates { get; set; }

        public NotificationTemplates()
        {
            EmailTemplates = new Dictionary<string, string>();
            SmsTemplates = new Dictionary<string, string>();
            PushTemplates = new Dictionary<string, string>();
        }
    }
}
