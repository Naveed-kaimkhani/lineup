import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/controller/authController/change_password_controller.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_form.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:get/get.dart';

class ORGChangePasswordScreen extends StatelessWidget {
  const ORGChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.put(ChangePasswordController());

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              final isDesktop = constraints.maxWidth > 1024;

              return SingleChildScrollView(
                child: Align(
                  alignment: isDesktop ? Alignment.centerLeft : Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 600),
                    child: Padding(
                      padding: isMobile
                          ? const EdgeInsets.symmetric(horizontal: 10)
                          : const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomForm(
                            header: 'Change Password',
                            description: 'Update your password securely.',
                            body: Column(
                              children: [
                                Obx(() => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        PrimaryTextField(
                                          controller: controller.currentPasswordController,
                                          label: 'Current Password',
                                          obscureText: true,
                                        ),
                                        if (controller.currentPasswordError.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12, top: 4),
                                            child: Text(
                                              controller.currentPasswordError.value,
                                              style: TextStyle(color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    )),
                                const SizedBox(height: 16),
                                Obx(() => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        PrimaryTextField(
                                          controller: controller.newPasswordController,
                                          label: 'New Password',
                                          obscureText: true,
                                        ),
                                        if (controller.newPasswordError.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12, top: 4),
                                            child: Text(
                                              controller.newPasswordError.value,
                                              style: TextStyle(color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    )),
                                const SizedBox(height: 16),
                                Obx(() => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        PrimaryTextField(
                                          controller: controller.confirmPasswordController,
                                          label: 'Confirm Password',
                                          obscureText: true,
                                        ),
                                        if (controller.confirmPasswordError.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12, top: 4),
                                            child: Text(
                                              controller.confirmPasswordError.value,
                                              style: TextStyle(color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    )),
                                const SizedBox(height: 32),
                                Obx(() => PrimaryButton(
                                      onTap: controller.OrgChangePassword,
                                      title: controller.isLoading.value ? 'Please wait...' : 'Update Password',
                                      width: double.infinity,
                                      radius: 8,
                                      backgroundColor: AppColors.primaryColor,
                                    )),
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
        ],
      ),
    );
  }
}
