import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path.dart';
import '../../../service/api/authApi.dart';
import '../../model/authModel/signupModel.dart';

class SignUpController extends GetxController {
  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Error messages
  var firstNameError = ''.obs;
  var lastNameError = ''.obs;
  var emailError = ''.obs;
  var phoneNumberError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  // Validation method

  bool validateFields() {
    bool isValid = true;
    String errorMessage = '';

    // Clear old errors
    firstNameError.value = '';
    lastNameError.value = '';
    emailError.value = '';
    phoneNumberError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';

    // First Name
    if (firstNameController.text.trim().isEmpty) {
      firstNameError.value = 'First name is required';
      errorMessage = firstNameError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    }

    // Last Name
    if (lastNameController.text.trim().isEmpty) {
      lastNameError.value = 'Last name is required';
      errorMessage = lastNameError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    }

    // Email
    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Email is required';
      errorMessage = emailError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = 'Invalid email format';
      errorMessage = emailError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    }

    // Phone
    if (phoneNumberController.text.trim().isEmpty) {
      phoneNumberError.value = 'Phone number is required';
      errorMessage = phoneNumberError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    } else if (!RegExp(
      r'^\d{10,15}$',
    ).hasMatch(phoneNumberController.text.trim())) {
      phoneNumberError.value = 'Invalid phone number';
      errorMessage = phoneNumberError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    }

    // Password
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      errorMessage = passwordError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      errorMessage = passwordError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    }

    // Confirm Password
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      errorMessage = confirmPasswordError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    } else if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      errorMessage = confirmPasswordError.value;
      showErrorSnackBar(errorMessage);
      return false; // Exit after the first error
    }

    return isValid;
  }

  void showErrorSnackBar(String errorMessage) {
    // Show a snack bar with the error message
    Get.snackbar(
      'Error',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white),
    );
  }

  // Sign up button logic
  Future<void> signUp() async {
    print("nfkjgfhkjghgkj");
    if (validateFields()) {
      final request = UserModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      final response = await AuthAPI.registerUser(request);

      if (response.success!) {
        Get.snackbar('Success', 'User Register Success');
        Get.offNamed(RoutesPath.signIn);

      } else {
        Get.snackbar('Error', response.message.toString());
      }
      print(response.success);
      print(response.message);
      print(response.data);
    }
  }

  // Go to login screen
  void goToLogin() {
    Get.offNamed(RoutesPath.signIn);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
