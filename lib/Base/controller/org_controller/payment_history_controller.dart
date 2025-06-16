import 'package:gaming_web_app/Base/model/teamModel/activation_history_model.dart';
import 'package:gaming_web_app/service/api/adminApi.dart';
import 'package:get/get.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';

class ActivationHistoryController extends GetxController {
  var history = <ActivationRecord>[].obs;
  var isLoading = false.obs;

  // final _repo = ActivationHistoryRepository();

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    isLoading.value = true;

    try {
      final result = await AdminApi.fetchHistory();
      history.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
