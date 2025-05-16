import '../../domain/entities/university.dart';

class UniversityModel extends University {
  UniversityModel({
    required String id,
    required String name,
    required String country,
    required String city,
    String? logoUrl,
    String? coverImageUrl,
    int? foundedYear,
    String? description,
    Map<String, dynamic>? ranking,
    List<String>? facilities,
    String? websiteUrl,
    String? contactEmail,
    String? contactPhone,
  }) : super(
         id: id,
         name: name,
         country: country,
         city: city,
         logoUrl: logoUrl,
         coverImageUrl: coverImageUrl,
         foundedYear: foundedYear,
         description: description,
         ranking: ranking,
         facilities: facilities,
         websiteUrl: websiteUrl,
         contactEmail: contactEmail,
         contactPhone: contactPhone,
       );

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
