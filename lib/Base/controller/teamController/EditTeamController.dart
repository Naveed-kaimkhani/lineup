import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/model/teamModel/createModel.dart';
import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTeamViewModel extends GetxController {
  TextEditingController teamNameController = TextEditingController();
  TextEditingController enterAgeGroupController = TextEditingController();
  TextEditingController seasonController = TextEditingController();
  TextEditingController ageGroupController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController orgCode = TextEditingController();

  var sportType = ''.obs;
  var teamType = ''.obs;

  CreateTeam getCreateTeamModel() {
    return CreateTeam(
      name: teamNameController.text.trim(),
      sportType: sportType.value.toLowerCase(),
      teamType: teamType.value.toLowerCase(),
      ageGroup: enterAgeGroupController.text,
      season: seasonController.text,
      year: int.parse(ageGroupController.text),
      city: cityController.text,
      state: countryController.text,
      organizationId: "",
    );
  }

  Future<void> updateTeam(String teamId) async {
    String? token = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );
    final url = Uri.parse('http://18.189.193.38/api/v1/teams/$teamId');
    final body = json.encode(getCreateTeamModel().toJson());

    try {
      final response = await http.put(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        // Get.snackbar("Success", "Team updated successfully");
        SnackbarUtils.showSuccess("Team updated successfully");
      } else {
        // Get.snackbar("Error", "Failed to update team");

        SnackbarUtils.showErrorr("Failed to update team");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    }
  }
}
