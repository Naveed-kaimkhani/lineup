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



//
//
// import 'package:flutter/material.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/custom_text_button.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
// import 'package:gaming_web_app/constants/widgets/custom_form.dart';
// import 'package:gaming_web_app/constants/widgets/custom_scaffold/player_background_scaffold.dart';
// import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
// import 'package:gaming_web_app/routes/routes_path.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../Base/controller/authController/auth_controller.dart';
//
// // Updated SignUpScreen using GetX
// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Initialize the controller using GetX dependency injection
//
//
//     // Get actual screen size
//     final Size screenSize = MediaQuery.of(context).size;
//
//     return PlayerBackgroundScaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double screenWidth = constraints.maxWidth;
//
//           // More granular breakpoints for responsive design
//           bool isSmallDevice = screenWidth < 400;
//           bool isMobile = screenWidth >= 400 && screenWidth < 600;
//           bool isTablet = screenWidth >= 600 && screenWidth < 1024;
//           bool isDesktop = screenWidth >= 1024;
//
//           // Adjust padding based on screen size
//           EdgeInsetsGeometry contentPadding = EdgeInsets.symmetric(
//             horizontal: isSmallDevice ? 12.0 : isMobile ? 16.0 : isTablet ? 60.0 : 117.0,
//             vertical: isSmallDevice || isMobile ? 12.0 : isTablet ? 30.0 : 52.0,
//           );
//
//           // Adjust field spacing
//           double fieldSpacing = isSmallDevice ? 8.0 : isMobile ? 10.0 : 20.0;
//
//           // Choose layout strategy based on width
//           bool useStackedLayout = screenWidth < 600;
//
//           return SafeArea(
//             child: Padding(
//               padding: contentPadding,
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     // Ensure minimum height for scrolling
//                     minHeight: constraints.maxHeight - contentPadding.vertical,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: isSmallDevice ? 10.0 : isMobile ? 20.0 : 58.0),
//                       CustomForm(
//                         header: 'Sign Up',
//                         description: 'Manage your team and create game-ready lineups.',
//                         body: Column(
//                           children: [
//                             // First & Last Name Fields - Responsive layout
//                             useStackedLayout
//                                 ? Column(
//                               children: [
//                                 PrimaryTextField(
//                                   controller: controller.firstNameController,
//                                   label: 'First Name',
//                                 ),
//                                 SizedBox(height: fieldSpacing),
//                                 PrimaryTextField(
//                                   controller: controller.lastNameController,
//                                   label: 'Last Name',
//                                 ),
//                               ],
//                             )
//                                 : Row(
//                               children: [
//                                 Expanded(
//                                   child: PrimaryTextField(
//                                     controller: controller.firstNameController,
//                                     label: 'First Name',
//                                   ),
//                                 ),
//                                 SizedBox(width: fieldSpacing),
//                                 Expanded(
//                                   child: PrimaryTextField(
//                                     controller: controller.lastNameController,
//                                     label: 'Last Name',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: fieldSpacing),
//
//                             // Email & Phone Fields - Responsive layout
//                             useStackedLayout
//                                 ? Column(
//                               children: [
//                                 PrimaryTextField(
//                                   controller: controller.emailController,
//                                   label: 'Email',
//                                 ),
//                                 SizedBox(height: fieldSpacing),
//                                 PrimaryTextField(
//                                   controller: controller.phoneNumberController,
//                                   label: 'Phone',
//                                 ),
//                               ],
//                             )
//                                 : Row(
//                               children: [
//                                 Expanded(
//                                   child: PrimaryTextField(
//                                     controller: controller.emailController,
//                                     label: 'Email',
//                                   ),
//                                 ),
//                                 SizedBox(width: fieldSpacing),
//                                 Expanded(
//                                   child: PrimaryTextField(
//                                     controller: controller.phoneNumberController,
//                                     label: 'Phone',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: fieldSpacing),
//
//                             // Password Fields
//                             PrimaryTextField(
//                               controller: controller.passwordController,
//                               label: 'Password',
//                               obscureText: true,
//                             ),
//                             SizedBox(height: fieldSpacing),
//                             PrimaryTextField(
//                               controller: controller.confirmPasswordController,
//                               label: 'Confirm Password',
//                               obscureText: true,
//                             ),
//                             SizedBox(height: fieldSpacing * 1.5),
//
//                             // Sign Up Button - Responsive width
//                             PrimaryButton(
//                               onTap: controller.signUp,
//                               title: 'Sign Up',
//                               width: useStackedLayout ? double.infinity :
//                               isTablet ? 400 : 540.4,
//                               radius: 4.89,
//                               backgroundColor: AppColors.secondaryColor,
//                             ),
//                             SizedBox(height: fieldSpacing),
//
//                             // Login Text Row - Made responsive for small screens
//                             Wrap(
//                               alignment: WrapAlignment.center,
//                               crossAxisAlignment: WrapCrossAlignment.center,
//                               children: [
//                                 Text(
//                                   'Already Have Account?',
//                                   style: descriptionStyle,
//                                 ),
//                                 CustomTextButton(
//                                   title: ' Click here to Login.',
//                                   fontSize: isSmallDevice ? 16.0 : 18.0,
//                                   onTap: controller.goToLogin,
//                                   hasUnderline: true,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: fieldSpacing),
//
//                       // Hero image - scaled appropriately
//                       if (screenWidth > 320) // Hide on very small screens
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: Image.asset(
//                             'assets/images/line_up_hero_header.png',
//                             width: isSmallDevice ? 120.0 :
//                             isMobile ? 180.0 :
//                             isTablet ? 240.0 : 360.0,
//                             height: isSmallDevice ? 49.0 :
//                             isMobile ? 73.0 :
//                             isTablet ? 98.0 : 146.0,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
