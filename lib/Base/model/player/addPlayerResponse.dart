import 'dart:developer';

import '../teamModel/teamModel.dart';

class AddPlayerResponse {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? jerseyNumber;
  final String? email;
  final int? teamId;
  final String? createdAt;
  final String? updatedAt;
  final Stats? stats;
  final Team? team;

  AddPlayerResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.jerseyNumber,
    this.email,
    this.teamId,
    this.createdAt,
     this.updatedAt,
     this.stats,
    this.team,
  });

  factory AddPlayerResponse.fromJson(Map<String, dynamic> json) {

    return AddPlayerResponse(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      jerseyNumber: json['jersey_number'] ?? '',
      email: json['email'] ?? '',
      teamId: json['team_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      stats: Stats.fromJson(json['stats'] ?? {}),
      team: Team.fromJson(json['team'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'jersey_number': jerseyNumber,
      'email': email,
      'team_id': teamId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'stats': stats?.toJson(),
      'team': team?.toJson(),
    };
  }
}


class Stats {
  final int pctInningsPlayed;
  final String? topPosition;
  final String? avgBattingLoc;
  final Map<String, dynamic> positionCounts;

  Stats({
    required this.pctInningsPlayed,
    this.topPosition,
    this.avgBattingLoc,
    required this.positionCounts,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      pctInningsPlayed: json['pct_innings_played'] ?? 0,
      topPosition: json['top_position'],
      avgBattingLoc: json['avg_batting_loc'],
      positionCounts: json['position_counts'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pct_innings_played': pctInningsPlayed,
      'top_position': topPosition,
      'avg_batting_loc': avgBattingLoc,
      'position_counts': positionCounts,
    };
  }
}

