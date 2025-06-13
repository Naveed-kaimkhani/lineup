import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/widgets/buttons/custom_text_button.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_form.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/player_background_scaffold.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:gaming_web_app/routes/routes_path.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/authController/auth_controller.dart';
import '../../Base/controller/authController/forgotPasswordController.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return PlayerBackgroundScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isPhone = constraints.maxWidth < 600;

                Widget form = CustomForm(
                  header: 'Forgot Password?',
                  description:
                  'No worries! Enter your email and we\'ll send you reset instructions.',
                  body:Obx(()=> Column(
                    children: [
                      PrimaryTextField(
                        controller: controller.emailController,
                        label: 'Email',
                      ),
                      controller.isMail.value?
                          Column(children: [

                            PrimaryTextField(
                              controller: controller.otpController,
                              label: 'OTP ',
                            ),PrimaryTextField(
                              obscureText: true,
                              controller: controller.password,
                              label: 'Password ',
                            ),PrimaryTextField(
                              obscureText: true,
                              controller: controller.passwordConfirmation,
                              label: 'Confirm Password ',
                            ),
                          ],)
                     :SizedBox(),

                      PrimaryButton(
                        onTap: () => {
                          controller.isMail.value? controller.resetPassword() :
                          controller.sendCode()
                        },

                        //     Navigator.pushNamed(
                        //   context,
                        //   RoutesPath.organizationDashboardScreen,
                        // ),
                        title:controller.isMail.value?"Update" :'Send Code',
                        width: 540.4,
                        radius: 4.89.r,
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      SizedBox(height: 19.57.h),
                      CustomTextButton(
                        title: ' Back to Login',
                        // fontSize: 18.sp,
                        onTap: () => Navigator.pushNamed(
                          context,
                          RoutesPath.signIn,
                        ),
                        hasUnderline: true,
                      ),
                    ],
                  )),
                );

                return Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 291.h),
                      isPhone
                          ? Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Padding(padding:EdgeInsets.all(10) ,child: form,),
                        ),
                      )
                          :Padding(padding:EdgeInsets.only(left: 50) ,child: Align(

                        alignment: Alignment.centerLeft,
                        child: form,
                      )),
                    ],
                  ),
                );
              },
            ),
          ),
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






// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/custom_text_button.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
// import 'package:gaming_web_app/constants/widgets/custom_form.dart';
// import 'package:gaming_web_app/constants/widgets/custom_scaffold/player_background_scaffold.dart';
// import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
// import 'package:gaming_web_app/routes/routes_path.dart';
//
// class ForgotPasswordScreen extends StatelessWidget {
//   ForgotPasswordScreen({super.key});
//   final TextEditingController _emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return PlayerBackgroundScaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 291.h),
//                 CustomForm(
//                   header: 'Forgot Password?',
//                   description:
//                       'No worries! Enter your email and we\'ll send you reset instructions.',
//                   body: Column(
//                     children: [
//                       PrimaryTextField(
//                         controller: _emailController,
//                         label: 'Email',
//                       ),
//
//                       PrimaryButton(
//                         onTap:
//                             () => Navigator.pushNamed(
//                               context,
//                               RoutesPath.organizationDashboardScreen,
//                             ),
//                         title: 'Send Code',
//                         width: 540.4.w,
//                         radius: 4.89.r,
//                         backgroundColor: AppColors.secondaryColor,
//                       ),
//                       SizedBox(height: 19.57.h),
//                       CustomTextButton(
//                         title: ' Back to Login',
//                         fontSize: 18.sp,
//                         onTap:
//                             () =>
//                                 Navigator.pushNamed(context, RoutesPath.signIn),
//                         hasUnderline: true,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
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
