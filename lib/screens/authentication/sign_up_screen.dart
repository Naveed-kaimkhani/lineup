import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/custom_text_button.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_form.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/player_background_scaffold.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:gaming_web_app/routes/routes_path.dart';
import 'package:get/get.dart';

import '../../Base/controller/authController/signincontroller.dart';

// Updated SignUpScreen using GetX
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return PlayerBackgroundScaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;

              // Define device types
              final isMobile = screenWidth < 600;
              final isDesktop = screenWidth > 1024;

              return SingleChildScrollView(
                child: Align(
                  alignment: isDesktop
                      ? Alignment.centerLeft // Align to left on desktop
                      : Alignment.center, // Center content on mobile
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // maxWidth: isMobile ? 400 : 600, // Adjust maxWidth for responsiveness
                    ),
                    child: Padding(
                      padding: isMobile
                          ? EdgeInsets.symmetric(horizontal:10,vertical: 10) // Add horizontal padding for mobile
                          : EdgeInsets.symmetric(horizontal:30,vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 58.h),
                          CustomForm(
                            header: 'Sign Up',
                            description: 'Manage your team and create game-ready lineups.',
                            body: Column(
                              children: [
                                // First & Last Name Fields
                                isMobile
                                    ? Column(
                                  children: [
                                    PrimaryTextField(
                                      controller: controller.firstNameController,
                                      label: 'First Name',
                                    ),
                                    Obx(() {
                                      return Text(
                                        controller.firstNameError.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      );
                                    }),
                                    SizedBox(height: 10.h),
                                    PrimaryTextField(
                                      controller: controller.lastNameController,
                                      label: 'Last Name',
                                    ),
                                    Obx(() {
                                      return Text(
                                        controller.lastNameError.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      );
                                    }),
                                  ],
                                )
                                    : Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryTextField(
                                        controller: controller.firstNameController,
                                        label: 'First Name',
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: PrimaryTextField(
                                        controller: controller.lastNameController,
                                        label: 'Last Name',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),

                                // Email & Phone Fields
                                isMobile
                                    ? Column(
                                  children: [
                                    PrimaryTextField(
                                      controller: controller.emailController,
                                      label: 'Email',
                                    ),
                                    Obx(() {
                                      return Text(
                                        controller.emailError.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      );
                                    }),
                                    SizedBox(height: 10.h),
                                    PrimaryTextField(
                                      controller: controller.phoneNumberController,
                                      label: 'Phone',
                                    ),
                                    Obx(() {
                                      return Text(
                                        controller.phoneNumberError.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      );
                                    }),
                                  ],
                                )
                                    : Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryTextField(
                                        controller: controller.emailController,
                                        label: 'Email',
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: PrimaryTextField(
                                        controller: controller.phoneNumberController,
                                        label: 'Phone',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),

                                // Password Fields
                                PrimaryTextField(
                                  controller: controller.passwordController,
                                  label: 'Password',
                                  obscureText: true,
                                ),
                                Obx(() {
                                  return Text(
                                    controller.passwordError.value,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  );
                                }),
                                SizedBox(height: 10.h),
                                PrimaryTextField(
                                  controller: controller.confirmPasswordController,
                                  label: 'Confirm Password',
                                  obscureText: true,
                                ),
                                Obx(() {
                                  return Text(
                                    controller.confirmPasswordError.value,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  );
                                }),
                                SizedBox(height: 10.h),

                                // Sign Up Button
                                PrimaryButton(
                                  onTap: controller.signUp,
                                  title: 'Sign Up',
                                  width: double.infinity,
                                  radius: 4.89.r,
                                  backgroundColor: AppColors.secondaryColor,
                                ),
                                SizedBox(height: 10.h),

                                // Login Text Row
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Already Have Account ? ' ,
                                      // style: descriptionStyle,
                                    ),
                                    CustomTextButton(
                                      title: ' Click here to Login.',
                                      // fontSize: 18.sp,
                                      onTap: controller.goToLogin,
                                      hasUnderline: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Bottom Image
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/images/line_up_hero_header.png',
              width: 360.w,
              height: 146.h,
            ),
          ),
        ],
      ),
    );
  }
}
