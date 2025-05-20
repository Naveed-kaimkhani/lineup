import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/model/orgnization.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/admin/OrgnizationController.dart';
import '../../Base/model/teamModel/teamModel.dart';
import '../../Base/componant/dropdown.dart';
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
  final OrganizationController organizationController = Get.put(OrganizationController());
  @override
  Widget build(BuildContext context) {

    // Get screen size for responsive calculations
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

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
                               return const Center(child: CircularProgressIndicator());
                             }

                             return DynamicDropdownList<Organizations?>(
                               items: organizationController.organization ?? [],
                               selectedItem: organizationController.selectedOrganization,
                               itemLabelBuilder: (org) => org?.name ?? 'No Name',
                               onChanged:
                                   (val){
                                     controllers.organizationId.value=val!.id!;
                                     print( controllers.organizationId.value);
                                     // controller.  =val.id;
                                     organizationController.setSelectedOrganization;

                               },

                               hint: "Select an organization",
                               dropdownWidth: 400,
                             );
                           },
                         ),

                   //     InkWell(
                   //     onTap: () async {
                   //       controller.organizationId.value = await selectOrganization(context) ?? 0;
                   //
                   //     },
                   //     child:
                   //     Container(
                   //       height: 50,
                   //       padding: EdgeInsets.symmetric(horizontal: 12),
                   //       decoration: BoxDecoration(
                   //         border: Border.all(color: Colors.grey),
                   //         borderRadius: BorderRadius.circular(8),
                   //       ),
                   //       child: Row(
                   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   //         children: [
                   //           Text(controller.organizationId.toString()),
                   //           Icon(Icons.keyboard_arrow_down),
                   //         ],
                   //       ),
                   //     )
                   //
                   //
                   // )

                   ),
                    // PrimaryTextField(
                    //   readAble: true,
                    //   keyboardType:TextInputType.number,
                    //   controller:TextEditingController(text:  controller.organizationId.toString()),
                    //   label: 'Organization ID',
                    //   hintText: 'Type Hello..',
                    // )),
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


Future<int?> selectOrganization(BuildContext context) async {
  final screenSize = MediaQuery.of(context).size;
  final isSmallScreen = screenSize.width < 600;
  final double dialogWidth = isSmallScreen ? screenSize.width * 0.9 : 400;

  final TeamController teamController = Get.find<TeamController>();

  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: dialogWidth),
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Select Organization',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: isSmallScreen ? 18 : 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                height: 300, // Set fixed height for ListView
                width: double.maxFinite, // Allow width to be constrained by parent
                child: teamController.organization.isEmpty
                    ? Center(child: Text("No organizations found."))
                    : ListView.separated(
                  itemCount: teamController.organization.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final org = teamController.organization[index];
                    if (org == null) return SizedBox.shrink();
                    return InkWell(
                      onTap: () => Navigator.pop(context, org.id),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(org.name ?? 'No Name')),
                            // Text(org.id?.toString() ?? '-'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

