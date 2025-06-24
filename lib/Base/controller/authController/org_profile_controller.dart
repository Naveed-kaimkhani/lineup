import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/SharedPreferencesKeysConstants.dart';
import '../../../utils/SharedPreferencesUtil.dart';
import '../../model/authModel/loginModel.dart';

class OrgProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var firstName = ''.obs;
  var firstNameError = ''.obs;
  var lastNameError = ''.obs;
  var emailError = ''.obs;
  var phoneNumberError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrganizationData();
  }

  Future<void> loadOrganizationData() async {
    final name = await SharedPreferencesUtil.read("organization_name");
    final code = await SharedPreferencesUtil.read("organization_code");
    final emailVal = await SharedPreferencesUtil.read("organization_email");
    final subStatus = await SharedPreferencesUtil.read("subscription_status");
    final subExpires = await SharedPreferencesUtil.read(
      "subscription_expires_at",
    );

    if (name != null) {
      firstName.value = name;
      firstNameController.text = name;
    }

    if (emailVal != null) {
      emailController.text = emailVal;
    }

    // You can use the other values like code, subStatus, subExpires as needed
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
