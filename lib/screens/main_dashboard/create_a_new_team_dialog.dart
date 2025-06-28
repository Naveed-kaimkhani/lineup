import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/screens/main_dashboard/add_player_dialog.dart';
import 'package:gaming_web_app/screens/main_dashboard/add_season_screen.dart';
import 'package:gaming_web_app/screens/main_dashboard/add_team_location_screen.dart';
import 'package:gaming_web_app/screens/main_dashboard/add_team_name_screen.dart';
import 'package:gaming_web_app/screens/main_dashboard/add_year_screen.dart';
import 'package:gaming_web_app/screens/main_dashboard/setFavouritPosition.dart';
import 'package:gaming_web_app/screens/main_dashboard/set_player_position_screen.dart';
import 'package:get/get.dart';
import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../utils/snackbarUtils.dart';

class CreateTeamDialog extends StatefulWidget {
  CreateTeamDialog({Key? key}) : super(key: key);

  @override
  State<CreateTeamDialog> createState() => _CreateTeamDialogState();
}

class _CreateTeamDialogState extends State<CreateTeamDialog> {
  int _selectedSportIndex = -1;
  final NewTeamController newTeamController = Get.find<NewTeamController>();

  void _goToPrevious() async {
    SnackbarUtils.showErrorr('Please Fill All Next Requirement'.toString());
  }

  // final int totalPages = 11; // total number of pages

  String addPositionLabel = 'Back';
  // String addPositionLabel = 'Add Position';
  String continueLabel = 'Continue';

