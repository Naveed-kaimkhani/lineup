class OrgTeamModel {
  final int id;
  final String name;

  final String ageGroup;

  final String year;
  final String season;
  final String city;
  final String state;
  final String country;

  OrgTeamModel({
    required this.id,
    required this.name,
    required this.season,
    required this.year,
    required this.city,
    required this.ageGroup,
    required this.state,
    required this.country,
  });

  factory OrgTeamModel.fromJson(Map<String, dynamic> json) {
    return OrgTeamModel(
      id: json['id'],
      name: json['name'],
      season: json['season'],

      year: json['year'].toString(), // ✅ Convert to string for consistency
      ageGroup: json['age_group'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}
