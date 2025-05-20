class FetchAutoFillLineups {
  final List<Lineupp>? lineup;
  final List<int>? playersInGame;
  final Map<String, dynamic>? fixedAssignments;

  FetchAutoFillLineups({
    this.lineup,
    this.playersInGame,
    this.fixedAssignments,
  });

  factory FetchAutoFillLineups.fromJson(Map<String, dynamic> json) {
    return FetchAutoFillLineups(
      lineup:
          (json['lineup'] as List<dynamic>?)
              ?.map((e) => Lineupp.fromJson(e as Map<String, dynamic>))
              .toList(),
      playersInGame:
          (json['players_in_game'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      fixedAssignments: json['fixed_assignments'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (lineup != null) 'lineup': lineup!.map((e) => e.toJson()).toList(),
    if (playersInGame != null) 'players_in_game': playersInGame,
    if (fixedAssignments != null) 'fixed_assignments': fixedAssignments,
  };
}

class Lineupp {
  final String? playerId;
  final Map<int, String>? innings;

  Lineupp({this.playerId, this.innings});

  factory Lineupp.fromJson(Map<String, dynamic> json) {
    final inningsMap = <int, String>{};
    (json['innings'] as Map<String, dynamic>).forEach((key, value) {
      inningsMap[int.parse(key)] = value.toString();
    });

    return Lineupp(
      playerId: json['player_id'].toString(),
      innings: inningsMap,
    );
  }

  Map<String, dynamic> toJson() => {
    if (playerId != null) 'player_id': playerId,
    if (innings != null)
      'innings': innings!.map((k, v) => MapEntry(k.toString(), v)),
  };
}

