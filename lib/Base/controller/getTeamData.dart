class TeamData {
  final int? id;
  final int? userId;
  final int? organizationId;
  final String? name;
  final String? season;
  final int? year;
  final String? sportType;
  final String? teamType;
  final String? ageGroup;
  final String? city;
  final String? state;
  final String? accessStatus;
  final DateTime? accessExpiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TeamOrganization? organization;
  final List<TeamGame>? games;
  final List<TeamPlayer>? players;

  TeamData({
  this.id,
    this.userId,
    this.organizationId,
   this.name,
     this.season,
     this.year,
     this.sportType,
    this.teamType,
     this.ageGroup,
    this.city,
     this.state,
     this.accessStatus,
     this.accessExpiresAt,
     this.createdAt,
   this.updatedAt,
     this.organization,
    this.games,
     this.players,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
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
    accessExpiresAt: json['access_expires_at'] != null
        ? DateTime.tryParse(json['access_expires_at']) ?? DateTime.now()
        : DateTime.now(),
    createdAt:
    DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    updatedAt:
    DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    organization:
    TeamOrganization.fromJson(json['organization'] ?? {}),
    games: (json['games'] as List<dynamic>? ?? [])
        .map((e) => TeamGame.fromJson(e))
        .toList(),
    players: (json['players'] as List<dynamic>? ?? [])
        .map((e) => TeamPlayer.fromJson(e))
        .toList(),
  );


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'organization_id': organizationId,
      'name': name,
      'season': season,
      'year': year,
      'sport_type': sportType,
      'team_type': teamType,
      'age_group': ageGroup,
      'city': city,
      'state': state,
      'access_status': accessStatus,
      'access_expires_at': accessExpiresAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'organization': organization?.toJson(),
      'games': games?.map((e) => e.toJson()).toList(),
      'players': players?.map((e) => e.toJson()).toList(),
    };
  }




}

class TeamOrganization {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  TeamOrganization({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeamOrganization.fromJson(Map<String, dynamic> json) =>
      TeamOrganization(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        createdAt:
        DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
        updatedAt:
        DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      );


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

}

class TeamGame {
  final int id;
  final int teamId;
  final String opponentName;
  final DateTime gameDate;
  final int innings;
  final String locationType;
  final List<LineupData> lineupData;
  final DateTime submittedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  TeamGame({
    required this.id,
    required this.teamId,
    required this.opponentName,
    required this.gameDate,
    required this.innings,
    required this.locationType,
    required this.lineupData,
    required this.submittedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeamGame.fromJson(Map<String, dynamic> json) => TeamGame(
    id: json['id'] ?? 0,
    teamId: json['team_id'] ?? 0,
    opponentName: json['opponent_name'] ?? '',
    gameDate:
    DateTime.tryParse(json['game_date'] ?? '') ?? DateTime.now(),
    innings: json['innings'] ?? 0,
    locationType: json['location_type'] ?? '',
    lineupData: (json['lineup_data'] as List<dynamic>? ?? [])
        .map((e) => LineupData.fromJson(e))
        .toList(),
    submittedAt: json['submitted_at'] != null
        ? DateTime.tryParse(json['submitted_at']) ?? DateTime.now()
        : DateTime.now(),
    createdAt:
    DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    updatedAt:
    DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
  );


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_id': teamId,
      'opponent_name': opponentName,
      'game_date': gameDate.toIso8601String(),
      'innings': innings,
      'location_type': locationType,
      'lineup_data': lineupData.map((e) => e.toJson()).toList(),
      'submitted_at': submittedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class LineupData {
  final Map<String, String> innings;
  final String playerId;

  LineupData({required this.innings, required this.playerId});

  factory LineupData.fromJson(Map<String, dynamic> json) => LineupData(
    innings: (json['innings'] as Map<String, dynamic>? ?? {})
        .map((k, v) => MapEntry(k, v?.toString() ?? '')),
    playerId: json['player_id'] ?? '',
  );
  Map<String, dynamic> toJson() {
    return {
      'innings': innings,
      'player_id': playerId,
    };
  }

}

class TeamPlayer {
  final int id;
  final int teamId;
  final String firstName;
  final String lastName;
  final String jerseyNumber;
  final String email;
  final String phone;
  final PlayerStats stats;
  final TeamInfo team;

  TeamPlayer({
    required this.id,
    required this.teamId,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.email,
    required this.phone,
    required this.stats,
    required this.team,
  });

  factory TeamPlayer.fromJson(Map<String, dynamic> json) => TeamPlayer(
    id: json['id'] ?? 0,
    teamId: json['team_id'] ?? 0,
    firstName: json['first_name'] ?? '',
    lastName: json['last_name'] ?? '',
    jerseyNumber: json['jersey_number'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    stats: PlayerStats.fromJson(json['stats'] ?? {}),
    team: TeamInfo.fromJson(json['team'] ?? {}),
  );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_id': teamId,
      'first_name': firstName,
      'last_name': lastName,
      'jersey_number': jerseyNumber,
      'email': email,
      'phone': phone,
      'stats': stats.toJson(),
      'team': team.toJson(),
    };
  }



}

class PlayerStats {
  final double pctInningsPlayed;
  final int totalInningsParticipatedIn;
  final double pctInfPlayed;
  final String topPosition;
  final double avgBattingLoc;

  PlayerStats({
    required this.pctInningsPlayed,
    required this.totalInningsParticipatedIn,
    required this.pctInfPlayed,
    required this.topPosition,
    required this.avgBattingLoc,
  });

  factory PlayerStats.fromJson(Map<String, dynamic> json) => PlayerStats(
    pctInningsPlayed: (json['pct_innings_played'] ?? 0).toDouble(),
    totalInningsParticipatedIn:
    json['total_innings_participated_in'] ?? 0,
    pctInfPlayed: (json['pct_inf_played'] ?? 0).toDouble(),
    topPosition: json['top_position'] ?? '',
    avgBattingLoc: (json['avg_batting_loc'] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'pct_innings_played': pctInningsPlayed,
    'total_innings_participated_in': totalInningsParticipatedIn,
    'pct_inf_played': pctInfPlayed,
    'top_position': topPosition,
    'avg_batting_loc': avgBattingLoc,
  };
}

class TeamInfo {
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
  final DateTime accessExpiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  TeamInfo({
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
    required this.accessExpiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeamInfo.fromJson(Map<String, dynamic> json) => TeamInfo(
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
    accessExpiresAt: json['access_expires_at'] != null
        ? DateTime.tryParse(json['access_expires_at']) ?? DateTime.now()
        : DateTime.now(),
    createdAt:
    DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    updatedAt:
    DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'organization_id': organizationId,
      'name': name,
      'season': season,
      'year': year,
      'sport_type': sportType,
      'team_type': teamType,
      'age_group': ageGroup,
      'city': city,
      'state': state,
      'access_status': accessStatus,
      'access_expires_at': accessExpiresAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }




}


