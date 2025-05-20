import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' show Stripe;
import 'package:gaming_web_app/screens/base/base_widget.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:get/get.dart';
import 'Base/controller/globlLoaderController.dart';
import 'Base/controller/teamController/createTeamController.dart';
import 'Base/controller/teamController/teamController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async in main
  await SharedPreferencesUtil.init();
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  Get.put(TeamController(), permanent: true);
  Future.delayed(Duration(seconds: 1));
  // Register controllers permanently
  Get.put(NewTeamController(), permanent: true);

  Get.put(LoaderController());
  Stripe.publishableKey = 'pk_test_51RJ5ROQ7VW5LvG1xARfelRNNUG4uPYklS38PwEuZbH8zi1u8J4jobsmmQpWjPj9mYJ9iU2z2Bo3TfC7IUFDyEYLb00Gi3NvWQA';
  // Stripe.merchantIdentifier = 'com.example.gaming_web_app';
  Stripe.instance.applySettings();
  runApp(  BaseWidget());
}


// redirectToCheckout(context);

void toggleLoader(bool show) {
  final controller = Get.find<LoaderController>();
  controller.isLoading.value = show;
}


// toggleLoader(true);  // Show
// toggleLoader(false); // Hide