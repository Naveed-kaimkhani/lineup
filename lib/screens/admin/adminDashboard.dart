import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/Base/model/adminModel/paymentTrackingModel.dart';
import 'package:gaming_web_app/Base/model/teamModel/teamModel.dart';
import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/admin/adminController/settings_controller.dart';
import 'package:gaming_web_app/service/api/adminApi.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../Base/componant/alertDialog.dart';
import '../../Base/controller/globleController.dart';
import '../../Base/model/adminModel/promoCodeModel.dart';
import '../../Base/model/getAllUser.dart';
import '../../Base/model/positioned.dart';
import '../../constants/widgets/text_fields/primary_text_field.dart';
import '../../routes/routes_path.dart';
import 'adminController/adminController.dart';
import 'adminController/orginatizationDialog.dart';

final GlobleController globleController = Get.put(GlobleController());

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AdminController adminController = Get.put(AdminController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      adminController.fetchOrganization();

      adminController.fetchAllUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DashboardScaffold(
        onTab: () {
          // Get.toNamed(RoutesPath.mainDashboardScreen);
        },
        userImage: 'assets/images/dummy_image.png',
        userName: 'Test User',
        title: 'Game-Ready',
        subtitle: 'Lineup',
        actionWidget: Column(children: []),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 102.w),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: 50, // Set height based on button size
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        PrimaryButton(
                          // width: 300,
                          onTap: () async {
                            adminController.fetchOrganization();
                            adminController.selectedTab.value = 1;

                            // Get.toNamed(RoutesPath.organizationDashboardScreen);
                          },
                          radius: 20.r,
                          textStyle: descriptiveStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          title: '  Organization  ',
                          backgroundColor:
                              1 == adminController.selectedTab.value
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                        ),
                        SizedBox(width: 16),

                        PrimaryButton(
                          // width: 300,
                          onTap: () async {
                            adminController.fetchAllUser();
                            adminController.selectedTab.value = 2;
                          },
                          radius: 20.r,
                          textStyle: descriptiveStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          title: '  User Management  ',
                          backgroundColor:
                              2 == adminController.selectedTab.value
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                        ),
                        SizedBox(width: 16),
                        PrimaryButton(
                          // width: 300,
                          onTap: () async {
                            adminController.selectedTab.value = 3;
                            adminController.fetchTeamsPositioned();
                          },
                          radius: 20.r,
                          textStyle: descriptiveStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          title: '  Position Management  ',
                          backgroundColor:
                              3 == adminController.selectedTab.value
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                        ),
                        SizedBox(width: 16),
                        PrimaryButton(
                          // width: 300,
                          onTap: () async {
                            adminController.fetchPromoCode();
                            adminController.selectedTab.value = 4;
                          },
                          radius: 20.r,
                          textStyle: descriptiveStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          title: '  Promo Code Management  ',
                          backgroundColor:
                              4 == adminController.selectedTab.value
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                        ),
                        SizedBox(width: 16),
                        PrimaryButton(
                          // width: 300,
                          onTap: () async {
                            adminController.fetchTeamsPayment();
                            adminController.selectedTab.value = 5;
                          },
                          radius: 20.r,
                          textStyle: descriptiveStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          title: '  Payment Tracking  ',
                          backgroundColor:
                              5 == adminController.selectedTab.value
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                        ),

                        SizedBox(width: 16),
                        PrimaryButton(
                          // width: 300,
                          onTap: () async {
                            adminController.selectedTab.value = 6;
                          },
                          radius: 20.r,
                          textStyle: descriptiveStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          title: '       Pricing        ',
                          backgroundColor:
                              6 == adminController.selectedTab.value
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 27.h),
              if (adminController.selectedTab.value == 1) TeamTable(),
              if (adminController.selectedTab.value == 2) UserManagement(),
              if (adminController.selectedTab.value == 3)
                PositionedManagemant(),
              if (adminController.selectedTab.value == 4) PromoCodeManagemant(),
              if (adminController.selectedTab.value == 5)
                PaymentTrackingManagemant(),
              if (adminController.selectedTab.value == 6) Settings(),
              SizedBox(height: 27.h),
            ],
          ),
        ),
      ),
    );
  }
}

