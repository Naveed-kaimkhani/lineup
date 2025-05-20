import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/team_dashboard/team_dashboard_for_organization.dart';
import '../../Base/componant/alertDialog.dart';
import '../../Base/componant/dropdown.dart';
import '../../Base/controller/admin/OrgnizationController.dart';
import '../../Base/controller/getTeamData.dart';
import '../../Base/controller/globleController.dart';
import '../../Base/model/teamModel/teamModel.dart';

final GlobleController globleController = Get.put(GlobleController());

class OrganizationDashboardScreen extends StatefulWidget {
  const OrganizationDashboardScreen({super.key});

  @override
  State<OrganizationDashboardScreen> createState() =>
      _OrganizationDashboardScreenState();
}

class _OrganizationDashboardScreenState
    extends State<OrganizationDashboardScreen> {
  final OrganizationController controller = Get.put(OrganizationController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOrganization();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      title: 'Game-Ready',
      subtitle: 'Lineup',
      actionWidget: Container(
        height: 54.h,
        width: 406.w,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(80.r),
        ),
        child: Center(
          child: Text(
            'Organization ID: 12345abcde',
            style: tableContentHeader.copyWith(
              fontSize: 22.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 102.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600;

                return isMobile
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: GetBuilder<OrganizationController>(
                            builder: (controller) {
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return DynamicDropdownList<Organizations?>(
                                items: controller.organization ?? [],
                                selectedItem: controller.selectedOrganization,
                                itemLabelBuilder:
                                    (org) => org?.name ?? 'No Name',
                                onChanged: controller.setSelectedOrganization,
                                hint: "Select an organization",
                                // dropdownWidth: 400,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Teams Linked to Your Organization'.toUpperCase(),
                            style: descriptionHeader.copyWith(
                              fontSize: 18,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                    : Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GetBuilder<OrganizationController>(
                              builder: (controller) {
                                if (controller.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return DynamicDropdownList<Organizations?>(
                                  items: controller.organization ?? [],
                                  selectedItem: controller.selectedOrganization,
                                  itemLabelBuilder:
                                      (org) => org?.name ?? 'No Name',
                                  onChanged: controller.setSelectedOrganization,
                                  hint: "Select an organization",
                                  // dropdownWidth: 300,
                                );
                              },
                            ),
                          ),
                        ),
                        // Expanded(child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Teams Linked to Your Organization'.toUpperCase(),
                            style: descriptionHeader.copyWith(
                              fontSize: 18,
                              color: AppColors.secondaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        // Spacer()
                      ],
                    );
              },
            ),
            SizedBox(height: 27.h),
            Obx(()=>
            controller.teamData.isEmpty ?

            SizedBox(child: Text(
              'Select Organization'.toUpperCase(),
              style: descriptionHeader.copyWith(
                fontSize: 18,
                color: AppColors.secondaryColor,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),):
            TeamTable(controller.teamData)),
            SizedBox(height: 27.h),
          ],
        ),
      ),
    );
  }
}

class TeamTable extends StatelessWidget {
  RxList<TeamData?>  teams;
  TeamTable(this.teams);
  // final controller = Get.put(OrganizationController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _MobileLayout(teams: teams);
        } else if (width < 1024) {
          return _TabletLayout(teams: teams);
        } else {
          return _WebLayout(teams: teams);
        }
      },
    );
  }
}

class _MobileLayout extends StatelessWidget {
  RxList<TeamData?>  teams;

