
import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  static void showCustomDialog({
    required String title,
    required String message,
    required Color titleColor,
    required Color buttonColor,
  }) {
    Get.dialog(
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ), // 👈 Web-safe max width
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("OK", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showErrorr(String message) {
    showCustomDialog(
      title: "Alert",
      message: message,
      titleColor: Colors.red.shade700,

      // buttonColor: Colors.red.shade600,
      buttonColor: AppColors.primaryColor,
    );
  }

  static void showSuccess(String message) {
    showCustomDialog(
      title: "Success",
      message: message,
      titleColor: const Color(0xFF2B4582), // Theme-matching deep blue
      buttonColor: const Color(0xFF2B4582),
    );
  }

  static void showInfo(String message) {
    showCustomDialog(
      title: "Info",
      message: message,
      titleColor: Colors.blue.shade600,
      buttonColor: Colors.blue.shade500,
    );
  }
}
