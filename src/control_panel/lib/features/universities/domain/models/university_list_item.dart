import 'package:equatable/equatable.dart';

class UniversityListItem extends Equatable {
  final String id;
  final String name;
  final String country;
  final String city;
  final bool isActive;
  final int programCount;
  final DateTime updatedAt;

  const UniversityListItem({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.isActive,
    required this.programCount,
    required this.updatedAt,
  });

  factory UniversityListItem.fromJson(Map<String, dynamic> json) {
    return UniversityListItem(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      city: json['city'],
      isActive: json['isActive'],
      programCount: json['programCount'] ?? 0,
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    country,
    city,
    isActive,
    programCount,
    updatedAt,
  ];
}
