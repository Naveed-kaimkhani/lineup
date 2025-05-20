import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';

class SocialAppButton extends StatelessWidget {
  final String image;
  final VoidCallback onTap;
  const SocialAppButton({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondaryColor,
        ),
        child: Image.asset(image, height: 22.09.h, width: 22.09.w),
      ),
    );
  }
}
