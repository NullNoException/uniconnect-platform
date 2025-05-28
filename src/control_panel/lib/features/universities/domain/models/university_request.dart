class UniversityRequest {
  final String name;
  final String country;
  final String city;
  final String? website;
  final String? logoUrl;
  final String? description;
  final bool isActive;

  UniversityRequest({
    required this.name,
    required this.country,
    required this.city,
    this.website,
    this.logoUrl,
    this.description,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'city': city,
      'website': website,
      'logoUrl': logoUrl,
      'description': description,
      'isActive': isActive,
    };
  }
}
