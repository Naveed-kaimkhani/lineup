import 'package:gaming_web_app/Base/model/teamModel/org_team_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamRepository {
  final String baseUrl = 'http://18.189.193.38/api/v1/organization-panel/teams';

  Future<Map<String, dynamic>> fetchTeams({
    int page = 1,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl?page=$page'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<OrgTeamModel> teams =
          (data['data'] as List)
              .map((item) => OrgTeamModel.fromJson(item))
              .toList();

      final int totalPages = data['meta']['last_page'];
      return {'teams': teams, 'totalPages': totalPages};
    } else {
      throw Exception('Failed to load teams');
    }
  }



    Future<bool> deleteTeam({required int id, required String token}) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await http.delete(
    url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
