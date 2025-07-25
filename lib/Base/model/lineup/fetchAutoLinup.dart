import 'dart:developer';

import 'package:get/get.dart';

class FetchAutoFillLineups {
  List<Lineupp>? lineupp;
  final List<int>? playersInGame;
  final Map<String, dynamic>? fixedAssignments;

  FetchAutoFillLineups({
    this.lineupp,
    this.playersInGame,
    // this.isOut,
    this.fixedAssignments = const {},
  });

  factory FetchAutoFillLineups.fromJson(Map<String, dynamic>? json) {
    if (json == null) return FetchAutoFillLineups();

    return FetchAutoFillLineups(
      lineupp: _parseLineuppList(json['lineup']),
      playersInGame: _parseIntList(json['playersInGame']),
      fixedAssignments: _parseFixedAssignments(json['fixedAssignments']),
    );
  }

  static List<Lineupp>? _parseLineuppList(dynamic json) {
    if (json is! List) return null;
    return json.map((e) => Lineupp.fromJson(e)).toList();
  }

  static List<int>? _parseIntList(dynamic json) {
    if (json is! List) return null;
    return json.whereType<int>().toList();
  }

  static Map<String, dynamic>? _parseFixedAssignments(dynamic json) {
    if (json is! Map) return null;
    return json.cast<String, dynamic>();
  }

  // Map<String, dynamic> toJson() => {

  //   'lineup': lineupp?.map((e) => e.toJson()).toList(),
  //   'playersInGame': playersInGame,
  //   'fixedAssignments': fixedAssignments,
  // };

  Map<String, dynamic> toJson() {
    if (lineupp != null) {
      for (var item in lineupp!) {}
    }

    return {
      'lineup': lineupp?.map((e) => e.toJson()).toList(),
      'playersInGame': playersInGame,
      'fixedAssignments': fixedAssignments,
    };
  }

  FetchAutoFillLineups copyWith({
    List<Lineupp>? lineupp,
    List<int>? playersInGame,
    Map<String, dynamic>? fixedAssignments,
  }) {
    return FetchAutoFillLineups(
      lineupp: lineupp ?? this.lineupp,
      playersInGame: playersInGame ?? this.playersInGame,
      fixedAssignments: fixedAssignments ?? this.fixedAssignments,
    );
  }
}

class Lineupp {
  final String playerId;
  final String? battingOrder;
  bool isOut;
  final Map<int, String> innings;
  final PlayerStats? stats; // ✅ Add this line


  Lineupp({
    required this.playerId,
    this.battingOrder,
    this.isOut = false,
    this.innings = const {},
    this.stats, // ✅ Add this line
  });

  factory Lineupp.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Lineupp(playerId: '');
    }

    return Lineupp(
      playerId: json['player_id']?.toString() ?? '',
      battingOrder: json['batting_order']?.toString(),
      isOut: json['isOut'] ?? false,
      innings: _parseInnings(json['innings']),
      stats: PlayerStats.fromJson(json['stats']), // ✅ Parse stats
    );
  }

  static Map<int, String> _parseInnings(dynamic json) {
    if (json is! Map) return {};
    return json.map(
      (k, v) => MapEntry(int.tryParse(k.toString()) ?? 0, v?.toString() ?? ''),

      // (k, v) => MapEntry(int.tryParse(k.toString()) ?? 0,  ''),
    );
  }

  Map<String, dynamic> toJson() => {
    'player_id': playerId,
    'batting_order': battingOrder,
    'isOut': isOut,
    'innings': innings.map((k, v) => MapEntry(k.toString(), v)),
  };

  Lineupp copyWith({
    String? playerId,
    String? battingOrder,
    bool? isOut,
    Map<int, String>? innings,
  }) {
    return Lineupp(
      playerId: playerId ?? this.playerId,
      battingOrder: battingOrder ?? this.battingOrder,
      isOut: isOut ?? this.isOut,
      innings: innings ?? this.innings,
    );
  }
}

class PlayerStats {
  final double pctInningsPlayed;
  final String topPosition;
  final double avgBattingLoc;
  final Map<String, int> positionCounts;
  final double totalInningsParticipatedIn;
  final double activeInningsPlayed;
  final double pctInfPlayed;
  final double pctOfPlayed;

  PlayerStats({
    required this.pctInningsPlayed,
    required this.topPosition,
    required this.avgBattingLoc,
    required this.positionCounts,
    required this.totalInningsParticipatedIn,
    required this.activeInningsPlayed,
    required this.pctInfPlayed,
    required this.pctOfPlayed,
  });

  factory PlayerStats.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PlayerStats(
        pctInningsPlayed: 0,
        topPosition: 'OUT',
        avgBattingLoc: 0.0,
        positionCounts: {},
        totalInningsParticipatedIn: 0,
        activeInningsPlayed: 0,
        pctInfPlayed: 0,
        pctOfPlayed: 0,
      );
    }

    return PlayerStats(
      pctInningsPlayed: json['pct_innings_played'] ?? 0,
      topPosition: json['top_position'] ?? 'OUT',
      avgBattingLoc: (json['avg_batting_loc'] ?? 0).toDouble(),
      positionCounts: Map<String, int>.from(json['position_counts'] ?? {}),
      totalInningsParticipatedIn: json['total_innings_participated_in'] ?? 0,
      activeInningsPlayed: json['active_innings_played'] ?? 0,
      pctInfPlayed: json['pct_inf_played'] ?? 0,
      pctOfPlayed: json['pct_of_played'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'pct_innings_played': pctInningsPlayed,
    'top_position': topPosition,
    'avg_batting_loc': avgBattingLoc,
    'position_counts': positionCounts,
    'total_innings_participated_in': totalInningsParticipatedIn,
    'active_innings_played': activeInningsPlayed,
    'pct_inf_played': pctInfPlayed,
    'pct_of_played': pctOfPlayed,
  };
}

enum BaseballPosition {
  pitcher('P'),
  catcher('C'),
  firstBase('1B'),
  secondBase('2B'),
  thirdBase('3B'),
  shortstop('SS'),
  leftField('LF'),
  centerField('CF'),
  rightField('RF'),
  out('OUT');

  final String abbreviation;
  const BaseballPosition(this.abbreviation);

  static BaseballPosition? fromAbbreviation(String abbr) {
    return values.firstWhereOrNull((e) => e.abbreviation == abbr);
  }
}
