import 'dart:convert';

import 'package:gaming_web_app/Base/model/teamModel/player_stats.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class TeamDetailController extends GetxController {
  var isLoading = false.obs;
  var players = <OrgPlayer>[].obs;

  Future<void> fetchTeamData(int id) async {
    try {
      isLoading.value = true;
      final url = Uri.parse("http://18.189.193.38/api/v1/organization-panel/teams/$id");
      final token = await SharedPreferencesUtil.read("org_access_token");
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> rawPlayers = json['data']['players'];
        players.value = rawPlayers.map((p) => OrgPlayer.fromJson(p)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch team details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
