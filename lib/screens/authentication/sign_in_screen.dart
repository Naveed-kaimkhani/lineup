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
                          SizedBox(height: 58.h),
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
                                          CrossAxisAlignment.start,
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

                                  // SizedBox(height: 19.57.h),
                                  // Text(
                                  //   'or sign in with other accounts?',
                                  //   style: descriptionStyle,
                                  // ),
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
                                              Text(
                                                'Don\'t have an account?',
                                                // style: descriptionStyle,
                                              ),
                                              CustomTextButton(
                                                title:
                                                    ' Click here to sign up.',
                                                fontSize: 16,
                                                onTap: controller.goToSignUp,
                                                hasUnderline: true,
                                              ),
                                            ],
                                          )
                                          : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Don\'t have an account?',
                                                // style: descriptionStyle,
                                              ),
                                              CustomTextButton(
                                                title:
                                                    ' Click here to sign up.',
                                                fontSize: 16,
                                                onTap: controller.goToSignUp,
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
// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final SignInController controller = Get.put(SignInController());
//
//     return PlayerBackgroundScaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 58.h),
//                 CustomForm(
//                   header: 'Sign In',
//                   description:
//                       'Start building fair and balanced lineups in seconds.',
//                   body: Column(
//                     children: [
//                       /// Email Field
//                       Obx(
//                         () => Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             PrimaryTextField(
//                               controller: controller.emailController,
//                               label: 'Email',
//                             ),
//                             if (controller.emailError.value.isNotEmpty)
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 12,
//                                   top: 4,
//                                 ),
//                                 child: Text(
//                                   controller.emailError.value,
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 12.sp,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//
//                       /// Password Field
//                       Obx(
//                         () => Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             PrimaryTextField(
//                               controller: controller.passwordController,
//                               label: 'Password',
//                               obscureText: true,
//                             ),
//                             if (controller.passwordError.value.isNotEmpty)
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 12,
//                                   top: 4,
//                                 ),
//                                 child: Text(
//                                   controller.passwordError.value,
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 12.sp,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                       // Center(
//                       //   child: Obx(
//                       //     () => Row(
//                       //       mainAxisAlignment: MainAxisAlignment.start,
//                       //       children: [
//                       //         Row(
//                       //           children: [
//                       //             Radio<int>(
//                       //               value: 0,
//                       //               groupValue: controller.selectedRole.value,
//                       //               activeColor: Colors.blue,
//                       //               onChanged:
//                       //                   (value) => controller.setRole(value!),
//                       //             ),
//                       //             const Text("User"),
//                       //           ],
//                       //         ),
//                       //         SizedBox(width: 20),
//                       //         Row(
//                       //           children: [
//                       //             Radio<int>(
//                       //               value: 1,
//                       //               groupValue: controller.selectedRole.value,
//                       //               activeColor: Colors.blue,
//                       //               onChanged:
//                       //                   (value) => controller.setRole(value!),
//                       //             ),
//                       //             const Text("Admin"),
//                       //           ],
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ),
//                       SizedBox(height: 10.h),
//
//                       /// Remember Me & Forgot Password
//                       Row(
//                         children: [
//                           Obx(
//                             () => Checkbox(
//                               value: controller.isRememberMe.value,
//                               onChanged: controller.toggleRememberMe,
//                               activeColor: AppColors.primaryColor,
//                               side: const BorderSide(
//                                 color: Colors.grey,
//                                 width: 1.0,
//                               ),
//                             ),
//                           ),
//                           Text('Remember me?', style: fieldLabelStyle),
//                           const Spacer(),
//
//                          //  CustomTextButton(
//                          //    onTap: (){
//                          //      Get.to(ForgotPasswordScreen());
//                          //      // Get.toNamed(RoutesPath.forgotPassword);
//                          //    },
//                          //   title: 'Forgot Password',
//                          //   // onTap: controller.goToForgotPassword,
//                          // ),
//                         ],
//                       ),
//
//                       SizedBox(height: 29.36.h),
//
//                       /// Sign In Button
//                       PrimaryButton(
//                         onTap: () {
//                           controller.signIn();
//                           // Get.toNamed(RoutesPath.mainDashboardScreen);
//                         },
//                         // controller.signIn,
//                         title: 'Sign in',
//                         width: 540.4.w,
//                         radius: 4.89.r,
//                         backgroundColor: AppColors.secondaryColor,
//                       ),
//
//                       SizedBox(height: 19.57.h),
//                       Text(
//                         'or sign in with other accounts?',
//                         style: descriptionStyle,
//                       ),
//                       SizedBox(height: 19.57.h),
//
//                       /// Social Buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SocialAppButton(
//                             image: 'assets/images/gmail_icon.png',
//                             onTap: controller.signInWithGmail,
//                           ),
//                           SizedBox(width: 13.w),
//                           SocialAppButton(
//                             image: 'assets/images/facebook_icon.png',
//                             onTap: controller.signInWithFacebook,
//                           ),
//                         ],
//                       ),
//
//                       SizedBox(height: 19.57.h),
//
//                       /// Sign Up Redirect
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Don\'t have an account?',
//                             style: descriptionStyle,
//                           ),
//                           CustomTextButton(
//                             title: ' Click here to sign up.',
//                             fontSize: 18.sp,
//                             onTap: controller.goToSignUp,
//                             hasUnderline: true,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           /// Bottom Image
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Image.asset(
//               'assets/images/line_up_hero_header.png',
//               width: 360.w,
//               height: 146.h,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/custom_text_button.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/social_app_button.dart';
// import 'package:gaming_web_app/constants/widgets/custom_form.dart';
// import 'package:gaming_web_app/constants/widgets/custom_scaffold/player_background_scaffold.dart';
// import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
// import 'package:gaming_web_app/routes/routes_path.dart';
// import 'package:gaming_web_app/screens/main_dashboard/set_player_position_screen.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../../Base/controller/auth_controller.dart';
//
// // Updated SignInScreen using GetX
// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Initialize the controller using GetX dependency injection
//     // This will automatically handle the controller lifecycle
//     final SignInController controller = Get.put(SignInController());
//
//     return PlayerBackgroundScaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 58.h),
//                 CustomForm(
//                   header: 'Sign In',
//                   description:
//                   'Start building fair and balanced lineups in seconds.',
//                   body: Column(
//                     children: [
//                       // Email input field
//                       PrimaryTextField(
//                         controller: controller.emailController,
//                         label: 'Email',
//                       ),
//
//                       // Password input field
//                       PrimaryTextField(
//                         controller: controller.passwordController,
//                         label: 'Password',
//                       ),
//
//                       Row(
//                         children: [
//                           // Remember me checkbox with GetX Obx widget for reactive state management
//                           // Obx automatically rebuilds when isRememberMe changes
//                           Obx(() => Checkbox(
//                             value: controller.isRememberMe.value,
//                             onChanged: controller.toggleRememberMe,
//                             activeColor: AppColors.primaryColor,
//                             side: const BorderSide(
//                               color: Colors.grey,
//                               width: 1.0,
//                             ),
//                           )),
//                           Text('Remember me?', style: fieldLabelStyle),
//                           Spacer(),
//
//                           // Forgot password button
//                           CustomTextButton(
//                             title: 'Forgot Password',
//                             onTap: controller.goToForgotPassword,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 29.36.h),
//
//                       // Sign in button
//                       PrimaryButton(
//                         onTap: controller.signIn,
//                         title: 'Sign in',
//                         width: 540.4.w,
//                         radius: 4.89.r,
//                         backgroundColor: AppColors.secondaryColor,
//                       ),
//                       SizedBox(height: 19.57.h),
//                       Text(
//                         'or sign in with other accounts?',
//                         style: descriptionStyle,
//                       ),
//                       SizedBox(height: 19.57.h),
//
//                       // Social login buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SocialAppButton(
//                             image: 'assets/images/gmail_icon.png',
//                             onTap: controller.signInWithGmail,
//                           ),
//                           SizedBox(width: 13.w),
//                           SocialAppButton(
//                             image: 'assets/images/facebook_icon.png',
//                             onTap: controller.signInWithFacebook,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 19.57.h),
//
//                       // Sign up suggestion row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Dont have an account?',
//                             style: descriptionStyle,
//                           ),
//                           CustomTextButton(
//                             title: ' Click here to sign up.',
//                             fontSize: 18.sp,
//                             onTap: controller.goToSignUp,
//                             hasUnderline: true,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Bottom right image
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Image.asset(
//               'assets/images/line_up_hero_header.png',
//               width: 360.w,
//               height: 146.h,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
