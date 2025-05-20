class GameData {
  final int? gameId;
  final int? innings;
  final List<GamePlayer>? players;

  GameData({this.gameId, this.innings, this.players});

  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      gameId: json['game_id'] as int?,
      innings: json['innings'] as int?,
      players: (json['players'] as List<dynamic>?)
          ?.map((e) => GamePlayer.fromJson(e))
          .toList(),
    );
  }
}

class GamePlayer {
  final int? id;
  final int? teamId;
  final String? firstName;
  final String? lastName;
  final String? jerseyNumber;
  final String? email;
  final GameStats? stats;
  final String? fullName;
  final List<GamePosition>? preferredPositions;
  final List<GamePosition>? restrictedPositions;
  final GameTeam? team;

  GamePlayer({
    this.id,
    this.teamId,
    this.firstName,
    this.lastName,
    this.jerseyNumber,
    this.email,
    this.stats,
    this.fullName,
    this.preferredPositions,
    this.restrictedPositions,
    this.team,
  });

  factory GamePlayer.fromJson(Map<String, dynamic> json) {
    return GamePlayer(
      id: json['id'] as int?,
      teamId: json['team_id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      jerseyNumber: json['jersey_number']?.toString(),
      email: json['email'] as String?,
      stats: json['stats'] != null ? GameStats.fromJson(json['stats']) : null,
      fullName: json['full_name'] as String?,
      preferredPositions: (json['preferred_positions'] as List<dynamic>?)
          ?.map((e) => GamePosition.fromJson(e))
          .toList(),
      restrictedPositions: (json['restricted_positions'] as List<dynamic>?)
          ?.map((e) => GamePosition.fromJson(e))
          .toList(),
      team: json['team'] != null ? GameTeam.fromJson(json['team']) : null,
    );
  }
}

class GameStats {
  final double? pctInningsPlayed;
  final String? topPosition;
  final dynamic avgBattingLoc;
  final Map<String, int>? positionCounts;
  final int? totalInningsParticipatedIn;
  final int? activeInningsPlayed;
  final double? pctInfPlayed;
  final double? pctOfPlayed;

  GameStats({
    this.pctInningsPlayed,
    this.topPosition,
    this.avgBattingLoc,
    this.positionCounts,
    this.totalInningsParticipatedIn,
    this.activeInningsPlayed,
    this.pctInfPlayed,
    this.pctOfPlayed,
  });

  factory GameStats.fromJson(Map<String, dynamic> json) {
    return GameStats(
      pctInningsPlayed: (json['pct_innings_played'] as num?)?.toDouble(),
      topPosition: json['top_position'] as String?,
      avgBattingLoc: json['avg_batting_loc'],
      positionCounts: (json['position_counts'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value as int)),
      totalInningsParticipatedIn:
      json['total_innings_participated_in'] as int?,
      activeInningsPlayed: json['active_innings_played'] as int?,
      pctInfPlayed: (json['pct_inf_played'] as num?)?.toDouble(),
      pctOfPlayed: (json['pct_of_played'] as num?)?.toDouble(),
    );
  }
}

class GamePosition {
  final int? id;
  final String? name;

  GamePosition({this.id, this.name});

  factory GamePosition.fromJson(Map<String, dynamic> json) {
    return GamePosition(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class GameTeam {
  final int? id;
  final int? userId;
  final int? organizationId;
  final String? name;
  final String? season;
  final String? year;
  final String? sportType;
  final String? teamType;
  final String? ageGroup;
  final String? city;
  final String? state;
  final String? accessStatus;
  final DateTime? accessExpiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GameTeam({
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
  });

  factory GameTeam.fromJson(Map<String, dynamic> json) {
    return GameTeam(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      organizationId: json['organization_id'] as int?,
      name: json['name'] as String?,
      season: json['season'] as String?,
      year: json['year']?.toString(),
      sportType: json['sport_type'] as String?,
      teamType: json['team_type'] as String?,
      ageGroup: json['age_group'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      accessStatus: json['access_status'] as String?,
      accessExpiresAt: json['access_expires_at'] != null
          ? DateTime.tryParse(json['access_expires_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
