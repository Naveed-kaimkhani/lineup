import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/controller/org_controller/org_teams_controller.dart';
import 'package:gaming_web_app/Base/controller/teamController/createTeamController.dart';
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/Base/model/teamModel/org_team_model.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/organization_dashboard/org_team_mobile_layout.dart';
import 'package:gaming_web_app/screens/organization_dashboard/show_renewal_dialogue.dart';
import 'package:gaming_web_app/screens/organization_dashboard/team_details_screen.dart';
import 'package:gaming_web_app/service/api/adminApi.dart';
import 'package:get/get.dart';
import '../../Base/componant/alertDialog.dart';

class OrganizationDashboardScreen extends StatelessWidget {
  OrganizationDashboardScreen({super.key});
  final controlle = Get.find<NewTeamController>();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),

            // Align(
            //   alignment: AlignmentDirectional.centerEnd,
            //   child: PrimaryButton(
            //     width: 280.w, // You can adjust this as needed
            //     onTap: () async {
            //       showRenewalPaymentDialog(
            //         context,
            //         PromoCode: () {
            //           // Navigator.pop(context);
            //           controlle.promoCodeDialog(context);
            //           // Handle Promo Code selection
            //           print('Promo Code selected');
            //           // optional: close dialog after selection
            //         },
            //         OnlinePayment: () async {
            //           final response = await AdminApi.getRenewalPaymentLink();
            //         },
            //       );
            //     },
            //     radius: 20.r,
            //     textStyle: descriptiveStyle.copyWith(
            //       color: Colors.white,
            //       fontSize: 18,
            //     ),
            //     title: 'Renew Subscription',
            //     backgroundColor: AppColors.secondaryColor,
            //   ),
            // ),
            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600;

                return Align(
                  alignment:
                      isMobile
                          ? Alignment
                              .center // Center on mobile
                          : AlignmentDirectional.centerEnd, // Right on desktop
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: isMobile ? 0 : 0,
                      bottom: isMobile ? 16 : 0,
                    ),
                    child: PrimaryButton(
                      width: isMobile ? double.infinity : 280.w,
                      onTap: () async {
                        showRenewalPaymentDialog(
                          context,
                          PromoCode: () {
                            controlle.promoCodeRenewalRequest(context);
                          },
                          OnlinePayment: () async {
                            final response =
                                await AdminApi.getRenewalPaymentLink();
                          },
                        );
                      },
                      radius: 20.r,
                      textStyle: descriptiveStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      title: 'Renew Subscription',
                      backgroundColor: AppColors.secondaryColor,
                    ),
                  ),
                );
              },
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600;

                return isMobile
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Teams Linked to Your Organization'.toUpperCase(),
                            style: descriptionHeader.copyWith(
                              fontSize: 26,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'Teams Linked to Your Organization'.toUpperCase(),
                              style: descriptionHeader.copyWith(
                                fontSize: 26,
                                color: AppColors.secondaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ],
                    );
              },
            ),
            SizedBox(height: 27.h),
            TeamTable(), // Mock/static UI only
            SizedBox(height: 27.h),
          ],
        ),
      ),
    );
  }
}

class TeamTable extends StatelessWidget {
  final OrgTeamsController controller = Get.put(OrgTeamsController());

  TeamTable({super.key}) {
    controller.fetchTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.teams.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              if (width < 600) {
                return OrgTeamMobileLayout(teams: controller.teams);
              } else if (width < 1024) {
                return _TabletLayout(teams: controller.teams);
              } else {
                return _WebLayout(teams: controller.teams);
              }
            },
          ),
          if (true)
            TextButton(
              onPressed: controller.loadMore,
              child: const Text("Load More"),
            ),
        ],
      );
    });
  }
}

class _TabletLayout extends _WebLayout {
  _TabletLayout({required super.teams});
}

class _WebLayout extends StatelessWidget {
  final List<OrgTeamModel> teams;
  final OrgTeamsController controller = Get.find<OrgTeamsController>();

  final TeamController teamController = Get.find<TeamController>();
  _WebLayout({required this.teams});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderRow(),
        const SizedBox(height: 8),
        ...teams.map((team) {
          return InkWell(
            onTap: () async {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          TeamDetailsScreen(teamId: team.id), // Example ID
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      team.name,
                      style: fieldLabelStyle.copyWith(
                        color: AppColors.descriptiveTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      team.year,
                      style: fieldLabelStyle.copyWith(
                        color: AppColors.descriptiveTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Expanded(child: Text("team.year", style: fieldLabelStyle)),
                  Expanded(
                    child: Text(
                      team.season,
                      style: fieldLabelStyle.copyWith(
                        color: AppColors.descriptiveTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      team.ageGroup,
                      style: fieldLabelStyle.copyWith(
                        color: AppColors.descriptiveTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: InkWell(
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          title: 'Delete Team',
                          description:
                              'Are you sure you want to delete this team?',
                          onOk: () async {
                            Get.back();
                            await controller.deleteTeam(team.id);
                          },
                          onCancel: () => Get.back(),
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
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _buildHeader("Team Name")),
          Expanded(child: _buildHeader("Year")),
          Expanded(child: _buildHeader("Season")),
          Expanded(child: _buildHeader("Age Group")),
          const SizedBox(width: 80),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: tableLabel.copyWith(color: AppColors.primaryColor, fontSize: 20),
    );
  }
}
