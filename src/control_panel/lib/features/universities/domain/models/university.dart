import 'package:equatable/equatable.dart';

class University extends Equatable {
  final String id;
  final String name;
  final String country;
  final String city;
  final String? website;
  final String? logoUrl;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const University({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    this.website,
    this.logoUrl,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      city: json['city'],
      website: json['website'],
      logoUrl: json['logoUrl'],
      description: json['description'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'city': city,
      'website': website,
      'logoUrl': logoUrl,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  University copyWith({
    String? id,
    String? name,
    String? country,
    String? city,
    String? website,
    String? logoUrl,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return University(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      city: city ?? this.city,
      website: website ?? this.website,
      logoUrl: logoUrl ?? this.logoUrl,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    country,
    city,
    website,
    logoUrl,
    description,
    isActive,
    createdAt,
    updatedAt,
  ];
}
