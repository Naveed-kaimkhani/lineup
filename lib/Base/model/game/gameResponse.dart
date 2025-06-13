class GameResponse {
  final int id;
  final String opponentName;
  final DateTime gameDate;
  final int innings;
  final String locationType;
  final List<dynamic> lineupData;
  final int teamId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final GameTeam team;

  GameResponse({
    required this.id,
    required this.opponentName,
    required this.gameDate,
    required this.innings,
    required this.locationType,
    required this.lineupData,
    required this.teamId,
    required this.updatedAt,
    required this.createdAt,
    required this.team,
  });

  factory GameResponse.fromJson(Map<String, dynamic> json) {
    return GameResponse(
      id: json['id'],
      opponentName: json['opponent_name'],
      gameDate: DateTime.parse(json['game_date']),
      innings: json['innings'],
      locationType: json['location_type'],
      lineupData: json['lineup_data'] ?? [],
      teamId: json['team_id'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      team: GameTeam.fromJson(json['team']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'opponent_name': opponentName,
      'game_date': gameDate.toIso8601String(),
      'innings': innings,
      'location_type': locationType,
      'lineup_data': lineupData,
      'team_id': teamId,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'team': team.toJson(),
    };
  }
}

class GameTeam {
  final int id;
  final String name;

  GameTeam({required this.id, required this.name});

  factory GameTeam.fromJson(Map<String, dynamic> json) {
    return GameTeam(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
