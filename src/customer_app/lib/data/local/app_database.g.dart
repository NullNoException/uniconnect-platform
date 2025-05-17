// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UniversitiesTable extends Universities
    with TableInfo<$UniversitiesTable, University> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UniversitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageUrlMeta = const VerificationMeta(
    'coverImageUrl',
  );
  @override
  late final GeneratedColumn<String> coverImageUrl = GeneratedColumn<String>(
    'cover_image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _foundedYearMeta = const VerificationMeta(
    'foundedYear',
  );
  @override
  late final GeneratedColumn<int> foundedYear = GeneratedColumn<int>(
    'founded_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rankingMeta = const VerificationMeta(
    'ranking',
  );
  @override
  late final GeneratedColumn<String> ranking = GeneratedColumn<String>(
    'ranking',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _facilitiesMeta = const VerificationMeta(
    'facilities',
  );
  @override
  late final GeneratedColumn<String> facilities = GeneratedColumn<String>(
    'facilities',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteUrlMeta = const VerificationMeta(
    'websiteUrl',
  );
  @override
  late final GeneratedColumn<String> websiteUrl = GeneratedColumn<String>(
    'website_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactEmailMeta = const VerificationMeta(
    'contactEmail',
  );
  @override
  late final GeneratedColumn<String> contactEmail = GeneratedColumn<String>(
    'contact_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactPhoneMeta = const VerificationMeta(
    'contactPhone',
  );
  @override
  late final GeneratedColumn<String> contactPhone = GeneratedColumn<String>(
    'contact_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFeaturedMeta = const VerificationMeta(
    'isFeatured',
  );
  @override
  late final GeneratedColumn<bool> isFeatured = GeneratedColumn<bool>(
    'is_featured',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_featured" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    country,
    city,
    logoUrl,
    coverImageUrl,
    foundedYear,
    description,
    ranking,
    facilities,
    websiteUrl,
    contactEmail,
    contactPhone,
    isFeatured,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'universities';
  @override
  VerificationContext validateIntegrity(
    Insertable<University> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('cover_image_url')) {
      context.handle(
        _coverImageUrlMeta,
        coverImageUrl.isAcceptableOrUnknown(
          data['cover_image_url']!,
          _coverImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('founded_year')) {
      context.handle(
        _foundedYearMeta,
        foundedYear.isAcceptableOrUnknown(
          data['founded_year']!,
          _foundedYearMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('ranking')) {
      context.handle(
        _rankingMeta,
        ranking.isAcceptableOrUnknown(data['ranking']!, _rankingMeta),
      );
    }
    if (data.containsKey('facilities')) {
      context.handle(
        _facilitiesMeta,
        facilities.isAcceptableOrUnknown(data['facilities']!, _facilitiesMeta),
      );
    }
    if (data.containsKey('website_url')) {
      context.handle(
        _websiteUrlMeta,
        websiteUrl.isAcceptableOrUnknown(data['website_url']!, _websiteUrlMeta),
      );
    }
    if (data.containsKey('contact_email')) {
      context.handle(
        _contactEmailMeta,
        contactEmail.isAcceptableOrUnknown(
          data['contact_email']!,
          _contactEmailMeta,
        ),
      );
    }
    if (data.containsKey('contact_phone')) {
      context.handle(
        _contactPhoneMeta,
        contactPhone.isAcceptableOrUnknown(
          data['contact_phone']!,
          _contactPhoneMeta,
        ),
      );
    }
    if (data.containsKey('is_featured')) {
      context.handle(
        _isFeaturedMeta,
        isFeatured.isAcceptableOrUnknown(data['is_featured']!, _isFeaturedMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  University map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return University(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      country:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}country'],
          )!,
      city:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}city'],
          )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      coverImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_url'],
      ),
      foundedYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}founded_year'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      ranking: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ranking'],
      ),
      facilities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facilities'],
      ),
      websiteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website_url'],
      ),
      contactEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_email'],
      ),
      contactPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_phone'],
      ),
      isFeatured:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_featured'],
          )!,
      lastUpdated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_updated'],
          )!,
    );
  }

  @override
  $UniversitiesTable createAlias(String alias) {
    return $UniversitiesTable(attachedDatabase, alias);
  }
}

