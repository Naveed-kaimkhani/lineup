// class OrgTeamModel {
//   final int id;
//   final String name;

//   final String ageGroup;

//   final String year;
//   final String season;
//   final String city;
//   final String state;
//   // final String country;

//   OrgTeamModel({
//     required this.id,
//     required this.name,
//     required this.season,
//     required this.year,
//     required this.city,
//     required this.ageGroup,
//     required this.state,
//     // required this.country,
//   });

//   factory OrgTeamModel.fromJson(Map<String, dynamic> json) {
//     return OrgTeamModel(
//       id: json['id'],
//       name: json['name'],
//       season: json['season'],

//       year: json['year'].toString(), // ✅ Convert to string for consistency
//       ageGroup: json['age_group'],
//       city: json['city'],
//       state: json['state'],
//       // country: json['country'],
//     );
//   }
// }

class OrgTeamModel {
  final int id;
  final String name;
  final String? season;
  final int? year;
  final String ageGroup;
  final String city;
  final String state;
  final String country;

  // Optional: add more fields if needed
  final String sportType;
  final String teamType;
  final String directActivationStatus;

  OrgTeamModel({
    required this.id,
    required this.name,
    this.season,
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
    );
  }
}
