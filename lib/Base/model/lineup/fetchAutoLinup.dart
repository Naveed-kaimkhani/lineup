// models/lineup_model.dart
import 'package:get/get.dart';

// models/lineup_model.dart
import 'package:get/get.dart';

class FetchAutoFillLineups {
  final List<Lineupp>? lineupp;
  final List<int>? playersInGame;
  final Map<String, dynamic>? fixedAssignments;

  const FetchAutoFillLineups({
    this.lineupp,
    this.playersInGame,
    this.fixedAssignments = const {},
  });

  factory FetchAutoFillLineups.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const FetchAutoFillLineups();

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

  Map<String, dynamic> toJson() => {
    'lineup': lineupp?.map((e) => e.toJson()).toList(),
    'playersInGame': playersInGame,
    'fixedAssignments': fixedAssignments,
  };

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
// class Lineupp {
//   final String? playerId;
//   final String? battingOrder;
//   final Map<int, String>? innings;
//
//   Lineupp({
//     this.playerId,
//     this.battingOrder,
//     this.innings,
//   });
//
//   factory Lineupp.fromJson(Map<String, dynamic> json) {
//     return Lineupp(
//       playerId: json['player_id'].toString(),
//       battingOrder: json['batting_order'].toString(),
//       innings: Map<int, String>.from(json['innings'] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'player_id': playerId,
//       'batting_order': battingOrder,
//       'innings': innings,
//     };
//   }
// }
class Lineupp {
  final String playerId;
  final String? battingOrder;
  final bool isOut;
  final Map<int, String> innings;

  Lineupp({
    required this.playerId,
    this.battingOrder,
    this.isOut = false,
    this.innings = const {},
  });

  factory Lineupp.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Lineupp(
        playerId: '',
      );
    }

    return Lineupp(
      playerId: json['player_id']?.toString() ?? '',
      battingOrder: json['batting_order']?.toString(),
      isOut: json['isOut'] ?? false,
      innings: _parseInnings(json['innings']),
    );
  }

  static Map<int, String> _parseInnings(dynamic json) {
    if (json is! Map) return {};
    return json.map((k, v) => MapEntry(
      int.tryParse(k.toString()) ?? 0,
      v?.toString() ?? '',
    ));
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
// class Lineupp {
//   final String playerId;
//   String? batting_order;
//   bool isOUt;
//   final Map<int, String> innings;
//
//    Lineupp({
//     required this.playerId,
//      this.batting_order,
//      this.isOUt=false,
//     required this.innings,
//   });
//
//   factory Lineupp.fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       // print(["player_id"]);
//       // print(json!["batting_order"]);
//       // print(json!["innings"]);
//       return Lineupp(
//         isOUt:false,
//         batting_order:json!["batting_order"],
//         playerId:json!["player_id"],
//         innings: json["innings"],
//       );
//     }
//     // 'player_id': playerId,
//     // 'batting_order': battingOrder,
//     // 'innings': innings,
//     return Lineupp(
//       playerId: json['playerId']?.toString() ?? '',
//       innings: _parseInnings(json['innings']),
//     );
//   }
//
//   static Map<int, String> _parseInnings(dynamic json) {
//     if (json is! Map) return {};
//     return json.map((k, v) => MapEntry(
//         int.tryParse(k.toString()) ?? 0,
//         v?.toString() ?? ''
//     ));
//   }
//
//   Map<String, dynamic> toJsons() => {
//     'playerId': "playerId",
//     'batting_order': batting_order,
//     'innings': innings.map((k, v) => MapEntry(k.toString(), v)),
//   };
//
//   Lineupp copyWith({
//     String? playerId,
//     String? batting_order,
//     Map<int, String>? innings,
//   }) {
//     return Lineupp(
//       playerId: playerId ?? this.playerId,
//       batting_order:  this.batting_order,
//       innings: innings ?? this.innings,
//     );
//   }
// }
// If you have predefined positions, you could use an enum
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



// var datas;
//
//
// class FetchAutoFillLineups {
//   final List<Lineupp>? lineup;
//   final List<int>? playersInGame;
//   final Map<String, dynamic>? fixedAssignments;
//
//   FetchAutoFillLineups({
//     this.lineup,
//     this.playersInGame,
//     this.fixedAssignments,
//   });
//
//   factory FetchAutoFillLineups.fromJson(Map<String, dynamic> json) {
//     return FetchAutoFillLineups(
//       lineup:
//           (json['lineup'] as List<dynamic>?)
//               ?.map((e) => Lineupp.fromJson(e as Map<String, dynamic>))
//               .toList(),
//       playersInGame:
//           (json['players_in_game'] as List<dynamic>?)
//               ?.map((e) => e as int)
//               .toList(),
//       fixedAssignments: json['fixed_assignments'] as Map<String, dynamic>?,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     if (lineup != null) 'lineup': lineup!.map((e) => e.toJson()).toList(),
//     if (playersInGame != null) 'players_in_game': playersInGame,
//     if (fixedAssignments != null) 'fixed_assignments': fixedAssignments,
//   };
// }
// class Lineupp {
//   final String playerId;
//   final Map<int, String> innings;
//
//   Lineupp({
//     required this.playerId,
//     required this.innings,
//   });
//
//   factory Lineupp.fromJson(Map<String, dynamic> json) {
//     print('RAW JSON: $json');
//
//     final inningsMap = <int, String>{};
//     if (json['innings'] != null) {
//       (json['innings'] as Map<String, dynamic>).forEach((key, value) {
//         datas.add(inningsMap);
//         // print('Inning: $key -> $datas');
//         // print('Inning: $key -> $value');
//         // inningsMap[int.parse(key)] = value.toString();
//       });
//     }
//
//     return Lineupp(
//       playerId: json['player_id'].toString(),
//       innings: inningsMap,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'player_id': playerId,
//     'innings': innings.map((k, v) => MapEntry(k.toString(), v)),
//   };
// }
// // class Lineupp {
// //   final String? playerId;
// //   final Map<int, String>? innings;
// //
// //   Lineupp({this.playerId, this.innings});
// //
// //   factory Lineupp.fromJson(Map<String, dynamic> json) {
// //     final inningsMap = <int, String>{};
// //     (json['innings'] as Map<String, dynamic>).forEach((key, value) {
// //       inningsMap[int.parse(key)] = value.toString();
// //     });
// //
// //     return Lineupp(
// //       playerId: json['player_id'].toString(),
// //       innings: inningsMap,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() => {
// //     if (playerId != null) 'player_id': playerId,
// //     if (innings != null)
// //       'innings': innings!.map((k, v) => MapEntry(k.toString(), v.toString())),
// //   };
// // }
//
