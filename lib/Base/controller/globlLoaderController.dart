import 'package:get/get.dart';

class LoaderController extends GetxController {
  RxBool isLoading = false.obs;

  void showLoader() {
    isLoading.value = true;
  }

  void hideLoader() {
    isLoading.value = false;
  }
}
