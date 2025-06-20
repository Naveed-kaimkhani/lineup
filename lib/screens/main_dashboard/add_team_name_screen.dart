import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:get/get.dart';

import '../../Base/controller/admin/OrgnizationController.dart';
import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/teamController.dart';

class AddTeamNameScreen extends StatefulWidget {
  const AddTeamNameScreen({super.key});

  @override
  State<AddTeamNameScreen> createState() => _AddTeamNameScreenState();
}

class _AddTeamNameScreenState extends State<AddTeamNameScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      organizationController.fetchOrganization();
    });
  }

  final NewTeamController controllers = Get.find<NewTeamController>();
  final TeamController teamController = Get.find<TeamController>();
  final OrganizationController organizationController = Get.put(
    OrganizationController(),
  );
  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive calculations
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    final NewTeamController newTeamController = Get.find<NewTeamController>();
    bool check = newTeamController.isHavingCredit.value;
    // Scale font size based on screen width
    final headerFontSize = isSmallScreen ? 18.0 : 25.0;

    // Vertical spacing that adapts to screen height
    final topSpacing = screenSize.height * 0.02; // 2% of screen height
    final betweenFieldsSpacing =
        screenSize.height * 0.025; // 2.5% of screen height

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate max width for text fields based on container width
        final fieldWidth =
            constraints.maxWidth > 600
                ? 600.0 // Cap max width on large screens
                : constraints.maxWidth *
                    0.9; // Use 90% of width on small screens

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: fieldWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: topSpacing),
                    Text(
                      'ENTER TEAM NAME',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: headerFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: betweenFieldsSpacing),
                    PrimaryTextField(
                      controller: controllers.teamNameController,
                      label: 'Enter Team Name',
                      hintText: 'Tiger',
                    ),
                    SizedBox(height: 16), // Fixed spacing between fields

                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: GetBuilder<OrganizationController>(
                        builder: (controller) {
                          if (controller.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return PrimaryTextField(
                            controller: controllers.orgCode,
                            label:
                                check
                                    ? 'Organization Code (Optional)'
                                    : 'Organization Code',
                            hintText: 'Tiger',
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: betweenFieldsSpacing,
                    ), // Add bottom padding
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
