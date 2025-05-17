class University {
  final String id;
  final String name;
  final String country;
  final String city;
  final String? logoUrl;
  final String? coverImageUrl;
  final int? foundedYear;
  final String? description;
  final Map<String, dynamic>? ranking;
  final List<String>? facilities;
  final String? websiteUrl;
  final String? contactEmail;
  final String? contactPhone;

  University({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    this.logoUrl,
    this.coverImageUrl,
    this.foundedYear,
    this.description,
    this.ranking,
    this.facilities,
    this.websiteUrl,
    this.contactEmail,
    this.contactPhone,
  });

  University copyWith({
    String? id,
    String? name,
    String? country,
    String? city,
    String? logoUrl,
    String? coverImageUrl,
    int? foundedYear,
    String? description,
    Map<String, dynamic>? ranking,
    List<String>? facilities,
    String? websiteUrl,
    String? contactEmail,
    String? contactPhone,
  }) {
    return University(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      city: city ?? this.city,
      logoUrl: logoUrl ?? this.logoUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      foundedYear: foundedYear ?? this.foundedYear,
      description: description ?? this.description,
      ranking: ranking ?? this.ranking,
      facilities: facilities ?? this.facilities,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
    );
  }

  String get location => '$city, $country';

  // For displaying ranking summary
  String? get rankingSummary {
    if (ranking == null || ranking!.isEmpty) return null;

    final List<String> rankings = [];
    if (ranking!.containsKey('world')) {
      rankings.add('#${ranking!['world']} Globally');
    }
    if (ranking!.containsKey('national')) {
      rankings.add('#${ranking!['national']} Nationally');
    }
    return rankings.join(' | ');
  }
}
