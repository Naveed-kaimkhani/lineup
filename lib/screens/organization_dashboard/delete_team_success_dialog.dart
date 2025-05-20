import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';

class DeleteTeamSuccessDialog extends StatelessWidget {
  const DeleteTeamSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              width: 768.w,
              height: 500.h,
              padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 80.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 64.h,
                    width: 64.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.secondaryColor),
                    ),
                    child: Image.asset(
                      'assets/images/delete_icon.png',
                      height: 36.h,
                      width: 40.w,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Team successfully '.toUpperCase(),
                          style: formHeaderStyle.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'removed from your organization '.toUpperCase(),
                          style: formHeaderStyle.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),

                  PrimaryButton(
                    width: 171.24.w,
                    onTap: () => Navigator.pop(context),
                    title: 'Continue',
                    backgroundColor: AppColors.secondaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
