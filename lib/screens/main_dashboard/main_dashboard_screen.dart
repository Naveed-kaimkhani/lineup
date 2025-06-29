import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/Base/model/teamModel/teamModel.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/main_dashboard/create_a_new_team_dialog.dart';
import 'package:gaming_web_app/screens/main_dashboard/slectorgPay.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Base/componant/alertDialog.dart';
import '../../Base/controller/globleController.dart';
// import '../../routes/routes_path.dart';
import '../../routes/routes_path.dart';
import '../../utils/SharedPreferencesUtil.dart';
// import '../../routes/routes_path.dart';
final GlobleController globleController = Get.put(GlobleController());
class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  final TeamController controller = Get.find<TeamController>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTeams();
    });
  }
  // final TeamController controller = Get.put(TeamController());

  @override
  Widget build(BuildContext context) {
    // controller.fetchGetPlayer( 9);
    return DashboardScaffold(
      // onTab: (){
      //   Get.toNamed(RoutesPath.mainDashboardScreen);
      // },
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      title: 'Game-Ready',
      subtitle: 'Lineup',
      actionWidget: Column(
        children: [
          // PrimaryButton(
          //   width: 208.w,
          //   onTap: () {},
          //   radius: 80.r,
          //   textStyle: descriptiveStyle.copyWith(
          //     color: Colors.white,
          //     fontSize: 22.sp,
          //   ),
          //   title: 'Basic Plan',
          //   backgroundColor: const Color(0xff8B3A3A),
          // ),
          // SizedBox(height: 17.h),
          // CustomTextButton(
          //   title: 'Upgrade Your Plan',
          //   onTap: () {},
          //   fontFamily: 'Poppins',
          //   fontSize: 14.sp,
          //   textColor: Colors.white,
          //   hasUnderline: true,
          // ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 102.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                final isDesktop = constraints.maxWidth > 1024;
                double width = constraints.maxWidth;
                if (width < 600) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Your Team',
                        style: descriptionHeader.copyWith(
                          fontSize: isMobile ?16 : 16,
                          color: AppColors.secondaryColor,
                        ),
                      ),


                      // PrimaryButton(
                      //   width: double.infinity,
                      //   onTap: () async {
                      //
                      //     await SharedPreferencesUtil.saveCurrentRoute(RoutesPath.mainDashboardScreen);
                      //
                      //
                      //     Get.toNamed(RoutesPath.organizationDashboardScreen);
                      //
                      //   },
                      //   radius: 20.r,
                      //   textStyle: descriptiveStyle.copyWith(
                      //     color: Colors.white,
                      //     fontSize: isMobile ? 18 : 30,
                      //   ),
                      //   title: 'Organization',
                      //   backgroundColor: AppColors.secondaryColor,
                      // ),
                      SizedBox(height: 12.h),
                      PrimaryButton(
                        width: double.infinity,
                        onTap: () async {
                          await showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) =>  CreateTeamDialog(),
                          );
                        },
                        radius: 20.r,
                        textStyle: descriptiveStyle.copyWith(
                          color: Colors.white,
                          fontSize: isMobile ? 18 :18,
                        ),
                        title: 'Create New Team',
                        backgroundColor: AppColors.secondaryColor,
                      ),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Your Team',
                      style: descriptionHeader.copyWith(
                        fontSize: isMobile ? 20 : 30,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    PrimaryButton(
                      width: 300,
                      onTap: () async {
                        showFullWidthDialogPay(context);
                        // await showDialog(
                        //   context: context,
                        //   barrierDismissible: true,
                        //   builder: (_) =>  CreateTeamDialog(),
                        // );
                      },
                      radius: 20.r,
                      textStyle: descriptiveStyle.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 18,
                      ),
                      title: 'Create New Team',
                      backgroundColor: AppColors.secondaryColor,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 27.h),
            TeamTable(),
            SizedBox(height: 27.h),
          ],
        ),
      ),
    );
  }
}

class TeamTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _MobileLayout(); // Mobile view
        } else {
          return TabletOrWebLayout(); // Tablet and web view
        }
      },
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final TeamController controller = Get.find<TeamController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children:
            controller.teams.map((team) {
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () async {
                    controller.teamDataIndex.value = team.id!;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('teamInfoId', team.id!);
                    controller.fetchGetTeamData();
                    await Future.delayed(const Duration(seconds: 1));
                    // await SharedPreferencesUtil.saveCurrentRoute(RoutesPath.teamDashboardScreen);
                    Get.toNamed(RoutesPath.teamDashboardScreen);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("Team Name", team!.name),
                      _buildInfoRow("Year", team.year.toString()),
                      _buildInfoRow("Season", team.season),
                      _buildInfoRow("Age Group", team.ageGroup),
                      const SizedBox(height: 10),
                  InkWell(
                          onTap: () {

                            showCustomDialog(
                              context: context,
                              title: 'Delete Team',
                              description: 'Are you sure you want to delete This Team?',
                              onOk: () async {
                           await  globleController.teamDelete(team.id!);

                              },
                              onCancel: () {
                                print("Cancel pressed");
                              },
                            );


                          },
                          child: Image.asset(
                            'assets/images/delete_icon.png',
                            height: 36.h,
                            width: 40.w,
                          ),
                        ),

                      // Row(
                      //   children: [
                      //     ElevatedButton(
                      //       onPressed: () {},
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: AppColors.activeGreenColor,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //       ),
                      //       child: Text(
                      //         'Edit Team',
                      //         style: fieldLabelStyle.copyWith(color: Colors.white),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     InkWell(
                      //       onTap: () {},
                      //       child: Image.asset(
                      //         'assets/images/delete_icon.png',
                      //         height: 36.h,
                      //         width: 40.w,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label: ",
            style: tableLabel.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: tableLabel.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            // fieldLabelStyle.copyWith(
            //   color: AppColors.descriptiveTextColor,
          ),
        ],
      ),
    );
  }
}