class University extends DataClass implements Insertable<University> {
  final String id;
  final String name;
  final String country;
  final String city;
  final String? logoUrl;
  final String? coverImageUrl;
  final int? foundedYear;
  final String? description;
  final String? ranking;
  final String? facilities;
  final String? websiteUrl;
  final String? contactEmail;
  final String? contactPhone;
  final bool isFeatured;
  final DateTime lastUpdated;
  const University({
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
    required this.isFeatured,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['country'] = Variable<String>(country);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || coverImageUrl != null) {
      map['cover_image_url'] = Variable<String>(coverImageUrl);
    }
    if (!nullToAbsent || foundedYear != null) {
      map['founded_year'] = Variable<int>(foundedYear);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || ranking != null) {
      map['ranking'] = Variable<String>(ranking);
    }
    if (!nullToAbsent || facilities != null) {
      map['facilities'] = Variable<String>(facilities);
    }
    if (!nullToAbsent || websiteUrl != null) {
      map['website_url'] = Variable<String>(websiteUrl);
    }
    if (!nullToAbsent || contactEmail != null) {
      map['contact_email'] = Variable<String>(contactEmail);
    }
    if (!nullToAbsent || contactPhone != null) {
      map['contact_phone'] = Variable<String>(contactPhone);
    }
    map['is_featured'] = Variable<bool>(isFeatured);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  UniversitiesCompanion toCompanion(bool nullToAbsent) {
    return UniversitiesCompanion(
      id: Value(id),
      name: Value(name),
      country: Value(country),
      city: Value(city),
      logoUrl:
          logoUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(logoUrl),
      coverImageUrl:
          coverImageUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImageUrl),
      foundedYear:
          foundedYear == null && nullToAbsent
              ? const Value.absent()
              : Value(foundedYear),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      ranking:
          ranking == null && nullToAbsent
              ? const Value.absent()
              : Value(ranking),
      facilities:
          facilities == null && nullToAbsent
              ? const Value.absent()
              : Value(facilities),
      websiteUrl:
          websiteUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(websiteUrl),
      contactEmail:
          contactEmail == null && nullToAbsent
              ? const Value.absent()
              : Value(contactEmail),
      contactPhone:
          contactPhone == null && nullToAbsent
              ? const Value.absent()
              : Value(contactPhone),
      isFeatured: Value(isFeatured),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory University.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return University(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      country: serializer.fromJson<String>(json['country']),
      city: serializer.fromJson<String>(json['city']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      coverImageUrl: serializer.fromJson<String?>(json['coverImageUrl']),
      foundedYear: serializer.fromJson<int?>(json['foundedYear']),
      description: serializer.fromJson<String?>(json['description']),
      ranking: serializer.fromJson<String?>(json['ranking']),
      facilities: serializer.fromJson<String?>(json['facilities']),
      websiteUrl: serializer.fromJson<String?>(json['websiteUrl']),
      contactEmail: serializer.fromJson<String?>(json['contactEmail']),
      contactPhone: serializer.fromJson<String?>(json['contactPhone']),
      isFeatured: serializer.fromJson<bool>(json['isFeatured']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'country': serializer.toJson<String>(country),
      'city': serializer.toJson<String>(city),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'coverImageUrl': serializer.toJson<String?>(coverImageUrl),
      'foundedYear': serializer.toJson<int?>(foundedYear),
      'description': serializer.toJson<String?>(description),
      'ranking': serializer.toJson<String?>(ranking),
      'facilities': serializer.toJson<String?>(facilities),
      'websiteUrl': serializer.toJson<String?>(websiteUrl),
      'contactEmail': serializer.toJson<String?>(contactEmail),
      'contactPhone': serializer.toJson<String?>(contactPhone),
      'isFeatured': serializer.toJson<bool>(isFeatured),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  University copyWith({
    String? id,
    String? name,
    String? country,
    String? city,
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> coverImageUrl = const Value.absent(),
    Value<int?> foundedYear = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> ranking = const Value.absent(),
    Value<String?> facilities = const Value.absent(),
    Value<String?> websiteUrl = const Value.absent(),
    Value<String?> contactEmail = const Value.absent(),
    Value<String?> contactPhone = const Value.absent(),
    bool? isFeatured,
    DateTime? lastUpdated,
  }) => University(
    id: id ?? this.id,
    name: name ?? this.name,
    country: country ?? this.country,
    city: city ?? this.city,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    coverImageUrl:
        coverImageUrl.present ? coverImageUrl.value : this.coverImageUrl,
    foundedYear: foundedYear.present ? foundedYear.value : this.foundedYear,
    description: description.present ? description.value : this.description,
    ranking: ranking.present ? ranking.value : this.ranking,
    facilities: facilities.present ? facilities.value : this.facilities,
    websiteUrl: websiteUrl.present ? websiteUrl.value : this.websiteUrl,
    contactEmail: contactEmail.present ? contactEmail.value : this.contactEmail,
    contactPhone: contactPhone.present ? contactPhone.value : this.contactPhone,
    isFeatured: isFeatured ?? this.isFeatured,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  University copyWithCompanion(UniversitiesCompanion data) {
    return University(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      country: data.country.present ? data.country.value : this.country,
      city: data.city.present ? data.city.value : this.city,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      coverImageUrl:
          data.coverImageUrl.present
              ? data.coverImageUrl.value
              : this.coverImageUrl,
      foundedYear:
          data.foundedYear.present ? data.foundedYear.value : this.foundedYear,
      description:
          data.description.present ? data.description.value : this.description,
      ranking: data.ranking.present ? data.ranking.value : this.ranking,
      facilities:
          data.facilities.present ? data.facilities.value : this.facilities,
      websiteUrl:
          data.websiteUrl.present ? data.websiteUrl.value : this.websiteUrl,
      contactEmail:
          data.contactEmail.present
              ? data.contactEmail.value
              : this.contactEmail,
      contactPhone:
          data.contactPhone.present
              ? data.contactPhone.value
              : this.contactPhone,
      isFeatured:
          data.isFeatured.present ? data.isFeatured.value : this.isFeatured,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('University(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('coverImageUrl: $coverImageUrl, ')
          ..write('foundedYear: $foundedYear, ')
          ..write('description: $description, ')
          ..write('ranking: $ranking, ')
          ..write('facilities: $facilities, ')
          ..write('websiteUrl: $websiteUrl, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    country,
    city,
    logoUrl,
    coverImageUrl,
    foundedYear,
    description,
    ranking,
    facilities,
    websiteUrl,
    contactEmail,
    contactPhone,
    isFeatured,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is University &&
          other.id == this.id &&
          other.name == this.name &&
          other.country == this.country &&
          other.city == this.city &&
          other.logoUrl == this.logoUrl &&
          other.coverImageUrl == this.coverImageUrl &&
          other.foundedYear == this.foundedYear &&
          other.description == this.description &&
          other.ranking == this.ranking &&
          other.facilities == this.facilities &&
          other.websiteUrl == this.websiteUrl &&
          other.contactEmail == this.contactEmail &&
          other.contactPhone == this.contactPhone &&
          other.isFeatured == this.isFeatured &&
          other.lastUpdated == this.lastUpdated);
}

class UniversitiesCompanion extends UpdateCompanion<University> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> country;
  final Value<String> city;
  final Value<String?> logoUrl;
  final Value<String?> coverImageUrl;
  final Value<int?> foundedYear;
  final Value<String?> description;
  final Value<String?> ranking;
  final Value<String?> facilities;
  final Value<String?> websiteUrl;
  final Value<String?> contactEmail;
  final Value<String?> contactPhone;
  final Value<bool> isFeatured;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const UniversitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.country = const Value.absent(),
    this.city = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.coverImageUrl = const Value.absent(),
    this.foundedYear = const Value.absent(),
    this.description = const Value.absent(),
    this.ranking = const Value.absent(),
    this.facilities = const Value.absent(),
    this.websiteUrl = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UniversitiesCompanion.insert({
    required String id,
    required String name,
    required String country,
    required String city,
    this.logoUrl = const Value.absent(),
    this.coverImageUrl = const Value.absent(),
    this.foundedYear = const Value.absent(),
    this.description = const Value.absent(),
    this.ranking = const Value.absent(),
    this.facilities = const Value.absent(),
    this.websiteUrl = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.isFeatured = const Value.absent(),
    required DateTime lastUpdated,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       country = Value(country),
       city = Value(city),
       lastUpdated = Value(lastUpdated);
  static Insertable<University> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? country,
    Expression<String>? city,
    Expression<String>? logoUrl,
    Expression<String>? coverImageUrl,
    Expression<int>? foundedYear,
    Expression<String>? description,
    Expression<String>? ranking,
    Expression<String>? facilities,
    Expression<String>? websiteUrl,
    Expression<String>? contactEmail,
    Expression<String>? contactPhone,
    Expression<bool>? isFeatured,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (coverImageUrl != null) 'cover_image_url': coverImageUrl,
      if (foundedYear != null) 'founded_year': foundedYear,
      if (description != null) 'description': description,
      if (ranking != null) 'ranking': ranking,
      if (facilities != null) 'facilities': facilities,
      if (websiteUrl != null) 'website_url': websiteUrl,
      if (contactEmail != null) 'contact_email': contactEmail,
      if (contactPhone != null) 'contact_phone': contactPhone,
      if (isFeatured != null) 'is_featured': isFeatured,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UniversitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? country,
    Value<String>? city,
    Value<String?>? logoUrl,
    Value<String?>? coverImageUrl,
    Value<int?>? foundedYear,
    Value<String?>? description,
    Value<String?>? ranking,
    Value<String?>? facilities,
    Value<String?>? websiteUrl,
    Value<String?>? contactEmail,
    Value<String?>? contactPhone,
    Value<bool>? isFeatured,
    Value<DateTime>? lastUpdated,
    Value<int>? rowid,
  }) {
    return UniversitiesCompanion(
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
      isFeatured: isFeatured ?? this.isFeatured,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (coverImageUrl.present) {
      map['cover_image_url'] = Variable<String>(coverImageUrl.value);
    }
    if (foundedYear.present) {
      map['founded_year'] = Variable<int>(foundedYear.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ranking.present) {
      map['ranking'] = Variable<String>(ranking.value);
    }
    if (facilities.present) {
      map['facilities'] = Variable<String>(facilities.value);
    }
    if (websiteUrl.present) {
      map['website_url'] = Variable<String>(websiteUrl.value);
    }
    if (contactEmail.present) {
      map['contact_email'] = Variable<String>(contactEmail.value);
    }
    if (contactPhone.present) {
      map['contact_phone'] = Variable<String>(contactPhone.value);
    }
    if (isFeatured.present) {
      map['is_featured'] = Variable<bool>(isFeatured.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UniversitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('coverImageUrl: $coverImageUrl, ')
          ..write('foundedYear: $foundedYear, ')
          ..write('description: $description, ')
          ..write('ranking: $ranking, ')
          ..write('facilities: $facilities, ')
          ..write('websiteUrl: $websiteUrl, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgramsTable extends Programs with TableInfo<$ProgramsTable, Program> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _universityIdMeta = const VerificationMeta(
    'universityId',
  );
  @override
  late final GeneratedColumn<String> universityId = GeneratedColumn<String>(
    'university_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _universityNameMeta = const VerificationMeta(
    'universityName',
  );
  @override
  late final GeneratedColumn<String> universityName = GeneratedColumn<String>(
    'university_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyModeMeta = const VerificationMeta(
    'studyMode',
  );
  @override
  late final GeneratedColumn<String> studyMode = GeneratedColumn<String>(
    'study_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMonthsMeta = const VerificationMeta(
    'durationMonths',
  );
  @override
  late final GeneratedColumn<int> durationMonths = GeneratedColumn<int>(
    'duration_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tuitionFeeMeta = const VerificationMeta(
    'tuitionFee',
  );
  @override
  late final GeneratedColumn<double> tuitionFee = GeneratedColumn<double>(
    'tuition_fee',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _applicationDeadlineMeta =
      const VerificationMeta('applicationDeadline');
  @override
  late final GeneratedColumn<DateTime> applicationDeadline =
      GeneratedColumn<DateTime>(
        'application_deadline',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requirementsMeta = const VerificationMeta(
    'requirements',
  );
  @override
  late final GeneratedColumn<String> requirements = GeneratedColumn<String>(
    'requirements',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _curriculumMeta = const VerificationMeta(
    'curriculum',
  );
  @override
  late final GeneratedColumn<String> curriculum = GeneratedColumn<String>(
    'curriculum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _careerOpportunitiesMeta =
      const VerificationMeta('careerOpportunities');
  @override
  late final GeneratedColumn<String> careerOpportunities =
      GeneratedColumn<String>(
        'career_opportunities',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _applicationFeeMeta = const VerificationMeta(
    'applicationFee',
  );
  @override
  late final GeneratedColumn<double> applicationFee = GeneratedColumn<double>(
    'application_fee',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFeaturedMeta = const VerificationMeta(
    'isFeatured',
  );
  @override
  late final GeneratedColumn<bool> isFeatured = GeneratedColumn<bool>(
    'is_featured',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_featured" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    universityId,
    universityName,
    level,
    studyMode,
    durationMonths,
    language,
    tuitionFee,
    currency,
    description,
    applicationDeadline,
    startDate,
    requirements,
    curriculum,
    careerOpportunities,
    applicationFee,
    isFeatured,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'programs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Program> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('university_id')) {
      context.handle(
        _universityIdMeta,
        universityId.isAcceptableOrUnknown(
          data['university_id']!,
          _universityIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universityIdMeta);
    }
    if (data.containsKey('university_name')) {
      context.handle(
        _universityNameMeta,
        universityName.isAcceptableOrUnknown(
          data['university_name']!,
          _universityNameMeta,
        ),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('study_mode')) {
      context.handle(
        _studyModeMeta,
        studyMode.isAcceptableOrUnknown(data['study_mode']!, _studyModeMeta),
      );
    } else if (isInserting) {
      context.missing(_studyModeMeta);
    }
    if (data.containsKey('duration_months')) {
      context.handle(
        _durationMonthsMeta,
        durationMonths.isAcceptableOrUnknown(
          data['duration_months']!,
          _durationMonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMonthsMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('tuition_fee')) {
      context.handle(
        _tuitionFeeMeta,
        tuitionFee.isAcceptableOrUnknown(data['tuition_fee']!, _tuitionFeeMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('application_deadline')) {
      context.handle(
        _applicationDeadlineMeta,
        applicationDeadline.isAcceptableOrUnknown(
          data['application_deadline']!,
          _applicationDeadlineMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('requirements')) {
      context.handle(
        _requirementsMeta,
        requirements.isAcceptableOrUnknown(
          data['requirements']!,
          _requirementsMeta,
        ),
      );
    }
    if (data.containsKey('curriculum')) {
      context.handle(
        _curriculumMeta,
        curriculum.isAcceptableOrUnknown(data['curriculum']!, _curriculumMeta),
      );
    }
    if (data.containsKey('career_opportunities')) {
      context.handle(
        _careerOpportunitiesMeta,
        careerOpportunities.isAcceptableOrUnknown(
          data['career_opportunities']!,
          _careerOpportunitiesMeta,
        ),
      );
    }
    if (data.containsKey('application_fee')) {
      context.handle(
        _applicationFeeMeta,
        applicationFee.isAcceptableOrUnknown(
          data['application_fee']!,
          _applicationFeeMeta,
        ),
      );
    }
    if (data.containsKey('is_featured')) {
      context.handle(
        _isFeaturedMeta,
        isFeatured.isAcceptableOrUnknown(data['is_featured']!, _isFeaturedMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Program map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Program(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      universityId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}university_id'],
          )!,
      universityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}university_name'],
      ),
      level:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}level'],
          )!,
      studyMode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}study_mode'],
          )!,
      durationMonths:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}duration_months'],
          )!,
      language:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language'],
          )!,
      tuitionFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tuition_fee'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      applicationDeadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}application_deadline'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      requirements: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requirements'],
      ),
      curriculum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}curriculum'],
      ),
      careerOpportunities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}career_opportunities'],
      ),
      applicationFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}application_fee'],
      ),
      isFeatured:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_featured'],
          )!,
      lastUpdated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_updated'],
          )!,
    );
  }

  @override
  $ProgramsTable createAlias(String alias) {
    return $ProgramsTable(attachedDatabase, alias);
  }
}

class Program extends DataClass implements Insertable<Program> {
  final String id;
  final String name;
  final String universityId;
  final String? universityName;
  final String level;
  final String studyMode;
  final int durationMonths;
  final String language;
  final double? tuitionFee;
  final String? currency;
  final String? description;
  final DateTime? applicationDeadline;
  final DateTime? startDate;
  final String? requirements;
  final String? curriculum;
  final String? careerOpportunities;
  final double? applicationFee;
  final bool isFeatured;
  final DateTime lastUpdated;
  const Program({
    required this.id,
    required this.name,
    required this.universityId,
    this.universityName,
    required this.level,
    required this.studyMode,
    required this.durationMonths,
    required this.language,
    this.tuitionFee,
    this.currency,
    this.description,
    this.applicationDeadline,
    this.startDate,
    this.requirements,
    this.curriculum,
    this.careerOpportunities,
    this.applicationFee,
    required this.isFeatured,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['university_id'] = Variable<String>(universityId);
    if (!nullToAbsent || universityName != null) {
      map['university_name'] = Variable<String>(universityName);
    }
    map['level'] = Variable<String>(level);
    map['study_mode'] = Variable<String>(studyMode);
    map['duration_months'] = Variable<int>(durationMonths);
    map['language'] = Variable<String>(language);
    if (!nullToAbsent || tuitionFee != null) {
      map['tuition_fee'] = Variable<double>(tuitionFee);
    }
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || applicationDeadline != null) {
      map['application_deadline'] = Variable<DateTime>(applicationDeadline);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || requirements != null) {
      map['requirements'] = Variable<String>(requirements);
    }
    if (!nullToAbsent || curriculum != null) {
      map['curriculum'] = Variable<String>(curriculum);
    }
    if (!nullToAbsent || careerOpportunities != null) {
      map['career_opportunities'] = Variable<String>(careerOpportunities);
    }
    if (!nullToAbsent || applicationFee != null) {
      map['application_fee'] = Variable<double>(applicationFee);
    }
    map['is_featured'] = Variable<bool>(isFeatured);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  ProgramsCompanion toCompanion(bool nullToAbsent) {
    return ProgramsCompanion(
      id: Value(id),
      name: Value(name),
      universityId: Value(universityId),
      universityName:
          universityName == null && nullToAbsent
              ? const Value.absent()
              : Value(universityName),
      level: Value(level),
      studyMode: Value(studyMode),
      durationMonths: Value(durationMonths),
      language: Value(language),
      tuitionFee:
          tuitionFee == null && nullToAbsent
              ? const Value.absent()
              : Value(tuitionFee),
      currency:
          currency == null && nullToAbsent
              ? const Value.absent()
              : Value(currency),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      applicationDeadline:
          applicationDeadline == null && nullToAbsent
              ? const Value.absent()
              : Value(applicationDeadline),
      startDate:
          startDate == null && nullToAbsent
              ? const Value.absent()
              : Value(startDate),
      requirements:
          requirements == null && nullToAbsent
              ? const Value.absent()
              : Value(requirements),
      curriculum:
          curriculum == null && nullToAbsent
              ? const Value.absent()
              : Value(curriculum),
      careerOpportunities:
          careerOpportunities == null && nullToAbsent
              ? const Value.absent()
              : Value(careerOpportunities),
      applicationFee:
          applicationFee == null && nullToAbsent
              ? const Value.absent()
              : Value(applicationFee),
      isFeatured: Value(isFeatured),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory Program.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Program(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      universityId: serializer.fromJson<String>(json['universityId']),
      universityName: serializer.fromJson<String?>(json['universityName']),
      level: serializer.fromJson<String>(json['level']),
      studyMode: serializer.fromJson<String>(json['studyMode']),
      durationMonths: serializer.fromJson<int>(json['durationMonths']),
      language: serializer.fromJson<String>(json['language']),
      tuitionFee: serializer.fromJson<double?>(json['tuitionFee']),
      currency: serializer.fromJson<String?>(json['currency']),
      description: serializer.fromJson<String?>(json['description']),
      applicationDeadline: serializer.fromJson<DateTime?>(
        json['applicationDeadline'],
      ),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      requirements: serializer.fromJson<String?>(json['requirements']),
      curriculum: serializer.fromJson<String?>(json['curriculum']),
      careerOpportunities: serializer.fromJson<String?>(
        json['careerOpportunities'],
      ),
      applicationFee: serializer.fromJson<double?>(json['applicationFee']),
      isFeatured: serializer.fromJson<bool>(json['isFeatured']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'universityId': serializer.toJson<String>(universityId),
      'universityName': serializer.toJson<String?>(universityName),
      'level': serializer.toJson<String>(level),
      'studyMode': serializer.toJson<String>(studyMode),
      'durationMonths': serializer.toJson<int>(durationMonths),
      'language': serializer.toJson<String>(language),
      'tuitionFee': serializer.toJson<double?>(tuitionFee),
      'currency': serializer.toJson<String?>(currency),
      'description': serializer.toJson<String?>(description),
      'applicationDeadline': serializer.toJson<DateTime?>(applicationDeadline),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'requirements': serializer.toJson<String?>(requirements),
      'curriculum': serializer.toJson<String?>(curriculum),
      'careerOpportunities': serializer.toJson<String?>(careerOpportunities),
      'applicationFee': serializer.toJson<double?>(applicationFee),
      'isFeatured': serializer.toJson<bool>(isFeatured),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  Program copyWith({
    String? id,
    String? name,
    String? universityId,
    Value<String?> universityName = const Value.absent(),
    String? level,
    String? studyMode,
    int? durationMonths,
    String? language,
    Value<double?> tuitionFee = const Value.absent(),
    Value<String?> currency = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<DateTime?> applicationDeadline = const Value.absent(),
    Value<DateTime?> startDate = const Value.absent(),
    Value<String?> requirements = const Value.absent(),
    Value<String?> curriculum = const Value.absent(),
    Value<String?> careerOpportunities = const Value.absent(),
    Value<double?> applicationFee = const Value.absent(),
    bool? isFeatured,
    DateTime? lastUpdated,
  }) => Program(
    id: id ?? this.id,
    name: name ?? this.name,
    universityId: universityId ?? this.universityId,
    universityName:
        universityName.present ? universityName.value : this.universityName,
    level: level ?? this.level,
    studyMode: studyMode ?? this.studyMode,
    durationMonths: durationMonths ?? this.durationMonths,
    language: language ?? this.language,
    tuitionFee: tuitionFee.present ? tuitionFee.value : this.tuitionFee,
    currency: currency.present ? currency.value : this.currency,
    description: description.present ? description.value : this.description,
    applicationDeadline:
        applicationDeadline.present
            ? applicationDeadline.value
            : this.applicationDeadline,
    startDate: startDate.present ? startDate.value : this.startDate,
    requirements: requirements.present ? requirements.value : this.requirements,
    curriculum: curriculum.present ? curriculum.value : this.curriculum,
    careerOpportunities:
        careerOpportunities.present
            ? careerOpportunities.value
            : this.careerOpportunities,
    applicationFee:
        applicationFee.present ? applicationFee.value : this.applicationFee,
    isFeatured: isFeatured ?? this.isFeatured,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  Program copyWithCompanion(ProgramsCompanion data) {
    return Program(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      universityId:
          data.universityId.present
              ? data.universityId.value
              : this.universityId,
      universityName:
          data.universityName.present
              ? data.universityName.value
              : this.universityName,
      level: data.level.present ? data.level.value : this.level,
      studyMode: data.studyMode.present ? data.studyMode.value : this.studyMode,
      durationMonths:
          data.durationMonths.present
              ? data.durationMonths.value
              : this.durationMonths,
      language: data.language.present ? data.language.value : this.language,
      tuitionFee:
          data.tuitionFee.present ? data.tuitionFee.value : this.tuitionFee,
      currency: data.currency.present ? data.currency.value : this.currency,
      description:
          data.description.present ? data.description.value : this.description,
      applicationDeadline:
          data.applicationDeadline.present
              ? data.applicationDeadline.value
              : this.applicationDeadline,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      requirements:
          data.requirements.present
              ? data.requirements.value
              : this.requirements,
      curriculum:
          data.curriculum.present ? data.curriculum.value : this.curriculum,
      careerOpportunities:
          data.careerOpportunities.present
              ? data.careerOpportunities.value
              : this.careerOpportunities,
      applicationFee:
          data.applicationFee.present
              ? data.applicationFee.value
              : this.applicationFee,
      isFeatured:
          data.isFeatured.present ? data.isFeatured.value : this.isFeatured,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Program(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('universityId: $universityId, ')
          ..write('universityName: $universityName, ')
          ..write('level: $level, ')
          ..write('studyMode: $studyMode, ')
          ..write('durationMonths: $durationMonths, ')
          ..write('language: $language, ')
          ..write('tuitionFee: $tuitionFee, ')
          ..write('currency: $currency, ')
          ..write('description: $description, ')
          ..write('applicationDeadline: $applicationDeadline, ')
          ..write('startDate: $startDate, ')
          ..write('requirements: $requirements, ')
          ..write('curriculum: $curriculum, ')
          ..write('careerOpportunities: $careerOpportunities, ')
          ..write('applicationFee: $applicationFee, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    universityId,
    universityName,
    level,
    studyMode,
    durationMonths,
    language,
    tuitionFee,
    currency,
    description,
    applicationDeadline,
    startDate,
    requirements,
    curriculum,
    careerOpportunities,
    applicationFee,
    isFeatured,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Program &&
          other.id == this.id &&
          other.name == this.name &&
          other.universityId == this.universityId &&
          other.universityName == this.universityName &&
          other.level == this.level &&
          other.studyMode == this.studyMode &&
          other.durationMonths == this.durationMonths &&
          other.language == this.language &&
          other.tuitionFee == this.tuitionFee &&
          other.currency == this.currency &&
          other.description == this.description &&
          other.applicationDeadline == this.applicationDeadline &&
          other.startDate == this.startDate &&
          other.requirements == this.requirements &&
          other.curriculum == this.curriculum &&
          other.careerOpportunities == this.careerOpportunities &&
          other.applicationFee == this.applicationFee &&
          other.isFeatured == this.isFeatured &&
          other.lastUpdated == this.lastUpdated);
}

class ProgramsCompanion extends UpdateCompanion<Program> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> universityId;
  final Value<String?> universityName;
  final Value<String> level;
  final Value<String> studyMode;
  final Value<int> durationMonths;
  final Value<String> language;
  final Value<double?> tuitionFee;
  final Value<String?> currency;
  final Value<String?> description;
  final Value<DateTime?> applicationDeadline;
  final Value<DateTime?> startDate;
  final Value<String?> requirements;
  final Value<String?> curriculum;
  final Value<String?> careerOpportunities;
  final Value<double?> applicationFee;
  final Value<bool> isFeatured;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const ProgramsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.universityId = const Value.absent(),
    this.universityName = const Value.absent(),
    this.level = const Value.absent(),
    this.studyMode = const Value.absent(),
    this.durationMonths = const Value.absent(),
    this.language = const Value.absent(),
    this.tuitionFee = const Value.absent(),
    this.currency = const Value.absent(),
    this.description = const Value.absent(),
    this.applicationDeadline = const Value.absent(),
    this.startDate = const Value.absent(),
    this.requirements = const Value.absent(),
    this.curriculum = const Value.absent(),
    this.careerOpportunities = const Value.absent(),
    this.applicationFee = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgramsCompanion.insert({
    required String id,
    required String name,
    required String universityId,
    this.universityName = const Value.absent(),
    required String level,
    required String studyMode,
    required int durationMonths,
    required String language,
    this.tuitionFee = const Value.absent(),
    this.currency = const Value.absent(),
    this.description = const Value.absent(),
    this.applicationDeadline = const Value.absent(),
    this.startDate = const Value.absent(),
    this.requirements = const Value.absent(),
    this.curriculum = const Value.absent(),
    this.careerOpportunities = const Value.absent(),
    this.applicationFee = const Value.absent(),
    this.isFeatured = const Value.absent(),
    required DateTime lastUpdated,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       universityId = Value(universityId),
       level = Value(level),
       studyMode = Value(studyMode),
       durationMonths = Value(durationMonths),
       language = Value(language),
       lastUpdated = Value(lastUpdated);
  static Insertable<Program> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? universityId,
    Expression<String>? universityName,
    Expression<String>? level,
    Expression<String>? studyMode,
    Expression<int>? durationMonths,
    Expression<String>? language,
    Expression<double>? tuitionFee,
    Expression<String>? currency,
    Expression<String>? description,
    Expression<DateTime>? applicationDeadline,
    Expression<DateTime>? startDate,
    Expression<String>? requirements,
    Expression<String>? curriculum,
    Expression<String>? careerOpportunities,
    Expression<double>? applicationFee,
    Expression<bool>? isFeatured,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (universityId != null) 'university_id': universityId,
      if (universityName != null) 'university_name': universityName,
      if (level != null) 'level': level,
      if (studyMode != null) 'study_mode': studyMode,
      if (durationMonths != null) 'duration_months': durationMonths,
      if (language != null) 'language': language,
      if (tuitionFee != null) 'tuition_fee': tuitionFee,
      if (currency != null) 'currency': currency,
      if (description != null) 'description': description,
      if (applicationDeadline != null)
        'application_deadline': applicationDeadline,
      if (startDate != null) 'start_date': startDate,
      if (requirements != null) 'requirements': requirements,
      if (curriculum != null) 'curriculum': curriculum,
      if (careerOpportunities != null)
        'career_opportunities': careerOpportunities,
      if (applicationFee != null) 'application_fee': applicationFee,
      if (isFeatured != null) 'is_featured': isFeatured,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgramsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? universityId,
    Value<String?>? universityName,
    Value<String>? level,
    Value<String>? studyMode,
    Value<int>? durationMonths,
    Value<String>? language,
    Value<double?>? tuitionFee,
    Value<String?>? currency,
    Value<String?>? description,
    Value<DateTime?>? applicationDeadline,
    Value<DateTime?>? startDate,
    Value<String?>? requirements,
    Value<String?>? curriculum,
    Value<String?>? careerOpportunities,
    Value<double?>? applicationFee,
    Value<bool>? isFeatured,
    Value<DateTime>? lastUpdated,
    Value<int>? rowid,
  }) {
    return ProgramsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      universityId: universityId ?? this.universityId,
      universityName: universityName ?? this.universityName,
      level: level ?? this.level,
      studyMode: studyMode ?? this.studyMode,
      durationMonths: durationMonths ?? this.durationMonths,
      language: language ?? this.language,
      tuitionFee: tuitionFee ?? this.tuitionFee,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      startDate: startDate ?? this.startDate,
      requirements: requirements ?? this.requirements,
      curriculum: curriculum ?? this.curriculum,
      careerOpportunities: careerOpportunities ?? this.careerOpportunities,
      applicationFee: applicationFee ?? this.applicationFee,
      isFeatured: isFeatured ?? this.isFeatured,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (universityId.present) {
      map['university_id'] = Variable<String>(universityId.value);
    }
    if (universityName.present) {
      map['university_name'] = Variable<String>(universityName.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (studyMode.present) {
      map['study_mode'] = Variable<String>(studyMode.value);
    }
    if (durationMonths.present) {
      map['duration_months'] = Variable<int>(durationMonths.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (tuitionFee.present) {
      map['tuition_fee'] = Variable<double>(tuitionFee.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (applicationDeadline.present) {
      map['application_deadline'] = Variable<DateTime>(
        applicationDeadline.value,
      );
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (requirements.present) {
      map['requirements'] = Variable<String>(requirements.value);
    }
    if (curriculum.present) {
      map['curriculum'] = Variable<String>(curriculum.value);
    }
    if (careerOpportunities.present) {
      map['career_opportunities'] = Variable<String>(careerOpportunities.value);
    }
    if (applicationFee.present) {
      map['application_fee'] = Variable<double>(applicationFee.value);
    }
    if (isFeatured.present) {
      map['is_featured'] = Variable<bool>(isFeatured.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('universityId: $universityId, ')
          ..write('universityName: $universityName, ')
          ..write('level: $level, ')
          ..write('studyMode: $studyMode, ')
          ..write('durationMonths: $durationMonths, ')
          ..write('language: $language, ')
          ..write('tuitionFee: $tuitionFee, ')
          ..write('currency: $currency, ')
          ..write('description: $description, ')
          ..write('applicationDeadline: $applicationDeadline, ')
          ..write('startDate: $startDate, ')
          ..write('requirements: $requirements, ')
          ..write('curriculum: $curriculum, ')
          ..write('careerOpportunities: $careerOpportunities, ')
          ..write('applicationFee: $applicationFee, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, itemId, itemType, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {itemId, itemType},
  ];
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      itemId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}item_id'],
          )!,
      itemType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}item_type'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final String itemId;
  final String itemType;
  final DateTime createdAt;
  const Bookmark({
    required this.id,
    required this.itemId,
    required this.itemType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<String>(itemId);
    map['item_type'] = Variable<String>(itemType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      itemId: Value(itemId),
      itemType: Value(itemType),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<String>(itemId),
      'itemType': serializer.toJson<String>(itemType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith({
    int? id,
    String? itemId,
    String? itemType,
    DateTime? createdAt,
  }) => Bookmark(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    itemType: itemType ?? this.itemType,
    createdAt: createdAt ?? this.createdAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('itemType: $itemType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, itemType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.itemType == this.itemType &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<String> itemId;
  final Value<String> itemType;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required String itemId,
    required String itemType,
    required DateTime createdAt,
  }) : itemId = Value(itemId),
       itemType = Value(itemType),
       createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<String>? itemId,
    Expression<String>? itemType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (itemType != null) 'item_type': itemType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<String>? itemId,
    Value<String>? itemType,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      itemType: itemType ?? this.itemType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('itemType: $itemType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileImageMeta = const VerificationMeta(
    'profileImage',
  );
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
    'profile_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEmailVerifiedMeta = const VerificationMeta(
    'isEmailVerified',
  );
  @override
  late final GeneratedColumn<bool> isEmailVerified = GeneratedColumn<bool>(
    'is_email_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_email_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _authTokenMeta = const VerificationMeta(
    'authToken',
  );
  @override
  late final GeneratedColumn<String> authToken = GeneratedColumn<String>(
    'auth_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastLoggedInMeta = const VerificationMeta(
    'lastLoggedIn',
  );
  @override
  late final GeneratedColumn<DateTime> lastLoggedIn = GeneratedColumn<DateTime>(
    'last_logged_in',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    firstName,
    lastName,
    profileImage,
    phoneNumber,
    createdAt,
    isEmailVerified,
    authToken,
    lastLoggedIn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('profile_image')) {
      context.handle(
        _profileImageMeta,
        profileImage.isAcceptableOrUnknown(
          data['profile_image']!,
          _profileImageMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_email_verified')) {
      context.handle(
        _isEmailVerifiedMeta,
        isEmailVerified.isAcceptableOrUnknown(
          data['is_email_verified']!,
          _isEmailVerifiedMeta,
        ),
      );
    }
    if (data.containsKey('auth_token')) {
      context.handle(
        _authTokenMeta,
        authToken.isAcceptableOrUnknown(data['auth_token']!, _authTokenMeta),
      );
    }
    if (data.containsKey('last_logged_in')) {
      context.handle(
        _lastLoggedInMeta,
        lastLoggedIn.isAcceptableOrUnknown(
          data['last_logged_in']!,
          _lastLoggedInMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastLoggedInMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      firstName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}first_name'],
          )!,
      lastName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}last_name'],
          )!,
      profileImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_image'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      isEmailVerified:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_email_verified'],
          )!,
      authToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_token'],
      ),
      lastLoggedIn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_logged_in'],
          )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImage;
  final String? phoneNumber;
  final DateTime createdAt;
  final bool isEmailVerified;
  final String? authToken;
  final DateTime lastLoggedIn;
  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    this.phoneNumber,
    required this.createdAt,
    required this.isEmailVerified,
    this.authToken,
    required this.lastLoggedIn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_email_verified'] = Variable<bool>(isEmailVerified);
    if (!nullToAbsent || authToken != null) {
      map['auth_token'] = Variable<String>(authToken);
    }
    map['last_logged_in'] = Variable<DateTime>(lastLoggedIn);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      firstName: Value(firstName),
      lastName: Value(lastName),
      profileImage:
          profileImage == null && nullToAbsent
              ? const Value.absent()
              : Value(profileImage),
      phoneNumber:
          phoneNumber == null && nullToAbsent
              ? const Value.absent()
              : Value(phoneNumber),
      createdAt: Value(createdAt),
      isEmailVerified: Value(isEmailVerified),
      authToken:
          authToken == null && nullToAbsent
              ? const Value.absent()
              : Value(authToken),
      lastLoggedIn: Value(lastLoggedIn),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isEmailVerified: serializer.fromJson<bool>(json['isEmailVerified']),
      authToken: serializer.fromJson<String?>(json['authToken']),
      lastLoggedIn: serializer.fromJson<DateTime>(json['lastLoggedIn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'profileImage': serializer.toJson<String?>(profileImage),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isEmailVerified': serializer.toJson<bool>(isEmailVerified),
      'authToken': serializer.toJson<String?>(authToken),
      'lastLoggedIn': serializer.toJson<DateTime>(lastLoggedIn),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    Value<String?> profileImage = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    DateTime? createdAt,
    bool? isEmailVerified,
    Value<String?> authToken = const Value.absent(),
    DateTime? lastLoggedIn,
  }) => User(
    id: id ?? this.id,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    profileImage: profileImage.present ? profileImage.value : this.profileImage,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    createdAt: createdAt ?? this.createdAt,
    isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    authToken: authToken.present ? authToken.value : this.authToken,
    lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      profileImage:
          data.profileImage.present
              ? data.profileImage.value
              : this.profileImage,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isEmailVerified:
          data.isEmailVerified.present
              ? data.isEmailVerified.value
              : this.isEmailVerified,
      authToken: data.authToken.present ? data.authToken.value : this.authToken,
      lastLoggedIn:
          data.lastLoggedIn.present
              ? data.lastLoggedIn.value
              : this.lastLoggedIn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('profileImage: $profileImage, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('isEmailVerified: $isEmailVerified, ')
          ..write('authToken: $authToken, ')
          ..write('lastLoggedIn: $lastLoggedIn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    email,
    firstName,
    lastName,
    profileImage,
    phoneNumber,
    createdAt,
    isEmailVerified,
    authToken,
    lastLoggedIn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.profileImage == this.profileImage &&
          other.phoneNumber == this.phoneNumber &&
          other.createdAt == this.createdAt &&
          other.isEmailVerified == this.isEmailVerified &&
          other.authToken == this.authToken &&
          other.lastLoggedIn == this.lastLoggedIn);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> profileImage;
  final Value<String?> phoneNumber;
  final Value<DateTime> createdAt;
  final Value<bool> isEmailVerified;
  final Value<String?> authToken;
  final Value<DateTime> lastLoggedIn;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isEmailVerified = const Value.absent(),
    this.authToken = const Value.absent(),
    this.lastLoggedIn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    this.profileImage = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    required DateTime createdAt,
    this.isEmailVerified = const Value.absent(),
    this.authToken = const Value.absent(),
    required DateTime lastLoggedIn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       firstName = Value(firstName),
       lastName = Value(lastName),
       createdAt = Value(createdAt),
       lastLoggedIn = Value(lastLoggedIn);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? profileImage,
    Expression<String>? phoneNumber,
    Expression<DateTime>? createdAt,
    Expression<bool>? isEmailVerified,
    Expression<String>? authToken,
    Expression<DateTime>? lastLoggedIn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (profileImage != null) 'profile_image': profileImage,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (isEmailVerified != null) 'is_email_verified': isEmailVerified,
      if (authToken != null) 'auth_token': authToken,
      if (lastLoggedIn != null) 'last_logged_in': lastLoggedIn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String?>? profileImage,
    Value<String?>? phoneNumber,
    Value<DateTime>? createdAt,
    Value<bool>? isEmailVerified,
    Value<String?>? authToken,
    Value<DateTime>? lastLoggedIn,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      authToken: authToken ?? this.authToken,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isEmailVerified.present) {
      map['is_email_verified'] = Variable<bool>(isEmailVerified.value);
    }
    if (authToken.present) {
      map['auth_token'] = Variable<String>(authToken.value);
    }
    if (lastLoggedIn.present) {
      map['last_logged_in'] = Variable<DateTime>(lastLoggedIn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('profileImage: $profileImage, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('isEmailVerified: $isEmailVerified, ')
          ..write('authToken: $authToken, ')
          ..write('lastLoggedIn: $lastLoggedIn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UniversitiesTable universities = $UniversitiesTable(this);
  late final $ProgramsTable programs = $ProgramsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    universities,
    programs,
    bookmarks,
    users,
  ];
}

typedef $$UniversitiesTableCreateCompanionBuilder =
    UniversitiesCompanion Function({
      required String id,
      required String name,
      required String country,
      required String city,
      Value<String?> logoUrl,
      Value<String?> coverImageUrl,
      Value<int?> foundedYear,
      Value<String?> description,
      Value<String?> ranking,
      Value<String?> facilities,
      Value<String?> websiteUrl,
      Value<String?> contactEmail,
      Value<String?> contactPhone,
      Value<bool> isFeatured,
      required DateTime lastUpdated,
      Value<int> rowid,
    });
typedef $$UniversitiesTableUpdateCompanionBuilder =
    UniversitiesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> country,
      Value<String> city,
      Value<String?> logoUrl,
      Value<String?> coverImageUrl,
      Value<int?> foundedYear,
      Value<String?> description,
      Value<String?> ranking,
      Value<String?> facilities,
      Value<String?> websiteUrl,
      Value<String?> contactEmail,
      Value<String?> contactPhone,
      Value<bool> isFeatured,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });

class $$UniversitiesTableFilterComposer
    extends Composer<_$AppDatabase, $UniversitiesTable> {
  $$UniversitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImageUrl => $composableBuilder(
    column: $table.coverImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get foundedYear => $composableBuilder(
    column: $table.foundedYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ranking => $composableBuilder(
    column: $table.ranking,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get facilities => $composableBuilder(
    column: $table.facilities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get websiteUrl => $composableBuilder(
    column: $table.websiteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UniversitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $UniversitiesTable> {
  $$UniversitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImageUrl => $composableBuilder(
    column: $table.coverImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get foundedYear => $composableBuilder(
    column: $table.foundedYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ranking => $composableBuilder(
    column: $table.ranking,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facilities => $composableBuilder(
    column: $table.facilities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get websiteUrl => $composableBuilder(
    column: $table.websiteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UniversitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UniversitiesTable> {
  $$UniversitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get coverImageUrl => $composableBuilder(
    column: $table.coverImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get foundedYear => $composableBuilder(
    column: $table.foundedYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ranking =>
      $composableBuilder(column: $table.ranking, builder: (column) => column);

  GeneratedColumn<String> get facilities => $composableBuilder(
    column: $table.facilities,
    builder: (column) => column,
  );

  GeneratedColumn<String> get websiteUrl => $composableBuilder(
    column: $table.websiteUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$UniversitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UniversitiesTable,
          University,
          $$UniversitiesTableFilterComposer,
          $$UniversitiesTableOrderingComposer,
          $$UniversitiesTableAnnotationComposer,
          $$UniversitiesTableCreateCompanionBuilder,
          $$UniversitiesTableUpdateCompanionBuilder,
          (
            University,
            BaseReferences<_$AppDatabase, $UniversitiesTable, University>,
          ),
          University,
          PrefetchHooks Function()
        > {
  $$UniversitiesTableTableManager(_$AppDatabase db, $UniversitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UniversitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UniversitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$UniversitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> coverImageUrl = const Value.absent(),
                Value<int?> foundedYear = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> ranking = const Value.absent(),
                Value<String?> facilities = const Value.absent(),
                Value<String?> websiteUrl = const Value.absent(),
                Value<String?> contactEmail = const Value.absent(),
                Value<String?> contactPhone = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UniversitiesCompanion(
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
                isFeatured: isFeatured,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String country,
                required String city,
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> coverImageUrl = const Value.absent(),
                Value<int?> foundedYear = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> ranking = const Value.absent(),
                Value<String?> facilities = const Value.absent(),
                Value<String?> websiteUrl = const Value.absent(),
                Value<String?> contactEmail = const Value.absent(),
                Value<String?> contactPhone = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                required DateTime lastUpdated,
                Value<int> rowid = const Value.absent(),
              }) => UniversitiesCompanion.insert(
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
                isFeatured: isFeatured,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UniversitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UniversitiesTable,
      University,
      $$UniversitiesTableFilterComposer,
      $$UniversitiesTableOrderingComposer,
      $$UniversitiesTableAnnotationComposer,
      $$UniversitiesTableCreateCompanionBuilder,
      $$UniversitiesTableUpdateCompanionBuilder,
      (
        University,
        BaseReferences<_$AppDatabase, $UniversitiesTable, University>,
      ),
      University,
      PrefetchHooks Function()
    >;
typedef $$ProgramsTableCreateCompanionBuilder =
    ProgramsCompanion Function({
      required String id,
      required String name,
      required String universityId,
      Value<String?> universityName,
      required String level,
      required String studyMode,
      required int durationMonths,
      required String language,
      Value<double?> tuitionFee,
      Value<String?> currency,
      Value<String?> description,
      Value<DateTime?> applicationDeadline,
      Value<DateTime?> startDate,
      Value<String?> requirements,
      Value<String?> curriculum,
      Value<String?> careerOpportunities,
      Value<double?> applicationFee,
      Value<bool> isFeatured,
      required DateTime lastUpdated,
      Value<int> rowid,
    });
typedef $$ProgramsTableUpdateCompanionBuilder =
    ProgramsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> universityId,
      Value<String?> universityName,
      Value<String> level,
      Value<String> studyMode,
      Value<int> durationMonths,
      Value<String> language,
      Value<double?> tuitionFee,
      Value<String?> currency,
      Value<String?> description,
      Value<DateTime?> applicationDeadline,
      Value<DateTime?> startDate,
      Value<String?> requirements,
      Value<String?> curriculum,
      Value<String?> careerOpportunities,
      Value<double?> applicationFee,
      Value<bool> isFeatured,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });

class $$ProgramsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universityName => $composableBuilder(
    column: $table.universityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studyMode => $composableBuilder(
    column: $table.studyMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMonths => $composableBuilder(
    column: $table.durationMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get applicationDeadline => $composableBuilder(
    column: $table.applicationDeadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requirements => $composableBuilder(
    column: $table.requirements,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get curriculum => $composableBuilder(
    column: $table.curriculum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get careerOpportunities => $composableBuilder(
    column: $table.careerOpportunities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get applicationFee => $composableBuilder(
    column: $table.applicationFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgramsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universityName => $composableBuilder(
    column: $table.universityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studyMode => $composableBuilder(
    column: $table.studyMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMonths => $composableBuilder(
    column: $table.durationMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get applicationDeadline => $composableBuilder(
    column: $table.applicationDeadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requirements => $composableBuilder(
    column: $table.requirements,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get curriculum => $composableBuilder(
    column: $table.curriculum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get careerOpportunities => $composableBuilder(
    column: $table.careerOpportunities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get applicationFee => $composableBuilder(
    column: $table.applicationFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgramsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get universityName => $composableBuilder(
    column: $table.universityName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get studyMode =>
      $composableBuilder(column: $table.studyMode, builder: (column) => column);

  GeneratedColumn<int> get durationMonths => $composableBuilder(
    column: $table.durationMonths,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<double> get tuitionFee => $composableBuilder(
    column: $table.tuitionFee,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get applicationDeadline => $composableBuilder(
    column: $table.applicationDeadline,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get requirements => $composableBuilder(
    column: $table.requirements,
    builder: (column) => column,
  );

  GeneratedColumn<String> get curriculum => $composableBuilder(
    column: $table.curriculum,
    builder: (column) => column,
  );

  GeneratedColumn<String> get careerOpportunities => $composableBuilder(
    column: $table.careerOpportunities,
    builder: (column) => column,
  );

  GeneratedColumn<double> get applicationFee => $composableBuilder(
    column: $table.applicationFee,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$ProgramsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramsTable,
          Program,
          $$ProgramsTableFilterComposer,
          $$ProgramsTableOrderingComposer,
          $$ProgramsTableAnnotationComposer,
          $$ProgramsTableCreateCompanionBuilder,
          $$ProgramsTableUpdateCompanionBuilder,
          (Program, BaseReferences<_$AppDatabase, $ProgramsTable, Program>),
          Program,
          PrefetchHooks Function()
        > {
  $$ProgramsTableTableManager(_$AppDatabase db, $ProgramsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ProgramsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ProgramsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ProgramsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> universityId = const Value.absent(),
                Value<String?> universityName = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> studyMode = const Value.absent(),
                Value<int> durationMonths = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<double?> tuitionFee = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> applicationDeadline = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<String?> requirements = const Value.absent(),
                Value<String?> curriculum = const Value.absent(),
                Value<String?> careerOpportunities = const Value.absent(),
                Value<double?> applicationFee = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgramsCompanion(
                id: id,
                name: name,
                universityId: universityId,
                universityName: universityName,
                level: level,
                studyMode: studyMode,
                durationMonths: durationMonths,
                language: language,
                tuitionFee: tuitionFee,
                currency: currency,
                description: description,
                applicationDeadline: applicationDeadline,
                startDate: startDate,
                requirements: requirements,
                curriculum: curriculum,
                careerOpportunities: careerOpportunities,
                applicationFee: applicationFee,
                isFeatured: isFeatured,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String universityId,
                Value<String?> universityName = const Value.absent(),
                required String level,
                required String studyMode,
                required int durationMonths,
                required String language,
                Value<double?> tuitionFee = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> applicationDeadline = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<String?> requirements = const Value.absent(),
                Value<String?> curriculum = const Value.absent(),
                Value<String?> careerOpportunities = const Value.absent(),
                Value<double?> applicationFee = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                required DateTime lastUpdated,
                Value<int> rowid = const Value.absent(),
              }) => ProgramsCompanion.insert(
                id: id,
                name: name,
                universityId: universityId,
                universityName: universityName,
                level: level,
                studyMode: studyMode,
                durationMonths: durationMonths,
                language: language,
                tuitionFee: tuitionFee,
                currency: currency,
                description: description,
                applicationDeadline: applicationDeadline,
                startDate: startDate,
                requirements: requirements,
                curriculum: curriculum,
                careerOpportunities: careerOpportunities,
                applicationFee: applicationFee,
                isFeatured: isFeatured,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgramsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramsTable,
      Program,
      $$ProgramsTableFilterComposer,
      $$ProgramsTableOrderingComposer,
      $$ProgramsTableAnnotationComposer,
      $$ProgramsTableCreateCompanionBuilder,
      $$ProgramsTableUpdateCompanionBuilder,
      (Program, BaseReferences<_$AppDatabase, $ProgramsTable, Program>),
      Program,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required String itemId,
      required String itemType,
      required DateTime createdAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<String> itemId,
      Value<String> itemType,
      Value<DateTime> createdAt,
    });

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
          Bookmark,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                itemId: itemId,
                itemType: itemType,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String itemId,
                required String itemType,
                required DateTime createdAt,
              }) => BookmarksCompanion.insert(
                id: id,
                itemId: itemId,
                itemType: itemType,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String email,
      required String firstName,
      required String lastName,
      Value<String?> profileImage,
      Value<String?> phoneNumber,
      required DateTime createdAt,
      Value<bool> isEmailVerified,
      Value<String?> authToken,
      required DateTime lastLoggedIn,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> email,
      Value<String> firstName,
      Value<String> lastName,
      Value<String?> profileImage,
      Value<String?> phoneNumber,
      Value<DateTime> createdAt,
      Value<bool> isEmailVerified,
      Value<String?> authToken,
      Value<DateTime> lastLoggedIn,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEmailVerified => $composableBuilder(
    column: $table.isEmailVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authToken => $composableBuilder(
    column: $table.authToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastLoggedIn => $composableBuilder(
    column: $table.lastLoggedIn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEmailVerified => $composableBuilder(
    column: $table.isEmailVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authToken => $composableBuilder(
    column: $table.authToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastLoggedIn => $composableBuilder(
    column: $table.lastLoggedIn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isEmailVerified => $composableBuilder(
    column: $table.isEmailVerified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authToken =>
      $composableBuilder(column: $table.authToken, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLoggedIn => $composableBuilder(
    column: $table.lastLoggedIn,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isEmailVerified = const Value.absent(),
                Value<String?> authToken = const Value.absent(),
                Value<DateTime> lastLoggedIn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                email: email,
                firstName: firstName,
                lastName: lastName,
                profileImage: profileImage,
                phoneNumber: phoneNumber,
                createdAt: createdAt,
                isEmailVerified: isEmailVerified,
                authToken: authToken,
                lastLoggedIn: lastLoggedIn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                required String firstName,
                required String lastName,
                Value<String?> profileImage = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isEmailVerified = const Value.absent(),
                Value<String?> authToken = const Value.absent(),
                required DateTime lastLoggedIn,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                email: email,
                firstName: firstName,
                lastName: lastName,
                profileImage: profileImage,
                phoneNumber: phoneNumber,
                createdAt: createdAt,
                isEmailVerified: isEmailVerified,
                authToken: authToken,
                lastLoggedIn: lastLoggedIn,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UniversitiesTableTableManager get universities =>
      $$UniversitiesTableTableManager(_db, _db.universities);
  $$ProgramsTableTableManager get programs =>
      $$ProgramsTableTableManager(_db, _db.programs);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
