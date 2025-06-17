// controllers/player_position_controller.dart
import 'package:gaming_web_app/service/api/player_service_api.dart';
import 'package:get/get.dart';
import 'package:gaming_web_app/Base/model/playerPositioned.dart';
class PlayerPositionController extends GetxController {
  var isLoading = false.obs;

  Future<void> savePreference(PlayerPreference preference) async {
    try {
      isLoading.value = true;
      await PlayerService.savePlayerPreferences(preference);
    } finally {
      isLoading.value = false;
    }
  }
}
