
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/player_background_scaffold.dart';
import 'package:gaming_web_app/routes/routes_path.dart';
import 'package:gaming_web_app/screens/main_dashboard/set_favored_position_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../constants/SharedPreferencesKeysConstants.dart';
import '../../utils/SharedPreferencesUtil.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLogin = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.isLogin,
    );

    if (isLogin == "1") {
      // Navigate to the next screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAndToNamed(RoutesPath.mainDashboardScreen);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => NextScreen()),
        // );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlayerBackgroundScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;

          // Define breakpoints - more granular breakpoints for better responsiveness
          bool isMobile = screenWidth < 600;
          bool isTablet = screenWidth >= 600 && screenWidth < 1024;
          bool isDesktop = screenWidth >= 1024;

          // Adjust sizes based on screen width
          double horizontalPadding = isMobile ? 16 : isTablet ? 40 : 80;
          double verticalPadding = isMobile ? 24 : isTablet ? 40 : 52;

          // Image sizing
          double imageWidth = isMobile ? screenWidth * 0.7 : isTablet ? 280 : 360;
          double imageHeight = isMobile ? 100 : isTablet ? 120 : 146;

          // Spacing
          double titleSpacing = isMobile ? 2 : 4;
          double descriptionSpacing = isMobile ? 16 : 20;
          double buttonAreaSpacing = isMobile ? 24 : 32;

          // Button sizing
          double buttonWidth = isMobile ? screenWidth * 0.85 :
          isTablet ? min(screenWidth * 0.4, 280) : 298;
          double buttonSpacing = isMobile ? 12 : 16;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 1
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/line_up_hero_header.png',
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Game-Ready',
                    style: bannerHeaderStyle.copyWith(
                      color: AppColors.descriptiveTextColor,
                      fontSize: isMobile ?35 : isTablet ?60 :80,
                    ),
                  ),
                  Text(
                    'Lineup',
                    style: bannerMainLabelStyle.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize:  isMobile ?40 : isTablet ?60 :80,
                      height: 0.9, // Tighter line height
                    ),
                  ),
                  SizedBox(height: descriptionSpacing),
                  SizedBox(
                    // width: isMobile ? 300 : isTablet ?400 :600,
                    child:ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? 300: isTablet ? 500.w : 700.w, // Adjust width as needed
                        minHeight: 40.h, // Optional: forces space for min lines
                      ),
                      child: Text(
                        'Take the guesswork out of coaching with fair, fast, and effortless lineup creation.',
                        // maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.visible, // Or use TextOverflow.ellipsis if you want dots
                        style: descriptiveStyle.copyWith(
                          color: AppColors.descriptiveTextColor,
                          fontSize: isMobile ? 16 : isTablet ? 24.sp : 28.sp,
                          height: 1.5, // Line height multiplier
                        ),
                      ),
                    )

                  ),
                  SizedBox(height: buttonAreaSpacing),
                  isMobile || isTablet
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PrimaryButton(
                        width: buttonWidth,
                        onTap: () => Navigator.pushNamed(context, RoutesPath.signUp),
                        title: '  Start Building Lineups  ',
                      ),
                      SizedBox(height: buttonSpacing),
                      PrimaryButton(
                        onTap: () => Navigator.pushNamed(context, RoutesPath.signIn),
                        width: buttonWidth,
                        title: '  Already a Coach? Login  ',
                        labelColor: Colors.black,
                        hasBorder: true,
                        backgroundColor: AppColors.primaryColorLighterShade,
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PrimaryButton(
                        width: buttonWidth,
                        onTap: () => Navigator.pushNamed(context, RoutesPath.signUp),
                        title: '  Start Building Lineups  ',
                      ),
                      SizedBox(width: buttonSpacing),
                      PrimaryButton(
                        onTap: () => Navigator.pushNamed(context, RoutesPath.signIn),
                        width: buttonWidth,
                        title: '  Already a Coach? Login  ',
                        labelColor: Colors.black,
                        hasBorder: true,
                        backgroundColor: AppColors.primaryColorLighterShade,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}