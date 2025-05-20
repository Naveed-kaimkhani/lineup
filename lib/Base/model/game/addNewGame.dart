class AddGame {
  final String? opponentName;
  final String? gameDate;
  final int? innings;
  final String? locationType;

  AddGame({
    this.opponentName,
    this.gameDate,
    this.innings,
    this.locationType,
  });

  factory AddGame.fromJson(Map<String, dynamic> json) {
    return AddGame(
      opponentName: json['opponent_name'] as String?,
      gameDate: json['game_date'] as String?, // ✅ no parsing
      innings: json['innings'] as int?,
      locationType: json['location_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'opponent_name': opponentName,
      'game_date': gameDate,
      'innings': innings,
      'location_type': locationType,
    };
  }

  /// ✅ Optional validation method
  bool isValid() {
    return opponentName != null &&
        opponentName!.isNotEmpty &&
        gameDate != null &&
        gameDate!.isNotEmpty &&
        innings != null &&
        locationType != null &&
        locationType!.isNotEmpty;
  }
}
