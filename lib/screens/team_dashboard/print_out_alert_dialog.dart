import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';

class PrintOutAlertDialog extends StatelessWidget {
  const PrintOutAlertDialog({super.key});

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
              height: 400.h,
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
                  Text(
                    'View lineup print out? '.toUpperCase(),
                    style: formHeaderStyle.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 50.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        width: 171.24.w,
                        onTap: () => Navigator.pop(context),
                        title: 'Dashboard',
                        backgroundColor: AppColors.primaryColor,
                      ),
                      SizedBox(width: 20.w),
                      PrimaryButton(
                        width: 171.24.w,
                        onTap: () => Navigator.pop(context),
                        title: 'Yes',
                        backgroundColor: AppColors.secondaryColor,
                      ),
                    ],
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
