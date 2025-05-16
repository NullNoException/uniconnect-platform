import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.profileImage,
    super.phoneNumber,
    required super.createdAt,
    required super.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profile_image'],
      phoneNumber: json['phone_number'],
      createdAt: DateTime.parse(json['created_at']),
      isEmailVerified: json['is_email_verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'profile_image': profileImage,
      'phone_number': phoneNumber,
      'created_at': createdAt.toIso8601String(),
      'is_email_verified': isEmailVerified,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      profileImage: user.profileImage,
      phoneNumber: user.phoneNumber,
      createdAt: user.createdAt,
      isEmailVerified: user.isEmailVerified,
    );
  }
}
