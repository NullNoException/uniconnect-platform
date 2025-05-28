import 'package:customer_app/domain/entities/university.dart';

class UniversityModel extends University {
  UniversityModel({
    required super.id,
    required super.name,
    required super.country,
    required super.city,
    super.logoUrl,
    super.coverImageUrl,
    super.foundedYear,
    super.description,
    super.ranking,
    super.facilities,
    super.websiteUrl,
    super.contactEmail,
    super.contactPhone,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      city: json['city'],
      logoUrl: json['logo_url'],
      coverImageUrl: json['cover_image_url'],
      foundedYear: json['founded_year'],
      description: json['description'],
      ranking:
          json['ranking'] != null
              ? Map<String, dynamic>.from(json['ranking'])
              : null,
      facilities:
          json['facilities'] != null
              ? List<String>.from(json['facilities'])
              : null,
      websiteUrl: json['website_url'],
      contactEmail: json['contact_email'],
      contactPhone: json['contact_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'city': city,
      'logo_url': logoUrl,
      'cover_image_url': coverImageUrl,
      'founded_year': foundedYear,
      'description': description,
      'ranking': ranking,
      'facilities': facilities,
      'website_url': websiteUrl,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
    };
  }

  factory UniversityModel.fromEntity(University university) {
    return UniversityModel(
      id: university.id,
      name: university.name,
      country: university.country,
      city: university.city,
      logoUrl: university.logoUrl,
      coverImageUrl: university.coverImageUrl,
      foundedYear: university.foundedYear,
      description: university.description,
      ranking: university.ranking,
      facilities: university.facilities,
      websiteUrl: university.websiteUrl,
      contactEmail: university.contactEmail,
      contactPhone: university.contactPhone,
    );
  }
}
