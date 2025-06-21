import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:get/get.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import '../../Base/controller/authController/userProfileController.dart';
import '../../constants/widgets/custom_form.dart';
import '../../routes/routes_path.dart';

class UserprofileDialog extends StatelessWidget {
  final UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 600;

          return SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isMobile ? 400 : 600),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: isMobile ? 0 : 00,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      CustomForm(
                        header: 'Profile',
                        description: '',
                        isBack: true,
                        body: Column(
                          children: [
                            Column(
                              children: [
                                // First & Last Name
                                isMobile
                                    ? Column(
                                      children: [
                                        PrimaryTextField(
                                          readAble: true,
                                          controller:
                                              controller.firstNameController,
                                          label: 'First Name',
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.firstNameError.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        PrimaryTextField(
                                          readAble: true,
                                          controller:
                                              controller.lastNameController,
                                          label: 'Last Name',
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.lastNameError.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    : Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PrimaryTextField(
                                                readAble: true,
                                                controller:
                                                    controller
                                                        .firstNameController,
                                                label: 'First Name',
                                              ),
                                              Obx(
                                                () => Text(
                                                  controller
                                                      .firstNameError
                                                      .value,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PrimaryTextField(
                                                readAble: true,
                                                controller:
                                                    controller
                                                        .lastNameController,
                                                label: 'Last Name',
                                              ),
                                              Obx(
                                                () => Text(
                                                  controller
                                                      .lastNameError
                                                      .value,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                SizedBox(height: 10),

                                // Email & Phone
                                isMobile
                                    ? Column(
                                      children: [
                                        PrimaryTextField(
                                          readAble: true,
                                          controller:
                                              controller.emailController,
                                          label: 'Email',
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.emailError.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        PrimaryTextField(
                                          readAble: true,
                                          controller:
                                              controller.phoneNumberController,
                                          label: 'Phone',
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.phoneNumberError.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PrimaryTextField(
                                          readAble: true,
                                          controller:
                                              controller.emailController,
                                          label: 'Email',
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.emailError.value,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            PrimaryTextField(
                                              readAble: true,
                                              controller:
                                                  controller
                                                      .phoneNumberController,
                                              label: 'Phone',
                                            ),
                                            Obx(
                                              () => Text(
                                                controller
                                                    .phoneNumberError
                                                    .value,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            PrimaryButton(
                                              onTap: () async {
                                                await SharedPreferencesUtil.clear();
                                                Get.offAllNamed(
                                                  RoutesPath.signIn,
                                                ); // Navigates and clears navigation stack
                                              },
                                              title: 'Logout',
                                              width: double.infinity,
                                              radius: 4.89.r,
                                              backgroundColor:
                                                  AppColors.secondaryColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                SizedBox(height: 10),

                                SizedBox(height: 10),
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
    );
  }
}
