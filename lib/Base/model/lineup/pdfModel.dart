// game_model.dart

class PDFMODEL {
  final GameDetails? gameDetails;
  final List<PlayerInfo>? playersInfo;
  final List<LineupAssignment>? lineupAssignments;

  PDFMODEL({
  this.gameDetails,
    this.playersInfo,
    this.lineupAssignments,
  });

  factory PDFMODEL.fromJson(Map<String, dynamic> json) {
    return PDFMODEL(
      gameDetails: GameDetails.fromJson(json['game_details']),
      playersInfo:
          (json['players_info'] as List)
              .map((e) => PlayerInfo.fromJson(e))
              .toList(),
      lineupAssignments:
          (json['lineup_assignments'] as List)
              .map((e) => LineupAssignment.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'game_details': gameDetails?.toJson(),
    'players_info': playersInfo?.map((e) => e.toJson()).toList(),
    'lineup_assignments': lineupAssignments?.map((e) => e.toJson()).toList(),
  };
}

class GameDetails {
  final int id;
  final String teamName;
  final String opponentName;
  final DateTime gameDate;
  final int inningsCount;
  final String locationType;

  GameDetails({
    required this.id,
    required this.teamName,
    required this.opponentName,
    required this.gameDate,
    required this.inningsCount,
    required this.locationType,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
      id: json['id'],
      teamName: json['team_name'],
      opponentName: json['opponent_name'],
      gameDate: DateTime.parse(json['game_date']),
      inningsCount: json['innings_count'],
      locationType: json['location_type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'team_name': teamName,
    'opponent_name': opponentName,
    'game_date': gameDate.toIso8601String(),
    'innings_count': inningsCount,
    'location_type': locationType,
  };
}

class PlayerInfo {
  final String id;
  final String fullName;
  final String jerseyNumber;

  PlayerInfo({
    required this.id,
    required this.fullName,
    required this.jerseyNumber,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    return PlayerInfo(
      id: json['id'].toString(),
      fullName: json['full_name'],
      jerseyNumber: json['jersey_number'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'jersey_number': jerseyNumber,
  };
}

class LineupAssignment {
  final String playerId;
  final Map<int, String> innings;

  LineupAssignment({required this.playerId, required this.innings});

  factory LineupAssignment.fromJson(Map<String, dynamic> json) {
    final inningsMap = (json['innings'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(int.parse(key), value.toString()),
    );

    return LineupAssignment(playerId: json['player_id'], innings: inningsMap);
  }

  Map<String, dynamic> toJson() => {
    'player_id': playerId,
    'innings': innings.map((k, v) => MapEntry(k.toString(), v)),
  };
}
