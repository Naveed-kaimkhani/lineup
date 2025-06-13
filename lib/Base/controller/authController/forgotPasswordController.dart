import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes_path.dart';
import '../../../service/api/passwordAPi.dart';
import '../../../utils/snackbarUtils.dart';
import '../../model/authModel/forggotPasswordRequest.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();
  RxBool isMail=false.obs;

  /// send otp request
  Future<void> sendCode() async {
    String email = emailController.text.trim();

    // Basic email validation
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      SnackbarUtils.showErrorr("Please enter a valid email address");
      return;
    }

    ForgotPasswordRequest request = ForgotPasswordRequest(email: email);

    try {
      final response = await PasswordApi.forgotPassword(request);

      if (response.success == true) {
        isMail.value = true;
        SnackbarUtils.showSuccess("OTP sent successfully");
      } else {
        SnackbarUtils.showErrorr(response.message ?? "Failed to send OTP");
      }
    } catch (e) {
      SnackbarUtils.showErrorr("Something went wrong: $e");
    }
  }


  Future<void> resetPassword() async {
    String email = emailController.text.trim();
    // Basic Email Validation
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      SnackbarUtils.showErrorr("Please enter a valid email address");
      return;
    }

    // Basic OTP Validation (Check if OTP is not empty)
    if (otpController.text.trim().isEmpty || otpController.text.trim().length != 6) {
      SnackbarUtils.showErrorr("Please enter a valid OTP");
      return;
    }

    // Password Validation (Check if passwords match and are not empty)
    if (password.text.trim().isEmpty || passwordConfirmation.text.trim().isEmpty) {
      SnackbarUtils.showErrorr("Password and confirmation cannot be empty");
      return;
    }

    if (password.text.trim() != passwordConfirmation.text.trim()) {
      SnackbarUtils.showErrorr("Passwords do not match");
      return;
    }

    // Password Strength Check (optional, you can adjust according to your policy)
    if (password.text.trim().length < 8) {
      SnackbarUtils.showErrorr("Password must be at least 8 characters long");
      return;
    }

    final resetRequest = ResetPasswordRequest(
      email: email,
      otp: otpController.text.trim(),
      password: password.text.trim(),
      passwordConfirmation: passwordConfirmation.text.trim(),
    );

    try {
      final response = await PasswordApi.resetPassword(resetRequest);

      if (response.success == true) {
        isMail.value = true;
        Get.offNamed(RoutesPath.signIn);
        SnackbarUtils.showSuccess("Password reset successful");
      } else {
        SnackbarUtils.showErrorr(response.message ?? "Failed to reset password");
      }
    } catch (e) {
      SnackbarUtils.showErrorr("Something went wrong: $e");
    }
  }

  void goToLogin() {
    Get.offAllNamed('/signIn'); // or use RoutesPath.signIn
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
