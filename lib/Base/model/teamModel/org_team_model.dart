import 'dart:developer';

class OrgTeamModel {
  final int id;
  final String name;
  final String? season;
  final int? year;
  final String ageGroup;
  final String? city;
  final String? state;
  final String? country;
  final String sportType;
  final String teamType;
  final String directActivationStatus;
  final OrganizationModel? organization; // ✅ New field

  OrgTeamModel({
    required this.id,
    required this.name,
    this.season,
        this.organization,

    this.year,
    required this.ageGroup,
    required this.city,
    required this.state,
    required this.country,
    required this.sportType,
    required this.teamType,
    required this.directActivationStatus,
  });

  factory OrgTeamModel.fromJson(Map<String, dynamic> json) {

    return OrgTeamModel(
      id: json['id'],
      name: json['name'],
      season: json['season'],
      year: json['year'], // nullable int
      ageGroup: json['age_group'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      sportType: json['sport_type'],
      teamType: json['team_type'],
      directActivationStatus: json['direct_activation_status'],

       organization: json['organization'] != null
          ? OrganizationModel.fromJson(json['organization'])
          : null,
    );
  }
}



class OrganizationModel {
  final int id;
  final String name;
  final String email;
  final String organizationCode;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.organizationCode,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      organizationCode: json['organization_code'],
    );
  }
}
