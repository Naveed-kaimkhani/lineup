import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

class SuccessPurchaseTeamDialog extends StatelessWidget {
  const SuccessPurchaseTeamDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive calculations
    final screenSize = MediaQuery.of(context).size;

    // Create responsive values based on screen size
    final dialogWidth = screenSize.width > 800 ? 768.0 : screenSize.width * 0.9;
    final dialogHeight = screenSize.height > 600 ? 500.0 : screenSize.height * 0.7;
    final iconSize = screenSize.width > 600 ? 64.0 : 48.0;
    final iconImageSize = screenSize.width > 600 ? 36.0 : 28.0;
    final verticalPadding = screenSize.height > 600 ? 60.0 : 30.0;
    final horizontalPadding = screenSize.width > 600 ? 80.0 : 40.0;
    final spacingBetweenElements = screenSize.height > 600 ? 50.0 : 30.0;

    // Get text style based on screen size
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: screenSize.width > 600 ? 18.0 : 16.0,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // 1️⃣ Blurred backdrop
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: dialogWidth,
                maxHeight: dialogHeight,
              ),
              child: Container(
                width: dialogWidth,
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: iconSize,
                      width: iconSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondaryColor),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/thumbs_up.png',
                          height: iconImageSize,
                          width: iconImageSize,
                        ),
                      ),
                    ),
                    SizedBox(height: spacingBetweenElements),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'YOUR TEAM ',
                              style: titleStyle?.copyWith(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: 'HAVE BEEN SUCCESSFULLY CREATED!',
                              style: titleStyle?.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: spacingBetweenElements),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isNarrow = constraints.maxWidth < 400;

                        if (isNarrow) {
                          // Stack buttons vertically on narrow screens
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                  onTap: () => Navigator.pop(context),
                                  title: 'Edit Roster', // Fixed typo from "Roaster" to "Roster"
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                  onTap: () => Navigator.pop(context),
                                  title: 'Continue',
                                  backgroundColor: AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Use row layout for wider screens
                          return Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  onTap: () => Navigator.pop(context),
                                  title: 'Edit Roster', // Fixed typo from "Roaster" to "Roster"
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: PrimaryButton(
                                  onTap: () => Navigator.pop(context),
                                  title: 'Continue',
                                  backgroundColor: AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


