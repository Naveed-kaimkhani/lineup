
import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/model/teamModel/org_team_model.dart';
import 'package:gaming_web_app/service/api/org_team_api.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:get/get.dart';

class OrgTeamsController extends GetxController {
  final TeamRepository _repository = TeamRepository();

  var teams = <OrgTeamModel>[].obs;
  var isLoading = false.obs;
  var isDeleting = false.obs;

  var currentPage = 1.obs;
  var totalPages = 1.obs;
  bool get lastPage => currentPage.value >= totalPages.value;

  String token = ''; // Assign token from your auth module

  @override
  void onInit() {
    fetchTeams();
    super.onInit();
  }

  void loadMore() {
    if (!lastPage) {
      fetchTeams(page: currentPage.value + 1);
    }
  }

  Future<void> fetchTeams({int page = 1}) async {
    String? token = await SharedPreferencesUtil.read(
      "org_access_token",
    ); // optional
    try {
      isLoading(true);
      final result = await _repository.fetchTeams(
        page: page,
        token: token ?? "",
      );
      teams.value = result['teams'];
      totalPages.value = result['totalPages'];
      currentPage.value = page;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteTeam(int id) async {
    String? token = await SharedPreferencesUtil.read("org_access_token");
    if (token == null) return;

    try {
      isDeleting.value = true;
      final success = await _repository.deleteTeam(id: id, token: token);
      if (success) {
        teams.removeWhere((team) => team.id == id);
        teams.refresh();
        Get.snackbar(
          "Success",
          "Team deleted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to delete team",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isDeleting.value = false;
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      fetchTeams(page: currentPage.value + 1);
    }
  }

  void prevPage() {
    if (currentPage.value > 1) {
      fetchTeams(page: currentPage.value - 1);
    }
  }
}
