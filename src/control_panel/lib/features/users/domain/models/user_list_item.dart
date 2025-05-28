// User list item model that will be displayed in the users listing screen
import 'package:flutter/foundation.dart';

@immutable
class UserListItem {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final List<String> roles;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLogin;

  const UserListItem({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.roles,
    required this.isActive,
    required this.createdAt,
    this.lastLogin,
  });

  factory UserListItem.fromJson(Map<String, dynamic> json) {
    return UserListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin:
          json['lastLogin'] != null
              ? DateTime.parse(json['lastLogin'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'roles': roles,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  UserListItem copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    List<String>? roles,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return UserListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      roles: roles ?? this.roles,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
