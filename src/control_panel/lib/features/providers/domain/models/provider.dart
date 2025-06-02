import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';

@freezed
abstract class Provider with _$Provider {
  const factory Provider({
    required String id,
    required String userId,
    required String companyName,
    String? registrationNumber,
    required ProviderVerificationStatus verificationStatus,
    String? verifiedById,
    DateTime? verificationDate,
    String? companyLogoUrl,
    String? companyWebsite,
    int? yearsInBusiness,
    String? subscriptionPlanId,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    String? billingAddressId,
    String? taxIdentificationNumber,
    List<String>? documents,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    // User information
    required String email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? isActive,
    // Performance metrics
    double? averageRating,
    int? totalServices,
    int? completedOrders,
    double? completionRate,
    double? responseTime,
  }) = _Provider;

  factory Provider.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);
}

enum ProviderVerificationStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('InReview')
  inReview,
  @JsonValue('Verified')
  verified,
  @JsonValue('Rejected')
  rejected,
}

@freezed
abstract class ProviderListItem with _$ProviderListItem {
  const factory ProviderListItem({
    required String id,
    required String companyName,
    required String email,
    required ProviderVerificationStatus verificationStatus,
    required DateTime createdAt,
    DateTime? verificationDate,
    double? averageRating,
    int? totalServices,
    bool? isActive,
  }) = _ProviderListItem;

  factory ProviderListItem.fromJson(Map<String, dynamic> json) =>
      _$ProviderListItemFromJson(json);
}

@freezed
abstract class ProviderRequest with _$ProviderRequest {
  const factory ProviderRequest({
    required String companyName,
    String? registrationNumber,
    String? companyWebsite,
    int? yearsInBusiness,
    String? taxIdentificationNumber,
    String? notes,
    // User data
    required String email,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) = _ProviderRequest;

  factory ProviderRequest.fromJson(Map<String, dynamic> json) =>
      _$ProviderRequestFromJson(json);
}

@freezed
abstract class VerifyProviderRequest with _$VerifyProviderRequest {
  const factory VerifyProviderRequest({
    required String providerId,
    required bool isApproved,
    String? comments,
    required String verifiedByAdminId,
  }) = _VerifyProviderRequest;

  factory VerifyProviderRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyProviderRequestFromJson(json);
}

@freezed
abstract class ProviderPerformanceMetrics with _$ProviderPerformanceMetrics {
  const factory ProviderPerformanceMetrics({
    required String providerId,
    required double averageRating,
    required int totalServices,
    required int totalOrders,
    required int completedOrders,
    required double completionRate,
    required double averageResponseTime,
    required Map<String, int> ratingDistribution,
    required List<CustomerFeedback> recentFeedback,
  }) = _ProviderPerformanceMetrics;

  factory ProviderPerformanceMetrics.fromJson(Map<String, dynamic> json) =>
      _$ProviderPerformanceMetricsFromJson(json);
}

@freezed
abstract class CustomerFeedback with _$CustomerFeedback {
  const factory CustomerFeedback({
    required String id,
    required String customerName,
    required int rating,
    String? comment,
    required DateTime createdAt,
    required String serviceTitle,
  }) = _CustomerFeedback;

  factory CustomerFeedback.fromJson(Map<String, dynamic> json) =>
      _$CustomerFeedbackFromJson(json);
}
