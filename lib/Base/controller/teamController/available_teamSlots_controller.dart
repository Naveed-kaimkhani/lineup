import 'dart:convert';
import 'dart:developer';

import 'package:gaming_web_app/Base/controller/teamController/team_slot_model.dart';
import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/service/api_end_point.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class AvailableTeamSlotsController extends GetxController {
  var isLoading = false.obs;
  var teamSlot = Rxn<TeamSlotModel>();

  Future<void> fetchAvailableSlots() async {
    isLoading.value = true;
    String? token = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );
    try {
      final response = await http.get(
        Uri.parse(APIEndPoints.availableSlots),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json', // optional but good practice
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success'] == true && data['data'] != null) {
          teamSlot.value = TeamSlotModel.fromJson(data['data']);
        }
      } else {
        print('Failed to fetch: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching team slots: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
