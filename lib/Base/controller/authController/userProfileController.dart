import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/SharedPreferencesKeysConstants.dart';
import '../../../utils/SharedPreferencesUtil.dart';
import '../../model/authModel/loginModel.dart';

class UserProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var firstNameError = ''.obs;
  var lastNameError = ''.obs;
  var emailError = ''.obs;
  var phoneNumberError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = await SharedPreferencesUtil.readObject<UserResponse>(
      SharedPreferencesKeysConstants.user_response,
          (json) => UserResponse.fromJson(json),
    );
    print(user?.toJson());
    if (user != null && user.user != null) {
      firstNameController.text = user.user!.firstName ?? '';
      lastNameController.text = user.user!.lastName ?? '';
      emailController.text = user.user!.email ?? '';
      phoneNumberController.text = user.user!.phone ?? '';
      print("User loaded: ${user.user!.firstName} ${user.user!.lastName}");
    } else {
      print("No user data found in SharedPreferences");
    }
  }

  void validateAndSubmit() {
    bool isValid = true;

    if (firstNameController.text.trim().isEmpty) {
      firstNameError.value = "First name is required";
      isValid = false;
    } else {
      firstNameError.value = "";
    }

    if (lastNameController.text.trim().isEmpty) {
      lastNameError.value = "Last name is required";
      isValid = false;
    } else {
      lastNameError.value = "";
    }

    if (emailController.text.trim().isEmpty) {
      emailError.value = "Email is required";
      isValid = false;
    } else {
      emailError.value = "";
    }

    if (phoneNumberController.text.trim().isEmpty) {
      phoneNumberError.value = "Phone number is required";
      isValid = false;
    } else {
      phoneNumberError.value = "";
    }

    if (passwordController.text.trim().isEmpty) {
      passwordError.value = "Password is required";
      isValid = false;
    } else {
      passwordError.value = "";
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      confirmPasswordError.value = "Confirm your password";
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = "Passwords do not match";
      isValid = false;
    } else {
      confirmPasswordError.value = "";
    }

    if (isValid) {
      // Call your submit or API logic here
      print("Form is valid, proceed to submit...");
    }
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
