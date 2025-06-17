// services/player_service.dart

import 'dart:developer';

import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:gaming_web_app/Base/model/playerPositioned.dart';

class PlayerService {
  static Future<void> savePlayerPreferences(PlayerPreference preference) async {
    final token = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );
    final uri = Uri.parse(
      'http://18.189.193.38/api/v1/players/${preference.playerId}/preferences',
    );
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(preference.toJson()),
    );
    log(response.body);
    // print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to update player preferences: ${response.body}');
    }
  }

  static Future<PlayerPreference> fetchPlayerPreferences(int playerId) async {
    final token = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );
    final uri = Uri.parse(
      'http://18.189.193.38/api/v1/players/$playerId/preferences',
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load player preferences");
    }

    final json = jsonDecode(response.body);
    final data = json['data'];

    return PlayerPreference(
      playerId: data['player_id'],
      preferredPositionIds: List<int>.from(data['preferred_positions']),
      restrictedPositionIds: List<int>.from(data['restricted_positions']),
    );
  }
}
