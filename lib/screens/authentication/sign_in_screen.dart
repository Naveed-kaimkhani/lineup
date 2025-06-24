import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/custom_text_button.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/buttons/social_app_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_form.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/player_background_scaffold.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:get/get.dart';
import '../../Base/controller/authController/auth_controller.dart';
import '../../routes/routes_path.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());
    controller.loadSavedCredentials();
    return PlayerBackgroundScaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              final isDesktop = constraints.maxWidth > 1024;

              return SingleChildScrollView(
                child: Align(
                  alignment:
                      isDesktop
                          ? Alignment
                              .centerLeft // Align to left on desktop
                          : Alignment.center, // Center content on mobile
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          isMobile
                              ? double.infinity
                              : 600, // Allow full width for mobile
                    ),
                    child: Padding(
                      padding:
                          isMobile
                              ? EdgeInsets.symmetric(
                                horizontal: 10,
                              ) // Add horizontal padding for mobile
                              : EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 30,
                              ), // No padding for desktop
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(height: 58.h),
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: CustomForm(
                              header: 'Sign In',
                              description:
                                  'Start building fair and balanced lineups in seconds.',
                              body: Column(
                                children: [
                                  // Email Field
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        PrimaryTextField(
                                          controller:
                                              controller.emailController,
                                          label: 'Email',
                                        ),
                                        if (controller
                                            .emailError
                                            .value
                                            .isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 12,
                                              top: 4,
                                            ),
                                            child: Text(
                                              controller.emailError.value,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Password Field
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PrimaryTextField(
                                          controller:
                                              controller.passwordController,
                                          label: 'Password',
                                          obscureText: true,
                                        ),
                                        if (controller
                                            .passwordError
                                            .value
                                            .isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 12,
                                              top: 4,
                                            ),
                                            child: Text(
                                              controller.passwordError.value,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10.h),

                                  // Remember Me
                                  Row(
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          value: controller.isRememberMe.value,
                                          onChanged:
                                              controller.toggleRememberMe,
                                          activeColor: AppColors.primaryColor,
                                          side: const BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Remember me?',
                                          // style: fieldLabelStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            RoutesPath.forgotPassword,
                                          );
                                        },
                                        child: const Text(
                                          'Forgot Password',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 29.36.h),

                                  // Sign In Button
                                  PrimaryButton(
                                    onTap: controller.signIn,
                                    title: 'Sign in',
                                    width: double.infinity,
                                    radius: 4.89.r,
                                    backgroundColor: AppColors.secondaryColor,
                                  ),

                                  SizedBox(height: 19.57.h),

                                  // Sign Up Redirect
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final isMobile =
                                          constraints.maxWidth < 600;

                                      return isMobile
                                          ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Don\'t have an account?',
                                                    // style: descriptionStyle,
                                                  ),
                                                  SizedBox(width: 10),
                                                  CustomTextButton(
                                                    title:
                                                        ' Click here to sign up',
                                                    fontSize: 8,
                                                    onTap:
                                                        controller.goToSignUp,
                                                    hasUnderline: true,
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 10),
                                              CustomTextButton(
                                                title: ' Organization SignIn',
                                                fontSize: 16,
                                                onTap:
                                                // controller
                                                //     .organizationSignup,
                                                () {
                                                  Get.toNamed(
                                                    RoutesPath
                                                        .OrganizationSignin,
                                                  );
                                                },
                                                hasUnderline: true,
                                              ),
                                            ],
                                          )
                                          : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Don\'t have an account?',
                                                    // style: descriptionStyle,
                                                  ),
                                                  SizedBox(width: 10),
                                                  CustomTextButton(
                                                    title:
                                                        ' Click here to sign up',
                                                    fontSize: 8,
                                                    onTap:
                                                    // controller.goToSignUp,
                                                    () {
                                                      Get.toNamed(
                                                        RoutesPath
                                                            .OrganizationSignin,
                                                      );
                                                    },
                                                    hasUnderline: true,
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 10),
                                              CustomTextButton(
                                                title: ' Organization SignIn',
                                                fontSize: 16,
                                                onTap:
                                                    controller
                                                        .organizationSignup,
                                                hasUnderline: true,
                                              ),
                                            ],
                                          );
                                    },
                                  ),
                                ],
                              ),
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
