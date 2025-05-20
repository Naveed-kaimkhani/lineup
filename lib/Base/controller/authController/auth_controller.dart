import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:gaming_web_app/Base/model/authModel/loginModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/SharedPreferencesKeysConstants.dart';
import '../../../routes/routes_path.dart';
import '../../../screens/authentication/sign_up_screen.dart';
import '../../../service/api/authApi.dart';
import '../../../utils/SharedPreferencesUtil.dart';

class SignInController extends GetxController {
  // Controllers for email and password fields
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Reactive variables for error messages
  var emailError = RxString('');
  var passwordError = RxString('');

  // Reactive variable for the remember me checkbox
  var isRememberMe = RxBool(false);

  // Toggle checkbox
  Future<void> toggleRememberMe(bool? value) async {
    isRememberMe.value = value ?? false;
    if(isRememberMe.value) {
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
       print("1st");
       print(savedEmail);
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

    if (isEmailValid && isPasswordValid) {
      final request = LoginModel(email: email, password: password);
      final response;
      if(email.toString()=="admin@lineup.com"){
        response = await AuthAPI.loginAdmin(
          request,
        );
      }else {
        response = await AuthAPI.loginUser(
          request,
        ); // Replace with `loginUser()` if needed
      }
      // GetPage(name: RoutesPath.adminDashboardScreen, page: () => AdminDashboardScreen()),
      if(isRememberMe.value) {
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

  bool _validateEmail(String email) =>
      email.contains('@') && email.contains('.');
  bool _validatePassword(String password) => password.isNotEmpty;

  // Navigation
  void goToForgotPassword() {
    // Navigate to Forgot Password
    // Get.to(ForgotPasswordScreen());
  }

  void goToSignUp() {
    Get.to(() => const SignUpScreen());
  }

  void signInWithGmail() {
    // TODO: Add Gmail sign-in
  }

  void signInWithFacebook() {
    // TODO: Add Facebook sign-in
  }
}

// // SignInController to manage state with GetX instead of setState
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:gaming_web_app/routes/routes_path.dart';
//
//
// class SignInController extends GetxController {
//   // Text editing controllers for input fields
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   // Observable variable to track remember me state (replaces the setState boolean)
//   final RxBool isRememberMe = false.obs;
//
//   // Toggle remember me checkbox state
//   void toggleRememberMe(bool? value) {
//     isRememberMe.value = value ?? false;
//   }
//
//   // Navigate to forgot password screen
//   void goToForgotPassword() {
//     Get.toNamed(RoutesPath.forgotPassword);
//   }
//
//   // Navigate to main dashboard screen after sign in
//   void signIn() {
//     // Here you would typically add authentication logic
//     // For now, just navigate to dashboard
//     Get.toNamed(RoutesPath.mainDashboardScreen);
//   }
//
//   // Navigate to sign up screen
//   void goToSignUp() {
//     Get.toNamed(RoutesPath.signUp);
//   }
//
//   // Handle social sign in (Gmail)
//   void signInWithGmail() {
//     // Implement Gmail sign-in functionality
//   }
//
//   // Handle social sign in (Facebook)
//   void signInWithFacebook() {
//     // Implement Facebook sign-in functionality
//   }
//
//   @override
//   void onClose() {
//     // Clean up controllers when the controller is removed
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }
//
//
//
// // SIGN UP SCREEN WITH GETX
// // First, create a controller for SignUp functionality
// class SignUpController extends GetxController {
//   // Text editing controllers for all input fields
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   // Handle sign up form submission
//   void signUp() {
//     // Implement sign up logic here
//     // Validation, API calls, etc.
//   }
//
//   // Navigate to login screen
//   void goToLogin() {
//     Get.toNamed(RoutesPath.teamDashboardScreen);
//   }
//
//   @override
//   void onClose() {
//     // Clean up all controllers when the controller is removed
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneNumberController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.onClose();
//   }
// }