  _MobileLayout({required this.teams});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          teams.map((team) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Team Name", team!.year.toString()),
                  _buildInfoRow("Year", team!.year.toString()),
                  _buildInfoRow("Season", team.season!),
                  _buildInfoRow("Age Group", team.ageGroup!),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          title: 'Delete Team',
                          description:
                              'Are you sure you want to delete this team?',
                          onOk: () => print('Deleted'),
                          onCancel: () => print('Cancelled'),
                        );
                      },
                      child: Image.asset(
                        'assets/images/delete_icon.png',
                        height: 36.h,
                        width: 40.w,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: tableLabel.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: fieldLabelStyle.copyWith(
              fontSize: 12,
              color: AppColors.descriptiveTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletLayout extends _WebLayout {
  _TabletLayout({required super.teams});
}

class _WebLayout extends StatelessWidget {
  RxList<TeamData?>  teams ;

  _WebLayout({required this.teams});

  @override
  Widget build(BuildContext context) {
    final double teamNameWidth = 160;
    final double yearWidth = 70;
    final double seasonWidth = 100;
    final double ageGroupWidth = 100;
    final double actionWidth = 150;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffE6E6E6),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(child: _buildHeader("Team Name", teamNameWidth)),

              Expanded(child: _buildHeader("Year", yearWidth)),
              Expanded(child: _buildHeader("Season", seasonWidth)),
              Expanded(child: _buildHeader("Age Group", ageGroupWidth)),
              SizedBox(width: actionWidth),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...teams.map((team) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                // SizedBox(
                //   width: teamNameWidth,
                //   child: GestureDetector(
                //     onTap: () => Get.to(() => TeamDashboradForOrganization()),
                //     child:
                Expanded(
                  child: Text(
                    team!.name!,
                    style: tableContentHeader.copyWith(
                      fontSize: 16,
                      color: AppColors.descriptiveTextColor,
                    ),
                  ),
                ),

                Expanded(child: Text(team!.year.toString(), style: fieldLabelStyle)),
                Expanded(child: Text(team.season!, style: fieldLabelStyle)),
                Expanded(child: Text(team.ageGroup!, style: fieldLabelStyle)),
                SizedBox(
                  width: actionWidth,
                  child: InkWell(
                    onTap: () {
                      showCustomDialog(
                        context: context,
                        title: 'Delete Team',
                        description:
                            'Are you sure you want to delete this team?',
                        onOk: () => print('Team Deleted'),
                        onCancel: () => print('Cancel Pressed'),
                      );
                    },
                    child: Image.asset(
                      'assets/images/delete_icon.png',
                      height: 36.h,
                      width: 40.w,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: tableLabel.copyWith(color: AppColors.primaryColor, fontSize: 20),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
// import 'package:gaming_web_app/screens/organization_dashboard/delete_team_success_dialog.dart';
// import 'package:gaming_web_app/screens/team_dashboard/team_dashboard_for_organization.dart';
// import 'package:get/get.dart';
// import '../../Base/componant/alertDialog.dart';
// import '../../Base/componant/dropdown.dart';
// import '../../Base/controller/admin/OrgnizationController.dart';
// import '../../Base/controller/globleController.dart';
// import '../../Base/model/teamModel/teamModel.dart';
//
//
//
//
//
// final GlobleController globleController = Get.put(GlobleController());
//
// class OrganizationDashboardScreen extends StatelessWidget {
//   OrganizationDashboardScreen({super.key});
//
//   // final controller = Get.put(OrganizationController());
//   final OrganizationController controller = Get.put(OrganizationController());
//   @override
//   Widget build(BuildContext context) {
//     return DashboardScaffold(
//       userImage: 'assets/images/dummy_image.png',
//       userName: 'Test User',
//       title: 'Game-Ready',
//       subtitle: 'Lineup',
//       actionWidget: Container(
//         height: 54.h,
//         width: 406.w,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor,
//           borderRadius: BorderRadius.circular(80.r),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Organization ID: ',
//               style: tableContentHeader.copyWith(
//                 fontSize: 22.sp,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               '12345abcde',
//               style: tableContentHeader.copyWith(
//                 fontSize: 22.sp,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 102.w),
//         child: Column(
//           children: [
//             SizedBox(height: 50.h),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 // Use column if screen width is less than 600 (mobile/tablet)
//                 bool isMobile = constraints.maxWidth < 600;
//
//                 return isMobile
//                     ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: GetBuilder<OrganizationController>(
//                         builder: (controller) {
//                           if (controller.isLoading) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//
//                           return DynamicDropdownList<Organization?>(
//                             items: controller.organization ?? [],
//                             selectedItem: controller.selectedOrganization,
//                             itemLabelBuilder: (org) => org?.name ?? 'No Name',
//                             onChanged: controller.setSelectedOrganization,
//                             hint: "Select an organization",
//                             dropdownWidth: 300,
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         'Teams Linked to Your Organization'.toUpperCase(),
//                         style: descriptionHeader.copyWith(
//                           fontSize: 18,
//                           color: AppColors.secondaryColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//                     : Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: GetBuilder<OrganizationController>(
//                           builder: (controller) {
//                             if (controller.isLoading) {
//                               return const Center(child: CircularProgressIndicator());
//                             }
//
//                             return DynamicDropdownList<Organization?>(
//                               items: controller.organization ?? [],
//                               selectedItem: controller.selectedOrganization,
//                               itemLabelBuilder: (org) => org?.name ?? 'No Name',
//                               onChanged: controller.setSelectedOrganization,
//                               hint: "Select an organization",
//                               dropdownWidth: 300,
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Text(
//                         'Teams Linked to Your Organization'.toUpperCase(),
//                         style: descriptionHeader.copyWith(
//                           fontSize: 18,
//                           color: AppColors.secondaryColor,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: false,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//
//
//
//             SizedBox(height: 27.h),
//             TeamTable(),
//             SizedBox(height: 27.h),
//
//      ])));
//
//   }
// }
//
// class TeamTable extends StatelessWidget {
//   final List<Map<String, String>> teams = [
//     {"name": "Eagles", "year": "2025", "season": "Summer", "age": "11u"},
//     {"name": "Mustangs", "year": "2025", "season": "Spring", "age": "12u"},
//     {"name": "Kings", "year": "2025", "season": "Fall", "age": "10u"},
//     {"name": "Xtreme", "year": "2025", "season": "Winter", "age": "13u"},
//   ];
//   final controller = Get.put(OrganizationController());
//
//   // final controller = Get.find<OrganizationController>();
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         if (width < 600) {
//           return _MobileLayout(teams: teams); // Batch 2
//         } else if (width >= 600 && width < 1024) {
//           return _TabletLayout(teams: teams); // Batch 3
//         } else {
//           return _WebLayout(teams: teams); // Batch 3
//         }
//       },
//     );
//   }
// }
//
// class _MobileLayout extends StatelessWidget {
//   final List<Map<String, String>> teams;
//
//   const _MobileLayout({required this.teams});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children:
//           teams.map((team) {
//             return Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(color: Colors.white),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInfoRow("Team Name", team['name']!),
//                   _buildInfoRow("Year", team['year']!),
//                   _buildInfoRow("Season", team['season']!),
//                   _buildInfoRow("Age Group", team['age']!),
//                   const SizedBox(height: 10),
//                   InkWell(
//                     onTap: () async {
//
//                       showCustomDialog(
//                         context: context,
//                         title: 'Delete Team',
//                         description: 'Are you sure you want to delete This Team?',
//                         onOk: () {
//                           // globleController.playesDelete(player.id!);
//                         },
//                         onCancel: () {
//                           print("Cancel pressed");
//                         },
//                       );
//
//
//                     }),
//                   //     await showDialog(
//                   //       context: context,
//                   //       barrierDismissible: true,
//                   //       builder: (_) => const DeleteTeamSuccessDialog(),
//                   //     );
//                   //   },
//                   //   child: Image.asset(
//                   //     'assets/images/delete_icon.png',
//                   //     height: 36.h,
//                   //     width: 40.w,
//                   //   ),
//                   // ),
//                   // SizedBox(height: 10.h),
//                   // Padding(
//                   //   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                   //   child: Divider(
//                   //     height: 1,
//                   //     color: Color(0xffEAEAEA),
//                   //     thickness: 1,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             );
//           }).toList(),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           Text(
//             "$label: ",
//             style: tableLabel.copyWith(
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//             ),
//           ),
//           Spacer(),
//           Text(
//             value,
//             style: fieldLabelStyle.copyWith(
//               fontSize: 12,
//               color: AppColors.descriptiveTextColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _TabletLayout extends StatelessWidget {
//   final List<Map<String, String>> teams;
//
//   const _TabletLayout({required this.teams});
//
//   @override
//   Widget build(BuildContext context) {
//     final double teamNameWidth = 160;
//     final double yearWidth = 70;
//     final double seasonWidth = 100;
//     final double ageGroupWidth = 100;
//     final double actionWidth = 150;
//
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Color(0xffE6E6E6),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//           child: Row(
//             children: [
//               _buildHeader("Team Name", teamNameWidth),
//               _buildHeader("Year", yearWidth),
//               _buildHeader("Season", seasonWidth),
//               _buildHeader("Age Group", ageGroupWidth),
//               SizedBox(width: actionWidth),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         ...teams.map(
//           (team) => _buildRow(
//             team,
//             teamNameWidth,
//             yearWidth,
//             seasonWidth,
//             ageGroupWidth,
//             actionWidth,
//             context,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeader(String title, double width) {
//     return SizedBox(
//       width: width,
//       child: Text(
//         title,
//         style: tableLabel.copyWith(color: AppColors.primaryColor, fontSize: 20),
//       ),
//     );
//   }
//
//   Widget _buildRow(
//     Map<String, String> team,
//     double teamNameWidth,
//     double yearWidth,
//     double seasonWidth,
//     double ageGroupWidth,
//     double actionWidth,
//     BuildContext context,
//   ) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//           decoration: BoxDecoration(color: Colors.white),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: teamNameWidth,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TeamDashboradForOrganization(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     team['name']!,
//                     style: tableContentHeader.copyWith(
//                       fontSize: 16,
//                       color: AppColors.descriptiveTextColor,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: yearWidth,
//                 child: Text(
//                   team['year']!,
//                   style: TextStyle(
//                     fontSize: 16,
//                     // fontSize: 19.57.sp,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: seasonWidth,
//                 child: Text(
//                   team['season']!,
//                   style: TextStyle(
//                     fontSize: 16,
//                     // fontSize: 19.57.sp,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: ageGroupWidth,
//                 child: Text(
//                   team['age']!,
//                   style: TextStyle(
//                     fontSize: 16,
//                     // fontSize: 19.57.sp,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: actionWidth,
//                 child: InkWell(
//                   child: Image.asset(
//                     'assets/images/delete_icon.png',
//                     height: 18.h,
//                     width: 20.w,
//                   ),
//                   onTap: () async {
//                     showCustomDialog(
//                       context: context,
//                       title: 'Delete Team',
//                       description: 'Are you sure you want to delete This Team?',
//                       onOk: () {
//                         // globleController.playesDelete(player.id!);
//                       },
//                       onCancel: () {
//                         print("Cancel pressed");
//                       },
//                     );
//
//                     // await showDialog(
//                     //   context: context,
//                     //   barrierDismissible: true,
//                     //   builder: (_) => const DeleteTeamSuccessDialog(),
//                     // );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Divider(height: 1, color: Color(0xffEAEAEA), thickness: 1),
//         ),
//       ],
//     );
//   }
// }
//
// class _WebLayout extends StatelessWidget {
//   final List<Map<String, String>> teams;
//
//   const _WebLayout({required this.teams});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(minWidth: 1024),
//         child: _TabletLayout(
//           teams: teams,
//         ), // Reuse tablet layout for web, just scroll horizontally
//       ),
//     );
//   }
// }