// The main layout widget
class TabletOrWebLayout extends StatelessWidget {
  // final TeamController controller = Get.put(TeamController());
  final TeamController controller = Get.find<TeamController>();
  final double teamNameWidth = 160;
  final double yearWidth = 90;
  final double seasonWidth = 100;
  final double ageGroupWidth = 100;
  final double actionWidth = 190;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    controller.getData();
    return Center(
      child: SizedBox(
        width: maxWidth,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: maxWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween, // Distributes space between the children
                    children: [
                      // Wrapping each header in an Expanded widget to stretch them equally
                      Expanded(
                        flex: 2,
                        child: _buildHeader("Team Name", teamNameWidth),
                      ),
                      Expanded(flex: 1, child: _buildHeader("Year", yearWidth)),
                      Expanded(
                        flex: 1,
                        child: _buildHeader("Season", seasonWidth),
                      ),
                      Expanded(
                        flex: 1,
                        child: _buildHeader("Age Group", ageGroupWidth),
                      ),
                      _buildHeader("Action", ageGroupWidth),

                      // SizedBox(width: actionWidth),
                      // Expanded(
                      //     flex: 3,
                      //     child: SizedBox())
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     _buildHeader("Team Name", teamNameWidth),
                  //     _buildHeader("Year", yearWidth),
                  //     _buildHeader("Season", seasonWidth),
                  //     _buildHeader("Age Group", ageGroupWidth),
                  //     SizedBox(width: actionWidth),
                  //   ],
                  // ),
                ),
              ),
              const SizedBox(height: 8),

              // Data Rows
              ...controller.teams
                  .map(
                    (team) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _buildRow(context, team!),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: tableLabel.copyWith(color: AppColors.primaryColor, fontSize: 14),
      ),
    );
  }


  Widget _buildRow(BuildContext context, Team team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        controller.teamDataIndex.value = team.id!;
        controller.teamDataIndex.value = team.id!;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('teamInfoId', team.id!);
        controller.fetchGetTeamData();
        await Future.delayed(const Duration(seconds: 1));
        await SharedPreferencesUtil.saveCurrentRoute(RoutesPath.teamDashboardScreen);
        Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(flex: 2, child: _buildCell(team.name, teamNameWidth)),
            Expanded(
              flex: 1,
              child: _buildCell(team.year.toString(), yearWidth),
            ),
            Expanded(flex: 1, child: _buildCell(team.season, seasonWidth)),
            Expanded(flex: 1, child: _buildCell(team.ageGroup, ageGroupWidth)),
            InkWell(
              onTap: () {
                // Delete logic
                showCustomDialog(
                  context: context,
                  title: 'Delete Team',
                  description: 'Are you sure you want to delete This Team?',
                  onOk: () {
                    globleController.teamDelete(team.id!);
                  },
                  onCancel: () {
                    print("Cancel pressed");
                  },
                );
              },
              child: Image.asset(
                'assets/images/delete_icon.png',
                height: 36.h,
                width: 40.w,
              ),
            ),
            // Expanded(
            //     flex: 2,
            //     child: SizedBox()),
            // Expanded(
            //   flex: 2,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container()
            //
            //         // ElevatedButton(
            //         //   onPressed: () {},
            //         //   style: ElevatedButton.styleFrom(
            //         //     backgroundColor: AppColors.activeGreenColor,
            //         //     shape: RoundedRectangleBorder(
            //         //       borderRadius: BorderRadius.circular(5),
            //         //     ),
            //         //   ),
            //         //   child:FittedBox(
            //         //     fit: BoxFit.scaleDown,
            //         //     child: Center(
            //         //       child: Text(
            //         //         'Edit Team',
            //         //         style: fieldLabelStyle.copyWith(color: Colors.white),
            //         //         textAlign: TextAlign.center,
            //         //       ),
            //         //     ),
            //         //   )
            //         // ),
            //       ),
            //       const SizedBox(width: 10),
            //       // InkWell(
            //       //   onTap: () {
            //       //     // Delete logic
            //       //   },
            //       //   child: Image.asset(
            //       //     'assets/images/delete_icon.png',
            //       //     height: 36.h,
            //       //     width: 40.w,
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: fieldLabelStyle.copyWith(
          color: AppColors.descriptiveTextColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


