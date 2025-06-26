import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaming_web_app/screens/admin/adminController/settings_model.dart';
import 'package:gaming_web_app/service/api/adminApi.dart';
import 'package:gaming_web_app/service/api/team.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SettingsController extends GetxController {
  final unlockPriceController = TextEditingController();
  // final accessDurationController = TextEditingController();
  final adminEmailController = TextEditingController();

  RxBool notifyAdmin = false.obs;

  Future<void> saveSettings() async {
    final priceText = unlockPriceController.text.trim();
    // final durationText = accessDurationController.text.trim();
    final emailText = adminEmailController.text.trim();

    if (priceText.isEmpty || double.tryParse(priceText) == null) {
      SnackbarUtils.showErrorr("Please enter a valid unlock price.");
      return;
    }

    // if (durationText.isEmpty || int.tryParse(durationText) == null) {
    //   SnackbarUtils.showErrorr("Please enter a valid access duration in days.");
    //   return;
    // }

    if (emailText.isNotEmpty &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(emailText)) {
      SnackbarUtils.showErrorr("Please enter a valid email address.");
      return;
    }

    final model = SettingsModel(
      unlockPriceAmount: double.parse(priceText),
      // accessDurationDays: int.parse(durationText),
      notifyAdminOnPayment: notifyAdmin.value,
      adminNotificationEmail: emailText.isEmpty ? null : emailText,
    );

    try {
      final response = await AdminApi.saveSettings(model.toJson());
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        SnackbarUtils.showSuccess("Settings saved successfully");
      } else {
        // You can also parse response.body for detailed errors
        SnackbarUtils.showErrorr(
          "Failed to save settings: ${response.statusCode}",
        );
      }
    } catch (e) {
      SnackbarUtils.showErrorr("Something went wrong: $e");
    }
  }

  @override
  void onClose() {
    unlockPriceController.dispose();
    // accessDurationController.dispose();
    adminEmailController.dispose();
    super.onClose();
  }
}
