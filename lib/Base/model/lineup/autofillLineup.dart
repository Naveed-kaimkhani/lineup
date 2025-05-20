class AutoFillLineups {
  final List<int>? playersInGame;
  final Map<String, Map<String, String>>? fixedAssignments;
  final List<Lineup>? lineup;

  AutoFillLineups({
    this.playersInGame,
    this.fixedAssignments,
    this.lineup,
  });

  factory AutoFillLineups.fromJson(Map<String, dynamic> json) {
    return AutoFillLineups(
      playersInGame: (json['players_in_game'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      fixedAssignments:
      (json['fixed_assignments'] as Map<String, dynamic>?)?.map(
            (playerId, assignments) => MapEntry(
          playerId,
          (assignments as Map<String, dynamic>).map(
                (inning, position) => MapEntry(inning, position as String),
          ),
        ),
      ),
      lineup: (json['lineup'] as List<dynamic>?)
          ?.map((e) => Lineup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'players_in_game': playersInGame,
      'fixed_assignments': fixedAssignments,
      'lineup': lineup?.map((e) => e.toJson()).toList(),
    };
  }
}

class Lineup {
  final String playerId;
  final Map<int, String> innings;

  Lineup({
    required this.playerId,
    required this.innings,
  });

  factory Lineup.fromJson(Map<String, dynamic> json) {
    return Lineup(
      playerId: json['player_id'] as String,
      innings: (json['innings'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(int.parse(key), value as String),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_id': playerId,
      'innings': innings.map((key, value) => MapEntry(key.toString(), value)),
    };
  }
}
