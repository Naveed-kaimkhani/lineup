import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';

class SelectPlayerPositionScreen extends StatelessWidget {
  const SelectPlayerPositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Text(
          'SELECT PLAYER POSITIONS',
          style: tableContentHeader.copyWith(
            color: AppColors.primaryColor,
            fontSize: 25.sp,
          ),
        ),
        SizedBox(height: 39.57.h),
      ],
    );
  }
}
