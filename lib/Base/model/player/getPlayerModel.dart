class GetPlayer {
  final int id;
  final int teamId;
  final String firstName;
  final String lastName;
  final String jerseyNumber;
  final String email;
  final Stats? stats;
  final TeamP? team;

  GetPlayer({
    required this.id,
    required this.teamId,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.email,
    this.stats,
    this.team,
  });

  factory GetPlayer.fromJson(Map<String, dynamic> json) {
    return GetPlayer(
      id: json['id'] ?? 0,
      teamId: json['team_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      jerseyNumber: json['jersey_number'] ?? '',
      email: json['email'] ?? '',
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
      team: json['team'] != null ? TeamP.fromJson(json['team']) : null,
    );
  }
}

class Stats {
  final double? pctInningsPlayed;
  final String? topPosition;
  final double? avgBattingLoc;
  final Map<String, int>? positionCounts;

  Stats({
    this.pctInningsPlayed,
    this.topPosition,
    this.avgBattingLoc,
    this.positionCounts,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      pctInningsPlayed: (json['pct_innings_played'] as num?)?.toDouble(),
      topPosition: json['top_position'],
      avgBattingLoc: (json['avg_batting_loc'] as num?)?.toDouble(),
      positionCounts: json['position_counts'] != null
          ? Map<String, int>.from(json['position_counts'])
          : null,
    );
  }
}

class TeamP {
  final int id;
  final int userId;
  final int organizationId;
  final String name;
  final String season;
  final int year;
  final String sportType;
  final String teamType;
  final String ageGroup;
  final String city;
  final String state;
  final String accessStatus;
  final String? accessExpiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  TeamP({
    required this.id,
    required this.userId,
    required this.organizationId,
    required this.name,
    required this.season,
    required this.year,
    required this.sportType,
    required this.teamType,
    required this.ageGroup,
    required this.city,
    required this.state,
    required this.accessStatus,
    this.accessExpiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeamP.fromJson(Map<String, dynamic> json) {
    return TeamP(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      organizationId: json['organization_id'] ?? 0,
      name: json['name'] ?? '',
      season: json['season'] ?? '',
      year: json['year'] ?? 0,
      sportType: json['sport_type'] ?? '',
      teamType: json['team_type'] ?? '',
      ageGroup: json['age_group'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      accessStatus: json['access_status'] ?? '',
      accessExpiresAt: json['access_expires_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
