import 'dart:developer';

import '../orgnization.dart';

class CreateTeam {
  String name;
  String sportType;
  String teamType;
  String ageGroup;
  String? season; // Nullable field
  int year;
  String? city;  // Nullable field
  String? state; // Nullable field
  String organizationId;

  CreateTeam({
    required this.name,
    required this.sportType,
    required this.teamType,
    required this.ageGroup,
    this.season,  // Optional field
    required this.year,
    this.city,  // Optional field
    this.state, // Optional field
    required this.organizationId,
  });

  factory CreateTeam.fromJson(Map<String, dynamic> json) {
    debugger();
    return CreateTeam(
      name: json['name'] as String,
      sportType: json['sport_type'] as String,
      teamType: json['team_type'] as String,
      ageGroup: json['age_group'] as String,
      season: json['season'] as String?, // Optional field
      year: json['year'] as int? ?? 0, // Default value if missing
      city: json['city'] as String?, // Optional field
      state: json['state'] as String?, // Optional field
      organizationId: json['organization_code'] , // Default value if missing
    );
  }


  // Method to convert CreateTeam instance back to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sport_type': sportType,
      'team_type': teamType,
      'age_group': ageGroup,
      'season': season, // Nullable field
      'year': year,
      'city': city, // Nullable field
      'state': state, // Nullable field
      'organization_code': organizationId,
    };
  }
}

class CreateTeamResponse {
  final int? id;
  final String? name;
  final String? season;
  final int? year;
  final String? sportType;
  final String? teamType;
  final String? ageGroup;
  final String? city;
  final String? state;
  final int? organizationId;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final Organization? organization;

  CreateTeamResponse({
    this.id,
    this.name,
    this.season,
    this.year,
    this.sportType,
    this.teamType,
    this.ageGroup,
    this.city,
    this.state,
    this.organizationId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.organization,
  });

  factory CreateTeamResponse.fromJson(Map<String, dynamic> json) {
    return CreateTeamResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      season: json['season'] as String?,
      year: json['year'] as int?,
      sportType: json['sport_type'] as String?,
      teamType: json['team_type'] as String?,
      ageGroup: json['age_group'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      organizationId: json['organization_id'] as int?,
      userId: json['user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      organization: json['organization'] != null
          ? Organization.fromJson(json['organization'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'season': season,
      'year': year,
      'sport_type': sportType,
      'team_type': teamType,
      'age_group': ageGroup,
      'city': city,
      'state': state,
      'organization_id': organizationId,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'organization': organization?.toJson(),
    };
  }
}
