import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool hasUnderline;
  final Color? textColor;
  final double? fontSize;
  final String? fontFamily;

  const CustomTextButton({
    super.key,
    required this.title,
    required this.onTap,
    this.hasUnderline = false,
    this.textColor,
    this.fontSize,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove default padding
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        style: buttonLabel.copyWith(
          // fontSize: fontSize ?? 19.57.sp,
          fontFamily: fontFamily ?? 'sansation',
          color: textColor ?? AppColors.primaryColor,
          decorationColor: textColor ?? AppColors.primaryColor,
          decoration:
              hasUnderline ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
