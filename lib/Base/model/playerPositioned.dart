import 'dart:developer';

class PlayerPreferencesResponse {
  final List<PlayerPreference> playerPreferences;

  PlayerPreferencesResponse({required this.playerPreferences});

  factory PlayerPreferencesResponse.fromJson(Map<String, dynamic> json) {
    return PlayerPreferencesResponse(
      playerPreferences: (json['player_preferences'] as List)
          .map((e) => PlayerPreference.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    // log(playerPreferences)
    'player_preferences': playerPreferences.map((e) => e.toJson()).toList(),
  };


}

class PlayerPreference {
  final int playerId;
 List<int> preferredPositionIds;
   List<int> restrictedPositionIds;

  PlayerPreference({
    required this.playerId,
    required this.preferredPositionIds,
    required this.restrictedPositionIds,
  });

  factory PlayerPreference.fromJson(Map<String, dynamic> json) {
    return PlayerPreference(
      playerId: json['player_id'],
      preferredPositionIds: List<int>.from(json['preferred_position_ids']),
      restrictedPositionIds: List<int>.from(json['restricted_position_ids']),
    );
  }

  Map<String, dynamic> toJson() => {
  
    'player_id': playerId,
    'preferred_position_ids': preferredPositionIds,
    'restricted_position_ids': restrictedPositionIds,
  };
}
