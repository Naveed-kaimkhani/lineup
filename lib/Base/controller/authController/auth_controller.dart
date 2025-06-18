import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/model/authModel/loginModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/SharedPreferencesKeysConstants.dart';
import '../../../routes/routes_path.dart';
import '../../../service/api/authApi.dart';
import '../../../utils/SharedPreferencesUtil.dart';

class SignInController extends GetxController {
  // Controllers for email and password fields
  var emailController = TextEditingController();

  var orgCodeController = TextEditingController();
  var passwordController = TextEditingController();

  // Reactive variables for error messages
  var emailError = RxString('');
  var passwordError = RxString('');

  var orgCodeError = RxString('');
  // Reactive variable for the remember me checkbox
  var isRememberMe = RxBool(false);
  var isLoading = false.obs;

  // Toggle checkbox
  Future<void> toggleRememberMe(bool? value) async {
    isRememberMe.value = value ?? false;
    if (isRememberMe.value) {
      await saveCredentials();
    }
  }

  // 0 = User (default), 1 = Admin
  RxInt selectedRole = 0.obs;

  void setRole(int value) {
    selectedRole.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    loadSavedCredentials();
  }

  // Load saved email & password
  Future<void> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email') ?? '';
    final savedPassword = prefs.getString('password') ?? '';
    final remember = prefs.getBool('remember_me') ?? false;

    if (remember) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      isRememberMe.value = remember;
    }
  }

  // Save credentials if Remember Me checked
  Future<void> saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (isRememberMe.value) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('remember_me', false);
    }
  }

  // Sign in function
  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Clear previous errors
    emailError.value = '';
    passwordError.value = '';

    // Validate fields
    bool isEmailValid = _validateEmail(email);
    bool isPasswordValid = _validatePassword(password);

    // if (isEmailValid && isPasswordValid)
    if (true) {
      // final request = LoginModel(email: email, password: password);

      final request = LoginModel(
        email: "shahbazvidicraze@gmail.com",
        password: "12345678",
      );
      final response;
      if (email.toString() == "admin@lineup.com")
      // if (true)
      {
        response = await AuthAPI.loginAdmin(request);
      } else {
        response = await AuthAPI.loginUser(
          request,
        ); // Replace with `loginUser()` if needed
      }
      if (isRememberMe.value) {
        await saveCredentials();
      }

      if (response.success!) {
        await SharedPreferencesUtil.save(
          SharedPreferencesKeysConstants.isLogin,
          "1",
        );
        if (response.data!.user!.role_id == 1) {
          Get.toNamed(RoutesPath.adminDashboardScreen);
        } else {
          await SharedPreferencesUtil.save(
            SharedPreferencesKeysConstants.isLogin,
            "1",
          );
          Get.toNamed(RoutesPath.mainDashboardScreen);
        }

        Get.snackbar('Success', 'User signed in successfully');
        // Navigate to home or dashboard
        // Get.toNamed(RoutesPath.home);
      } else {
        Get.snackbar('Error', response.message.toString());
      }
    } else {
      if (!isEmailValid) {
        emailError.value = 'Please enter a valid email address';
      }
      if (!isPasswordValid) passwordError.value = 'Password cannot be empty';
    }
  }

  Future<void> organizationSignIn() async {
    final orgCode = orgCodeController.text.trim();
    final password = passwordController.text;

    // Clear previous errors
    orgCodeError.value = '';
    passwordError.value = '';

    // Validate fields
    bool isOrgCodeValid = orgCode.isNotEmpty;
    bool isPasswordValid = password.isNotEmpty;
    // if (true)
    if (isOrgCodeValid && isPasswordValid) {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        final response = await AuthAPI.loginOrganization({
          "organization_code": orgCode,
          "password": password,
        });
        isLoading.value = false;
        if (Get.isDialogOpen ?? false) Get.back(); // Close dialog

        if (response['success'] == true) {
          final token = response['data']['access_token'];
          final orgData = response['data']['organization'];

          // Save token and organization data as needed
          await SharedPreferencesUtil.save(
            SharedPreferencesKeysConstants.isLogin,
            "1",
          );
          await SharedPreferencesUtil.save(
            "org_access_token",
            token,
          ); // optional
          await SharedPreferencesUtil.save(
            "organization_code",
            orgData["organization_code"],
          ); // optional

          // Navigate to organization dashboard
          Get.toNamed(RoutesPath.organizationDashboardScreen);

          Get.snackbar("Success", "Organization login successful.");
        } else {
          Get.snackbar("Login Failed", response["message"] ?? "Unknown error");
        }
      } catch (e) {
        Get.snackbar("Error", "Something went wrong. Please try again.");
        print("Login error: $e");
      }
    } else {
      if (!isOrgCodeValid) orgCodeError.value = 'Organization code is required';
      if (!isPasswordValid) passwordError.value = 'Password cannot be empty';
    }
  }

  bool _validateEmail(String email) =>
      email.contains('@') && email.contains('.');
  bool _validatePassword(String password) => password.isNotEmpty;

  // Navigation
  void goToForgotPassword() {
    // Navigate to Forgot Password
    // Get.to(ForgotPasswordScreen());
  }

  void goToSignUp() {
    // Get.to(() => const SignUpScreen());

    Get.toNamed(RoutesPath.signUpScreen);
  }

  void signInWithGmail() {
    // TODO: Add Gmail sign-in
  }

  void signInWithFacebook() {
    // TODO: Add Facebook sign-in
  }
}
