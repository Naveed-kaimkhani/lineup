import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/team_dashboard/edit_player_dialog.dart';
import 'package:gaming_web_app/screens/team_dashboard/previous_game_dialog.dart';

class TeamDashboradForOrganization extends StatelessWidget {
  const TeamDashboradForOrganization({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      title: 'Game-Ready',
      subtitle: 'Lineup',

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 102.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                // Small screen (mobile)
                if (width < 600) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Summary Statistics'.toUpperCase(),
                        style: descriptionHeader.copyWith(
                          fontSize: 30.sp,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // PrimaryButton(
                      //   width: double.infinity,
                      //   onTap: () {
                      //     Navigator.pushNamed(
                      //       context,
                      //       RoutesPath.addNewPlayerScreen,
                      //     );
                      //   },
                      //   radius: 20.r,
                      //   textStyle: descriptiveStyle.copyWith(
                      //     color: Colors.white,
                      //     fontSize: 30.sp,
                      //   ),
                      //   title: 'Add New Player',
                      //   backgroundColor: AppColors.descriptiveTextColor,
                      // ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        width: double.infinity,
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder:
                                (context) => PreviousGameDialog(
                                  items: [
                                    {
                                      'name': 'At Tigers',
                                      'date': 'April 03, 2025',
                                    },
                                    {
                                      'name': 'Vs Commanders',
                                      'date': 'April 06, 2025',
                                    },
                                    {
                                      'name': 'At Wildcats',
                                      'date': 'April 10, 2025',
                                    },
                                  ],
                                ),
                          );
                        },
                        radius: 20.r,
                        textStyle: descriptiveStyle.copyWith(
                          color: Colors.white,
                          fontSize: 30.sp,
                        ),
                        title: 'Game',
                        backgroundColor: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 12),
                      // PrimaryButton(
                      //   width: double.infinity,
                      //   onTap: () {
                      //     Navigator.pushNamed(
                      //       context,
                      //       RoutesPath.addNewPlayerScreen,
                      //     );
                      //   },
                      //   radius: 20.r,
                      //   textStyle: descriptiveStyle.copyWith(
                      //     color: Colors.white,
                      //     fontSize: 30.sp,
                      //   ),
                      //   title: 'Add New Game',
                      //   backgroundColor: AppColors.secondaryColor,
                      // ),
                    ],
                  );
                }

                // Tablet or desktop screen
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Summary Statistics'.toUpperCase(),
                      style: descriptionHeader.copyWith(
                        fontSize: 24.sp,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    SizedBox(width: 27.w),
                    PrimaryButton(
                      width: 239.w,
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder:
                              (context) => PreviousGameDialog(
                                items: [
                                  {
                                    'name': 'At Tigers',
                                    'date': 'April 03, 2025',
                                  },
                                  {
                                    'name': 'Vs Commanders',
                                    'date': 'April 06, 2025',
                                  },
                                  {
                                    'name': 'At Wildcats',
                                    'date': 'April 10, 2025',
                                  },
                                ],
                              ),
                        );
                      },
                      radius: 20.r,
                      textStyle: descriptiveStyle.copyWith(
                        color: Colors.white,
                        fontSize: 22.sp,
                      ),
                      title: 'Previous Game',
                      backgroundColor: AppColors.primaryColor,
                    ),
                    SizedBox(width: 27.w),
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
  final List<Map<String, String>> teams = [
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
    {
      "no": "12",
      "% innings played": "50%",
      "name": "Eagles",
      "total_innings": "2025",
      "%inf": "25",
      "favourite_position": "11u",
      "average_player": "11u",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width < 600) {
          return _MobileLayout(teams: teams); // Batch 2
        } else if (width >= 600 && width < 1024) {
          return _TabletLayout(teams: teams); // Batch 3
        } else {
          return _WebLayout(teams: teams); // Batch 3
        }
      },
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final List<Map<String, String>> teams;

  const _MobileLayout({required this.teams});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          teams.map((team) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("#", team['name']!),
                  _buildInfoRow("Team Name", team['name']!),
                  _buildInfoRow("Year", team['year']!),
                  _buildInfoRow("Season", team['season']!),
                  _buildInfoRow("Age Group", team['age']!),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.activeGreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Edit Team',
                          style: fieldLabelStyle.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/delete_icon.png',
                          height: 36.h,
                          width: 40.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Divider(
                      height: 1,
                      color: Color(0xffEAEAEA),
                      thickness: 1,
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
            style: tableLabel.copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: fieldLabelStyle.copyWith(
                color: AppColors.descriptiveTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final List<Map<String, String>> teams;

  const _TabletLayout({required this.teams});

  @override
  Widget build(BuildContext context) {
    final double sNo = 30;
    final double playerNameWidth = 120;
    final double inningPlayedWidth = 150;
    final double totalInningsWidth = 100;
    final double infWidth = 70;
    final double favoritePositionWidth = 160;
    final double averagePlayerWidth = 140;
    final double actionWidth = 80;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xffE6E6E6),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              _buildHeader("#", sNo),
              _buildHeader("Player Names", playerNameWidth),
              _buildHeader("% innings played", inningPlayedWidth),
              _buildHeader("Total innings", totalInningsWidth),
              _buildHeader("% INF", infWidth),
              _buildHeader("Favorite Position", favoritePositionWidth),
              _buildHeader("Average players", averagePlayerWidth),
              SizedBox(width: actionWidth),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...teams.map(
          (team) => _buildRow(
            team,
            sNo,
            playerNameWidth,
            inningPlayedWidth,
            totalInningsWidth,
            infWidth,
            favoritePositionWidth,
            averagePlayerWidth,
            actionWidth,
            context,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: tableLabel.copyWith(color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildRow(
    Map<String, String> team,
    double snoWidth,
    double playerNameWidth,
    double inningPlayedWidth,
    double totalInningsWidth,
    double infWidth,
    double favoritePositionWidth,
    double averagePlayerWidth,
    double actionWidth,
    BuildContext context,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              SizedBox(
                width: snoWidth,
                child: Text(
                  team['no']!,
                  style: tableContentHeader.copyWith(
                    color: AppColors.descriptiveTextColor,
                  ),
                ),
              ),

              SizedBox(
                width: playerNameWidth,
                child: Text(team['name']!, style: fieldLabelStyle),
              ),
              SizedBox(
                width: inningPlayedWidth,
                child: Text(team['% innings played']!, style: fieldLabelStyle),
              ),
              SizedBox(
                width: totalInningsWidth,
                child: Text(team['total_innings']!, style: fieldLabelStyle),
              ),
              SizedBox(
                width: infWidth,
                child: Text(team['%inf']!, style: fieldLabelStyle),
              ),
              SizedBox(
                width: favoritePositionWidth,
                child: Text(
                  team['favourite_position']!,
                  style: fieldLabelStyle,
                ),
              ),
              SizedBox(
                width: averagePlayerWidth,
                child: Text(team['average_player']!, style: fieldLabelStyle),
              ),
              SizedBox(
                width: actionWidth,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => EditPlayerDialog(),
                        );
                      },
                      icon: Icon(Icons.edit, color: AppColors.primaryColor),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      child: Image.asset(
                        'assets/images/delete_icon.png',
                        height: 18.h,
                        width: 20.w,
                      ),
                      onTap: () {

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Divider(height: 1, color: Color(0xffEAEAEA), thickness: 1),
        ),
      ],
    );
  }
}

class _WebLayout extends StatelessWidget {
  final List<Map<String, String>> teams;

  const _WebLayout({required this.teams});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 1024),
        child: _TabletLayout(teams: teams),
      ),
    );
  }
}
