import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../service/api/team.dart';
import '../../../utils/SharedPreferencesUtil.dart';
import '../../api_service.dart';
import '../../model/player/getPlayerModel.dart';
import '../../model/playerPositioned.dart';
import '../../model/positioned.dart';
import '../../model/teamModel/teamModel.dart';
import '../getTeamData.dart';

class TeamController extends GetxController {
  Organizations? selectedOrganization;
  // Define an RxList to store the teams
  RxList<Team?> teams = <Team?>[].obs;
  Rx<TeamData?> teamData = TeamData().obs;
  RxInt teamDataIndex = 0.obs;
  TextEditingController codeField = TextEditingController();
  // TextEditingController code =TextEditingController();
  RxList<Organizations?> organization = <Organizations?>[].obs;
  // RxList<Organization?> organization = <Organization?>[].obs;
  Rx<Organizations> organizationItem = Organizations().obs;
  List<Position?> teamPositioned = [];
  Position positioned = Position();
  RxList<GetPlayer?> getPlayer = <GetPlayer?>[].obs;
  RxString selectTeam = "".obs;
  RxMap<int, List<int>> preferredPositionIds = <int, List<int>>{}.obs;
  RxMap<int, List<int>> restrictedPositionIds = <int, List<int>>{}.obs;
  final ApiServic apiService = Get.put<ApiServic>(ApiServic());

  RxList<PlayerPreference> playerPreference = <PlayerPreference>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Automatically fetch teams when the controller is created
    // getData();
  }

  Future<void> getData() async {
    await Future.delayed(const Duration(seconds: 1)); // Wait 2 seconds
    fetchTeams();
    fetchTeamsPositioned();
    fetchOrganization();
  }

  Future<void> getSavedTeamData() async {
    teamData.value = await SharedPreferencesUtil.readObject<TeamData>(
      'team_data',
      (json) => TeamData.fromJson(json),
    );

    if (teamData.value != null) {
    } else {}
  }

  // Fetch teams from the API and update the teams list
  Future<void> fetchTeams() async {
    try {
      // Call the API to get the list of teams
      final response = await TeamsApi.getTeam();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        teams.value = response.data!;
        teams.refresh();
      } else {
        // log(response.data.toString());
        // Handle the case where no teams are returned
        teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      log('Error fetching teams: $e');
    }
  }

  Future<void> fetchTeamsPositioned() async {
    try {
      // Call the API to get the list of teams
      final response = await TeamsApi.getTeamPosition();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        teamPositioned = response.data!;
        await SharedPreferencesUtil.saveObject<List<Position?>>(
          "fav",
          teamPositioned,
          (list) => {'data': list.map((e) => e?.toJson()).toList()},
        );
        await SharedPreferencesUtil.saveObject<List<Position?>>(
          "res",
          teamPositioned,
          (list) => {'data': list.map((e) => e?.toJson()).toList()},
        );
      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> fetchGetPlayer(int id) async {
    try {
      // Call the API to get the list of teams
      // final response = await TeamsApi.getPlayer(4);
      final response = await TeamsApi.getPlayer(id);
      // final response = await TeamsApi.getPlayer(4);

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        getPlayer.value = response.data!;
        playerPreference.clear();
        for (int i = 0; i < getPlayer.value.length; i++) {
          final data = PlayerPreference(
            playerId: getPlayer.value![i]!.id,
            preferredPositionIds: [],
            restrictedPositionIds: [],
          );

          playerPreference.add(data);
        }
      } else {
        // Handle the case where no teams are returned
        teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> fetchGetTeamData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = await prefs.getInt('teamInfoId'); // returns null if not found
      // teamData.clear();
      // Call the API to get the list of teams
      final response = await TeamsApi.getTeamData(id!);

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        teamData.value = response.data!;
        ever(teamData, (data) {
          if (data != null) {
            SharedPreferencesUtil.saveObject<TeamData>(
              "teamDataKey",
              data,
              (val) => val.toJson(),
            );
          }
        });
        getData();
      } else {
        // Handle the case where no teams are returned
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> fetchOrganization() async {
    try {
      // Call the API to get the list of teams
      final response = await TeamsApi.getOrganization();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        organization.value = response.data!;
      } else {
        // Handle the case where no teams are returned
        teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
    }
  }

  // Save value (for example, save the selected team)
  void saveSelectedTeam(Team? selectedTeam) {
    // You can save the selected team or perform any other operation
    // For demonstration, we'll simply print the selected team.
  }
}
