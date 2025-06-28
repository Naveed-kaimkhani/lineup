import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/service/api_end_point.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final currentPasswordError = ''.obs;
  final newPasswordError = ''.obs;
  final confirmPasswordError = ''.obs;

  void changePassword() async {
    currentPasswordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';

    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (current.isEmpty) {
      currentPasswordError.value = "Current password is required";
      return;
    }

    if (newPass.isEmpty) {
      newPasswordError.value = "New password is required";
      return;
    }

    if (newPass.length < 8) {
      newPasswordError.value = "Password must be 8 characters long";
      return;
    }

    if (confirm != newPass) {
      confirmPasswordError.value = "Passwords do not match";
      return;
    }

    isLoading.value = true;

    try {
      final response = await _changePasswordApi(current, newPass, confirm);

      if (response['success'] == true) {
        Get.back();

        SnackbarUtils.showSuccess("Password changed successfully");
      } else {
        // Get.snackbar(
        //   "Error",
        //   response['message'] ?? "Failed",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.red.shade100,
        // );
        SnackbarUtils.showErrorr(response['message']);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void OrgChangePassword() async {
    currentPasswordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';

    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (current.isEmpty) {
      currentPasswordError.value = "Current password is required";
      return;
    }

    if (newPass.isEmpty) {
      newPasswordError.value = "New password is required";
      return;
    }

    if (newPass.length < 8) {
      newPasswordError.value = "Password must be 8 characters long";
      return;
    }

    if (confirm != newPass) {
      confirmPasswordError.value = "Passwords do not match";
      return;
    }

    isLoading.value = true;

    try {
      final response = await OrgChangePasswordApi(current, newPass, confirm);

      if (response['success'] == true) {
        Get.back();

        SnackbarUtils.showSuccess("Password changed successfully");
      } else {
        // Get.snackbar(
        //   "Error",
        //   response['message'] ?? "Failed",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.red.shade100,
        // );
        SnackbarUtils.showErrorr(response['message']);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> _changePasswordApi(
    String current,
    String newPass,
    String confirm,
  ) async {
    // log("in method");

    final token = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );

    final url = Uri.parse(
      // '${APIEndPoints.baseUrl}/auth/change-password',
      'http://18.189.193.38/api/v1/user/auth/change-password',
    );
    
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "current_password": current,
      "password": newPass,
      "password_confirmation": confirm,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);


      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      // log("Error: $e");
      return {
        "success": false,
        "message": "Something went wrong. Please try again.",
      };
    }
  }

  Future<Map<String, dynamic>> OrgChangePasswordApi(
    String current,
    String newPass,
    String confirm,
  ) async {
    

    final token = await SharedPreferencesUtil.read("org_access_token");

    final url = Uri.parse(
      // '${APIEndPoints.baseUrl}/auth/change-password',
      'http://18.189.193.38/api/v1/organization-panel/auth/change-password',
    );
    
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "current_password": current,
      "password": newPass,
      "password_confirmation": confirm,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {
        "success": false,
        "message": "Something went wrong. Please try again.",
      };
    }
  }
}