  Widget positionWidget = SetPlayerPositionScreen(onEdit: () {});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    newTeamController.initDimensions(context);
  }

  @override
  Widget build(BuildContext context) {
    // Update dimensions on rebuild to handle orientation changes
    newTeamController.updateDimensions(context);

    final screenSize = MediaQuery.of(context).size;
    final NewTeamController controller = Get.find<NewTeamController>();

    // Responsive text sizes
    final headerFontSize = screenSize.width < 600 ? 18.0 : 25.0;
    final buttonTextSize = screenSize.width < 600 ? 14.0 : 16.0;

    // Responsive padding
    final verticalPadding = screenSize.height * 0.04; // 4% of screen height
    final horizontalPadding = screenSize.width * 0.01; // 5% of screen width

    // Responsive spacing
    final smallSpacing = screenSize.height * 0.01; // 1% of screen height

    // Adjust indicator dots size
    final dotSize = screenSize.width < 600 ? 8.0 : 8.0;
    final activeDotSize = screenSize.width < 600 ? 9.0 : 12.0;
    final TeamController teamController = Get.find<TeamController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,

      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
              ),
              Center(
                child: Obx(
                  () => Container(
                    width:
                        constraints.maxWidth < 700
                            ? constraints
                                .maxWidth // full width for phones
                            : newTeamController
                                .dialogWidth
                                .value, // custom width for tablets/desktops
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * 0.95,
                      // maxHeight: constraints.maxHeight * 0.95,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 12),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'CREATE NEW TEAM',
                              style: TextStyle(
                                fontSize: headerFontSize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            Spacer(),
                            // Spacer(),
                            InkWell(
                              onTap: () {
                                controller.currentPage.value = 0;
                                Get.back();
                                teamController.getData();
                                controller.orgCode.text = "";
                                controller.PromoCode.text = "";
                                newTeamController.isHavingCredit.value = false;
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 50,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: smallSpacing),

                        const Divider(
                          height: 1,
                          color: Color(0xffEAEAEA),
                          thickness: 1,
                        ),

                        // Content - Fixed height container with page view
                        Obx(
                          () => Container(
                            height: newTeamController.dialogHeight.value,
                            constraints: BoxConstraints(
                              // Reduce max height to leave room for buttons and indicators
                              // maxHeight: constraints.maxHeight * 0.6,
                            ),
                            child: PageView(
                              controller: newTeamController.pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                              //  controller.orgCodeDialog(),
                              
                                _buildSportSelection(context),
                                AddTeamNameScreen(),
                                _buildTeamTypeSelection(context),
                                AdGeGroup(),
                                AddYearScreen(),
                                AddSeasonScreen(),
                                AddTeamLocationScreen(),
                                SetPlayerPositionScreen(onEdit: () {}),
                                AddPlayerDialog(),
                                SetFavoredPositionDialog(),
                              ],
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  newTeamController.goToPrevious(context);
                                },
                                // newTeamController.currentPage > 0 ? _goToPrevious : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: buttonTextSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.02),
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    () => {
                                      newTeamController.pageIndex(context),
                                    },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF003478),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: buttonTextSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: smallSpacing),

                        // Page indicator dots
                        Obx(
                          () => Container(
                            height:
                                dotSize *
                                1.5, // Fixed height container for dots
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                newTeamController.totalPages.value,
                                (i) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width:
                                      i == newTeamController.currentPage.value
                                          ? activeDotSize
                                          : dotSize,
                                  height:
                                      i == newTeamController.currentPage.value
                                          ? activeDotSize
                                          : dotSize,
                                  decoration: BoxDecoration(
                                    color:
                                        i <= newTeamController.currentPage.value
                                            ? const Color(0xFFB00020)
                                            : Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSportSelection(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sports = [
      {'label': 'Baseball', 'icon': 'assets/images/base_ball.png'},
      {'label': 'Softball', 'icon': 'assets/images/soft_ball.png'},
    ];
    final NewTeamController controller = Get.find<NewTeamController>();

    // Responsive dimensions
    // final iconSize = screenSize.width < 600 ? screenSize.width * 0.08 : 80.0;
    final iconContainerPadding = screenSize.width < 600 ? 15.0 : 20.0;
    // final fontSizeLabel = screenSize.width < 600 ? 12.0 : 14.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // final screenWidth = constraints.maxWidth;
        // final isMobile = screenWidth < 600;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: screenSize.height * 0.02),
            Text(
              'ENTER SPORT',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: screenSize.width < 600 ? 18.0 : 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(sports.length, (index) {
                final sport = sports[index];
                final selected = index == _selectedSportIndex;

                return GestureDetector(
                  onTap:
                      () => {
                        setState(() {
                          controller.sportType.value = sports[index]['label']!;

                          _selectedSportIndex = index;
                        }),
                      },

                  // debugger(),
                  // setState(() => _selectedSportIndex = index)
                  // },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                selected
                                    ? const Color(0xFF003478)
                                    : AppColors.secondaryColor,
                            width: selected ? 3 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(iconContainerPadding),
                        child: Image.asset(
                          sport['icon']!,
                          fit: BoxFit.contain,
                          height: 60,
                          // iconSize,
                          width: 60,
                          // iconSize,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        sport['label']!,
                        style: TextStyle(
                          fontSize: 20,
                          // fontSizeLabel,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTeamTypeSelection(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sports = [
      {'label': 'Travel', 'icon': 'assets/images/travel.png'},
      {'label': 'Recreation', 'icon': 'assets/images/recreation.png'},
      {'label': 'School', 'icon': 'assets/images/school.png'},
    ];
    final NewTeamController controller = Get.find<NewTeamController>();
    // Responsive dimensions
    final iconSize = screenSize.width < 600 ? screenSize.width * 0.06 : 60.0;
    final iconContainerPadding = screenSize.width < 600 ? 15.0 : 20.0;
    final fontSizeLabel = screenSize.width < 600 ? 12.0 : 14.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: screenSize.height * 0.02),
        Text(
          'SELECT TEAM TYPE',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: screenSize.width < 600 ? 18.0 : 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenSize.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(sports.length, (index) {
            final sport = sports[index];
            final selected = index == _selectedSportIndex;

            return GestureDetector(
              onTap: () {
                // Update the teamType in the controller
                controller.teamType.value = sports[index]['label']!;

                // Update the selected sport index to refresh UI
                setState(() {
                  _selectedSportIndex = index;
                });
              },

              // setState(() => _selectedSportIndex = index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            selected
                                ? const Color(0xFF003478)
                                : AppColors.secondaryColor,
                        width: selected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(iconContainerPadding),
                    child: Image.asset(
                      sport['icon']!,
                      fit: BoxFit.contain,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    sport['label']!,
                    style: TextStyle(
                      fontSize: 20,
                      // fontSizeLabel,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // Prevents overflow
                    maxLines: 1, // Limits to one line
                    softWrap: false,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
