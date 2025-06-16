class PlayerStats {
  final double pctInningsPlayed;
  final String? topPosition;
  final double? avgBattingLoc;
  final int totalInnings;

  PlayerStats({
    required this.pctInningsPlayed,
    this.topPosition,
    this.avgBattingLoc,
    required this.totalInnings,
  });

  factory PlayerStats.fromJson(Map<String, dynamic> json) {
    return PlayerStats(
      pctInningsPlayed: (json['pct_innings_played'] ?? 0).toDouble(),
      topPosition: json['top_position'],
      avgBattingLoc: json['avg_batting_loc']?.toDouble(),
      totalInnings: json['total_innings_participated_in'] ?? 0,
    );
  }
}

class OrgPlayer {
  final int id;
  final String fullName;
  final String jerseyNumber;
  final PlayerStats stats;

  OrgPlayer({
    required this.id,
    required this.fullName,
    required this.jerseyNumber,
    required this.stats,
  });

  factory OrgPlayer.fromJson(Map<String, dynamic> json) {
    return OrgPlayer(
      id: json['id'],
      fullName: "${json['first_name']} ${json['last_name']}",
      jerseyNumber: json['jersey_number'],
      stats: PlayerStats.fromJson(json['stats']),
    );
  }
}