class PromoCodeManagemant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _MobileLayout(); // Mobile view
        } else {
          return PromoCodeManageOrWebLayout(); // Tablet and web view
        }
      },
    );
  }
}

class PositionedManagemant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _MobileLayout(); // Mobile view
        } else {
          return PositionedManageOrWebLayout(); // Tablet and web view
        }
      },
    );
  }
}

class PaymentTrackingManagemant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _MobileLayout(); // Mobile view
        } else {
          return PaymentManageOrWebLayout(); // Tablet and web view
        }
      },
    );
  }
}

class UserManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _MobileLayout(); // Mobile view
        } else {
          return userManageOrWebLayout(); // Tablet and web view
        }
      },
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

class _MobileLayout extends StatefulWidget {
  const _MobileLayout({super.key});

  @override
  State<_MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<_MobileLayout> {
  final TeamController controller = Get.find<TeamController>();
  void showNameEmailDialog() {
    // final nameController = TextEditingController();
    // final emailController = TextEditingController();
    final AdminController adminController = Get.find<AdminController>();
    Get.dialog(
      NameEmailDialog(
        nameController: adminController.orginizationNameController,
        orgCodeController: adminController.orginizationNameController,
        emailController: adminController.orginizationEmail,
        onSubmit: () {
          final name = adminController.orginizationNameController.text.trim();
          final email = adminController.orginizationEmail.text.trim();
          final org = adminController.organization_code.text.trim();

          // Perform your validation or logic here
          if (name.isEmpty || email.isEmpty || org.isEmpty) {
            Get.snackbar("Error", "Please enter both name and email");
          } else {
            adminCreateOrganization(
              name: name,
              email: email,
              annualTeamAllocation: int.parse(org),
            );
            Navigator.pop(context);
            // You can call your controller method here
          }
        },
      ),
    );
  }

  Future<void> adminCreateOrganization({
    required String name,
    required String email,
    required int annualTeamAllocation,
  }) async {
    log("in methodd");
    final url = Uri.parse('http://18.189.193.38/api/v1/admin/organizations');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferencesKeysConstants.bearerToken);

      final body = {
        "name": name,
        "email": email,
        "annual_team_allocation": annualTeamAllocation,
      };
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          Get.snackbar("Success", data['message'] ?? "Organization created");
          // Optional: do something with data['data']
        } else {
          Get.snackbar("Error", data['message'] ?? "Creation failed");
        }
      } else {
        Get.snackbar("Error", "Server returned ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children:
            controller.teams.value.map((team) {
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
                    Get.toNamed(RoutesPath.teamDashboardScreen);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      PrimaryButton(
                        // width: 300,
                        onTap: () async {
                          showNameEmailDialog();
                        },
                        radius: 20.r,
                        textStyle: descriptiveStyle.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        title: '  Create Organization  ',
                        backgroundColor: AppColors.secondaryColor,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow("Team Name", team!.name),
                          _buildInfoRow("Year", team.year.toString()),
                          _buildInfoRow("Season", team.season ?? "-"),
                          _buildInfoRow("Age Group", team.ageGroup),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              showCustomDialog(
                                context: context,
                                title: 'Delete Team',
                                description:
                                    'Are you sure you want to delete this team?',
                                onOk: () {
                                  globleController.teamDelete(team.id);
                                },
                                onCancel: () {},
                              );
                            },
                            child: Image.asset(
                              'assets/images/delete_icon.png',
                              height: 36.h,
                              width: 40.w,
                            ),
                          ),
                        ],
                      ),
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

class PromoCodeManageOrWebLayout extends StatelessWidget {
  final AdminController adminController = Get.find<AdminController>();

  final double teamNameWidth = 160;
  final double yearWidth = 90;
  final double seasonWidth = 100;
  final double ageGroupWidth = 100;
  final double actionWidth = 190;
  PromoCodeResponse promoCode = PromoCodeResponse();
  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    // controller.getData();
    return Center(
      child: SizedBox(
        width: maxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      PrimaryButton(
                        // width: 300,
                        onTap: () async {
                          try {
                            final response = await AdminApi.createPromotoCode(
                              isBody: false,
                            );

                            if (response.success!) {
                              adminController.fetchPromoCode(); // reload data
                              Get.snackbar(
                                "Success",
                                response.message ?? "Promo code updated",
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                response.message ?? "Update failed",
                              );
                            }
                          } catch (e) {}
                        },
                        radius: 20.r,
                        textStyle: descriptiveStyle.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        title: '  Auto Generated  ',
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      SizedBox(width: 30),
                      PrimaryButton(
                        // width: 300,
                        onTap: () async {
                          adminController.showCreatePromoCodeDialog(
                            context,
                            promoCode,
                          );
                          // adminController.showUpdatePromoCodeDialog(context);
                        },
                        radius: 20.r,
                        textStyle: descriptiveStyle.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        title: '  Create Promo Code  ',
                        backgroundColor: AppColors.secondaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Container(
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
                          flex: 1,
                          child: _buildHeader("Promo Code", teamNameWidth),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildHeader("Description", yearWidth),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildHeader("Expires At", seasonWidth),
                        ),

                        Expanded(
                          flex: 1,
                          child: _buildHeader("Max Uses", seasonWidth),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildHeader("Uses Count", seasonWidth),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildHeader("Max Uses Per User", seasonWidth),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: _buildHeader("Age Group", ageGroupWidth),
                        // ),
                        // _buildHeader("created At", ageGroupWidth),

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
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Data Rows
            Obx(() {
              final paginatedUserResponse =
                  adminController.promoCodeResponse ?? [];

              return SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Column(
                  children:
                      paginatedUserResponse!.map((user) {
                        return _buildRowPRomoCode(context, user);
                      }).toList(),
                  // ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRowPRomoCode(BuildContext context, PromoCodeResponse team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {},
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildCell(team.code.toString(), teamNameWidth),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(team.description.toString(), yearWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(
                formatExpiresAt(team.expiresAt ?? ""),
                seasonWidth,
              ),
            ),

            Expanded(
              flex: 1,
              child: _buildCell(team.maxUses.toString(), seasonWidth),
            ),

            Expanded(
              flex: 1,
              child: _buildCell(team.useCount.toString(), seasonWidth),
            ),

            Expanded(
              flex: 1,
              child: _buildCell(team.maxUsesPerUser.toString(), seasonWidth),
            ),

            InkWell(
              onTap: () async {
                adminController.showUpdatePromoCodeDialog(context, team);
              },
              child: Image.asset(
                'assets/images/edit_icon.png', // Pencil icon image
                height: 36.h,
                width: 40.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowPositioned(BuildContext context, Position team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {},
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.display_name.toString(), teamNameWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.name.toString(), yearWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.category.toString(), seasonWidth),
            ),
          ],
        ),
      ),
    );
  }

  String formatExpiresAt(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(dateTime); // no time part
    } catch (e) {
      return dateStr; // fallback
    }
  }

  Widget _buildHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: tableLabel.copyWith(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Organizations team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {},
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.name.toString(), teamNameWidth),
            ),
            Expanded(flex: 1, child: _buildCell(team.id.toString(), yearWidth)),
            Expanded(
              flex: 1,
              child: _buildCell(team.email.toString(), seasonWidth),
            ),
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
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class TabletOrWebLayout extends StatefulWidget {
  const TabletOrWebLayout({super.key});

  @override
  State<TabletOrWebLayout> createState() => _TabletOrWebLayoutState();
}

class _TabletOrWebLayoutState extends State<TabletOrWebLayout> {
  final AdminController adminController = Get.find<AdminController>();

  final double teamNameWidth = 160;
  final double yearWidth = 90;
  final double seasonWidth = 100;
  final double ageGroupWidth = 100;
  final double actionWidth = 190;

  Future<void> adminCreateOrganization({
    required String name,
    required String email,
    required int annualTeamAllocation,
  }) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        annualTeamAllocation == 0) {
      SnackbarUtils.showErrorr("Please fill in all fields.");
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      SnackbarUtils.showErrorr("Invalid email format.");
      return;
    }

    final url = Uri.parse('http://18.189.193.38/api/v1/admin/organizations');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferencesKeysConstants.bearerToken);

      final body = {
        "name": name,
        "email": email,
        "annual_team_allocation": annualTeamAllocation,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseBody['success'] == true) {
          SnackbarUtils.showSuccess(
            responseBody['message'] ?? "Organization created",
          );
        } else {
          SnackbarUtils.showErrorr(
            responseBody['message'] ?? "Organization creation failed",
          );
        }
      } else {
        SnackbarUtils.showErrorr(
          responseBody['message'] ?? "Organization created",
        );
        // SnackbarUtils.showErrorr("Server error: ${response.statusCode}");
      }
    } catch (e) {
      //  SnackbarUtils.showErrorr(
      //       responseBody['message'] ?? "Organization created",
      //     );
      SnackbarUtils.showErrorr("Exception: ${e.toString()}");
    }
  }

  Future<void> adminEditOrganization({
    required String name,
    required String email,
    required int annualTeamAllocation,
    required int id,
  }) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        annualTeamAllocation == 0) {
      SnackbarUtils.showErrorr("Please fill in all fields.");
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      SnackbarUtils.showErrorr("Invalid email format.");
      return;
    }

    final url = Uri.parse(
      'http://18.189.193.38/api/v1/admin/organizations/$id',
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferencesKeysConstants.bearerToken);

      final body = {
        // "id": id,
        "name": name,
        "email": email,
        "annual_team_allocation": annualTeamAllocation,
      };

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      // log(response.body);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // adminController.selectedTab.value = 1;
        // await adminController.fetchOrganization();

        if (responseBody['success'] == true) {
          SnackbarUtils.showSuccess(
            responseBody['message'] ?? "Organization created",
          );
        } else {
          SnackbarUtils.showErrorr(
            responseBody['message'] ?? "Organization creation failed",
          );
        }
      } else {
        SnackbarUtils.showErrorr(
          responseBody['message'] ?? "Organization created",
        );
        // SnackbarUtils.showErrorr("Server error: ${response.statusCode}");
      }
    } catch (e) {
      //  SnackbarUtils.showErrorr(
      //       responseBody['message'] ?? "Organization created",
      //     );
      SnackbarUtils.showErrorr("Exception: ${e.toString()}");
    }
  }

  void showNameEmailDialog() {
    // final nameController = TextEditingController();
    // final emailController = TextEditingController();
    final AdminController adminController = Get.find<AdminController>();
    Get.dialog(
      NameEmailDialog(
        nameController: adminController.orginizationNameController,
        emailController: adminController.orginizationEmail,
        orgCodeController: adminController.organization_code,
        onSubmit: () {
          final name = adminController.orginizationNameController.text.trim();
          final email = adminController.orginizationEmail.text.trim();
          final org = adminController.organization_code.text.trim();

          // Perform your validation or logic here
          if (name.isEmpty || email.isEmpty || org.isEmpty) {
            Get.snackbar("Error", "Please enter both name and email");
          } else {
            // adminController.adminCreateOrganization();
            // ss
            // adminCreateOrganization()
            final int? annualTeamAllocation = int.tryParse(org);

            if (annualTeamAllocation == null) {
              SnackbarUtils.showErrorr(
                "Annual team allocation must be a valid number.",
              );
              return;
            }

            adminCreateOrganization(
              name: name,
              email: email,
              annualTeamAllocation: int.parse(org),
            );
            Navigator.pop(context);
            // You can call your controller method here
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    // controller.getData();
    return Center(
      child: SizedBox(
        width: maxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PrimaryButton(
                    // width: 300,
                    onTap: () async {
                      showNameEmailDialog();
                    },
                    radius: 20.r,
                    textStyle: descriptiveStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    title: '  Create Organization  ',
                    backgroundColor: AppColors.secondaryColor,
                  ),
                  const SizedBox(height: 8),
                  Container(
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
                        Expanded(flex: 2, child: _buildHeader("Org Name", 80)),

                        Expanded(flex: 2, child: _buildHeader("Email", 80)),
                        Expanded(flex: 2, child: _buildHeader("Org Code", 80)),
                        Expanded(
                          flex: 2,
                          child: _buildHeader("Teams Created", 80),
                        ),
                        Expanded(
                          flex: 2,
                          child: _buildHeader("Annual Teams", 80),
                        ),

                        // Expanded(flex: 1, child: _buildHeader("Org ID", 80)),
                        _buildHeader("Action", 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // // Data Rows
            ...adminController.organization
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
    );
  }

  Widget _buildHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: tableLabel.copyWith(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Organizations team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return Container(
      width: maxWidth,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildCell(team.name.toString(), teamNameWidth),
          ),
          Expanded(
            flex: 2,
            child: _buildCell(team.email.toString(), teamNameWidth),
          ),
          Expanded(
            flex: 2,
            child: _buildCell(team.orgCode.toString(), teamNameWidth),
          ),

          Expanded(
            flex: 2,
            child: _buildCell(
              team.teams_created_this_period.toString(),
              seasonWidth,
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildCell(
              team.annual_team_allocation.toString(),
              seasonWidth,
            ),
          ),
          // Expanded(flex: 1, child: _buildCell(team.id.toString(), yearWidth)),
          // _buildEditButton(context,),
          InkWell(
            onTap: () async {
              orginizationUpateDialog(team);
            },
            child: Image.asset(
              'assets/images/edit_icon.png', // Pencil icon image
              height: 36.h,
              width: 40.w,
            ),
          ),
        ],
      ),
    );
  }

  void orginizationUpateDialog(Organizations team) {
    // final nameController = TextEditingController();
    // final emailController = TextEditingController();
    final AdminController adminController = Get.find<AdminController>();
    adminController!.orginizationNameController = TextEditingController(
      text: team.name,
    );
    adminController!.orginizationEmail = TextEditingController(
      text: team.email,
    );
    Get.dialog(
      NameEmailDialog(
        nameController: adminController.orginizationNameController,
        emailController: adminController.orginizationEmail,
        orgCodeController: adminController.organization_code,
        onSubmit: () {
          final name = adminController.orginizationNameController.text.trim();
          final email = adminController.orginizationEmail.text.trim();
          final org = adminController.organization_code.text.trim();

          // Perform your validation or logic here
          if (name.isEmpty || email.isEmpty || org.isEmpty) {
            Get.snackbar("Error", "Please enter both name and email");
          } else {
            // adminController.adminCreateOrganization();
            // fdfdf
            adminEditOrganization(
              name: name,
              email: email,
              id: team.id!,
              annualTeamAllocation: int.parse(org),
            );
            Navigator.pop(context);
            // You can call your controller method here
          }
        },
      ),
    );
  }

  // Widget _buildEditButton(BuildContext context,) {
  //   return InkWell(
  //     onTap: () async {
  //       // Show dialog to edit player details
  //       await showDialog(
  //         context: context,
  //         barrierDismissible: true, builder: (BuildContext context) { return  SizedBox(); },
  //         // builder: (_) => EditPlayerDialog(players: players,),
  //       );
  //     },
  //     child:  Image.asset(
  //       'assets/images/edit_icon.png', // Pencil icon image
  //       height: 36.h,
  //       width: 40.w,
  //     ),
  //
  //
  //   );
  // }
  Widget _buildCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: fieldLabelStyle.copyWith(
          color: AppColors.descriptiveTextColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class PaymentManageOrWebLayout extends StatelessWidget {
  final AdminController adminController = Get.find<AdminController>();

  final double teamNameWidth = 160;
  final double yearWidth = 90;
  final double seasonWidth = 100;
  final double ageGroupWidth = 100;
  final double actionWidth = 190;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    // controller.getData();
    return Center(
      child: SizedBox(
        width: maxWidth,
        child: Column(
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
                      flex: 1,
                      child: _buildHeader("User Name", teamNameWidth),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildHeader("Team Name", teamNameWidth),
                    ),
                    Expanded(flex: 1, child: _buildHeader("amount", yearWidth)),

                    Expanded(
                      flex: 1,
                      child: _buildHeader("currency", seasonWidth),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: _buildHeader("Age Group", ageGroupWidth),
                    // ),
                    _buildHeader("status", ageGroupWidth),

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
            Obx(() {
              final paginatedUserResponse = adminController.paymentModel ?? [];

              return SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Column(
                  children:
                      paginatedUserResponse!.map((user) {
                        return _buildRowPayment(context, user);
                      }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRowPayment(BuildContext context, PaymentModel team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildCell(
                team.user!.firstName.toString().toString(),
                teamNameWidth,
              ),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(
                team.team!.name.toString().toString(),
                teamNameWidth,
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.amount.toString(), yearWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.currency.toString(), seasonWidth),
            ),

            Expanded(
              flex: 1,
              child: _buildCell(team.status.toString(), seasonWidth),
            ),

            // Expanded(
            //   flex: 1,
            //   child: _buildCell(team..toString(), seasonWidth),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowPositioned(BuildContext context, Position team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.display_name.toString(), teamNameWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.name.toString(), yearWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.category.toString(), seasonWidth),
            ),

            // Expanded(
            //   flex: 1,
            //   child: _buildCell(team..toString(), seasonWidth),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowUser(BuildContext context, UserListResponse team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.firstName.toString(), teamNameWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.email.toString(), yearWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.phone.toString(), seasonWidth),
            ),

            Expanded(
              flex: 1,
              child: _buildCell(team.createdAt.toString(), seasonWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: tableLabel.copyWith(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Organizations team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.name.toString(), teamNameWidth),
            ),
            Expanded(flex: 1, child: _buildCell(team.id.toString(), yearWidth)),
            Expanded(
              flex: 1,
              child: _buildCell(team.email.toString(), seasonWidth),
            ),
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
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class PositionedManageOrWebLayout extends StatefulWidget {
  const PositionedManageOrWebLayout({super.key});

  @override
  State<PositionedManageOrWebLayout> createState() =>
      _PositionedManageOrWebLayoutState();
}

class _PositionedManageOrWebLayoutState
    extends State<PositionedManageOrWebLayout> {
  final AdminController adminController = Get.find<AdminController>();

  final double teamNameWidth = 160;
  final double yearWidth = 90;
  final double seasonWidth = 100;
  final double ageGroupWidth = 100;
  final double actionWidth = 190;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    // controller.getData();
    return Center(
      child: SizedBox(
        width: maxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PrimaryButton(
                    // width: 300,
                    onTap: () async {
                      adminController.createPositionedDialog(context);
                    },
                    radius: 20.r,
                    textStyle: descriptiveStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    title: '  Create Position  ',
                    backgroundColor: AppColors.secondaryColor,
                  ),
                  const SizedBox(height: 8),
                  Container(
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
                          child: _buildHeader("Name", teamNameWidth),
                        ),
                        Expanded(
                          flex: 2,
                          child: _buildHeader("Label", yearWidth),
                        ),
                        Expanded(
                          flex: 2,
                          child: _buildHeader("category", seasonWidth),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: _buildHeader("Age Group", ageGroupWidth),
                        // ),
                        // _buildHeader("created At", ageGroupWidth),

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
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Data Rows
            Obx(() {
              final paginatedUserResponse =
                  adminController.teamPositioned.value ?? [];

              return SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Column(
                  children:
                      paginatedUserResponse!.map((user) {
                        return _buildRowPositioned(context, user);
                      }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRowPositioned(BuildContext context, Position team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.display_name.toString(), teamNameWidth),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(team.name.toString(), yearWidth),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(team.category.toString(), seasonWidth),
            ),

            team.isEditable == 1
                ? InkWell(
                  onTap: () {
                    team.isEditable == 1
                        ? adminController.UpdatePositionedDialog(context, team)
                        : "";
                  },
                  child: Image.asset(
                    'assets/images/edit_icon.png',
                    height: 36.h,
                    width: 40.w,
                  ),
                )
                : SizedBox(),
            // Expanded(
            //   flex: 1,
            //   child: _buildCell(team..toString(), seasonWidth),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowUser(BuildContext context, UserListResponse team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.firstName.toString(), teamNameWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.email.toString(), yearWidth),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(team.phone.toString(), seasonWidth),
            ),

            Expanded(
              flex: 1,
              child: _buildCell(team.createdAt.toString(), seasonWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: tableLabel.copyWith(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Organizations team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.name.toString(), teamNameWidth),
            ),
            Expanded(flex: 1, child: _buildCell(team.id.toString(), yearWidth)),
            Expanded(
              flex: 1,
              child: _buildCell(team.email.toString(), seasonWidth),
            ),
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
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class userManageOrWebLayout extends StatelessWidget {
  final AdminController adminController = Get.find<AdminController>();

  final double teamNameWidth = 160;
  final double yearWidth = 90;
  final double seasonWidth = 100;
  final double ageGroupWidth = 100;
  final double actionWidth = 190;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    // controller.getData();
    return Center(
      child: SizedBox(
        width: maxWidth,
        child: Column(
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
                      child: _buildHeader("Name", teamNameWidth),
                    ),
                    Expanded(flex: 2, child: _buildHeader("Email", yearWidth)),
                    Expanded(
                      flex: 2,
                      child: _buildHeader("Phone", seasonWidth),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: _buildHeader("Age Group", ageGroupWidth),
                    // ),
                    _buildHeader("created_at", ageGroupWidth),

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
            Obx(() {
              final paginatedUserResponse =
                  adminController.paginatedUserResponse.value ?? [];

              return SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Column(
                  children:
                      paginatedUserResponse!.map((user) {
                        return _buildRowUser(context, user);
                      }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRowUser(BuildContext context, UserListResponse team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.firstName.toString(), teamNameWidth),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(team.email.toString(), yearWidth),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(team.phone.toString(), seasonWidth),
            ),

            Expanded(
              flex: 1,
              child: _buildCell(team.createdAt.toString(), seasonWidth),
            ),
          ],
        ),
      ),
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

  Widget _buildRow(BuildContext context, Organizations team) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: () async {
        // showNameEmailDialog();
        // controller.teamDataIndex.value = team.id!;
        // controller.teamDataIndex.value = team.id!;
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('teamInfoId', team.id!);
        // controller.fetchGetTeamData();
        // await Future.delayed(const Duration(seconds: 1));
        // Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildCell(team.name.toString(), teamNameWidth),
            ),
            Expanded(flex: 1, child: _buildCell(team.id.toString(), yearWidth)),
            Expanded(
              flex: 1,
              child: _buildCell(team.email.toString(), seasonWidth),
            ),
            // Expanded(flex: 1, child: _buildCell(team.ageGroup, ageGroupWidth)),
            // InkWell(
            //   onTap: () {
            //     // Delete logic
            //     showCustomDialog(
            //       context: context,
            //       title: 'Delete Team',
            //       description: 'Are you sure you want to delete This Team?',
            //       onOk: () {
            //         globleController.teamDelete(team.id!);
            //       },
            //       onCancel: () {
            //         print("Cancel pressed");
            //       },
            //     );
            //   },
            //   child: Image.asset(
            //     'assets/images/delete_icon.png',
            //     height: 36.h,
            //     width: 40.w,
            //   ),
            // ),
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
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  Settings({super.key}) {
    // controller.fetchSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text("Unlock Price", style: fieldLabelStyle),
        PrimaryTextField(
          controller: controller.unlockPriceController,
          label: 'Unlock Price',
        ),

        // SizedBox(height: 4),
        // // Text("Access Duration (Days)", style: fieldLabelStyle),
        // PrimaryTextField(
        //   controller: controller.accessDurationController,
        //   label: 'Duration (days)',
        // ),
        SizedBox(height: 10),
        // Text("Notify Admin on Payment", style: fieldLabelStyle),
        Obx(
          () => SizedBox(
            width: 500, // Set your desired width

            child: DropdownButtonFormField<bool>(
              value: controller.notifyAdmin.value,
              decoration: InputDecoration(
                labelText: "Notify Admin on Payment",
                labelStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFF2B4582),
                    width: 1.5,
                  ),
                ),
              ),
              dropdownColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
              items: const [
                DropdownMenuItem(value: true, child: Text("True")),
                DropdownMenuItem(value: false, child: Text("False")),
              ],
              onChanged: (value) => controller.notifyAdmin.value = value!,
            ),
          ),
        ),

        SizedBox(height: 10),
        // Text("Admin Email (optional)", style: fieldLabelStyle),
        PrimaryTextField(
          controller: controller.adminEmailController,
          label: 'Admin Email',
        ),

        SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: controller.saveSettings,
        //   child: const Text("Save Settings"),
        // ),
        PrimaryButton(
          onTap: controller.saveSettings,
          title: "  Save Settings ",
        ),
      ],
    );
  }
}
