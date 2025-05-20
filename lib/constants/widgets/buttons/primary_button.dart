// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';

// class PrimaryButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String title;
//   final double? radius;
//   final Color? backgroundColor;
//   final Color? labelColor;
//   final bool hasBorder;
//   final Color? borderColor;
//   final double width;
//   final TextStyle? textStyle;
//   const PrimaryButton({
//     super.key,
//     required this.onTap,
//     required this.title,
//     this.radius,
//     this.backgroundColor,
//     this.labelColor,
//     this.hasBorder = false,
//     this.borderColor,
//     this.width = 0.8,
//     this.textStyle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: 72.h,
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           elevation: 0,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           backgroundColor: backgroundColor ?? AppColors.primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(radius ?? 20.r),
//             side:
//                 hasBorder
//                     ? BorderSide(
//                       color: borderColor ?? AppColors.primaryColor,
//                       width: 2,
//                     )
//                     : BorderSide.none,
//           ),
//         ),
//         child: Text(
//           title,

//           style:
//               textStyle ??
//               buttonLabel.copyWith(color: labelColor ?? Colors.white),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double? radius;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool hasBorder;
  final Color? borderColor;
  final double? width;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
    this.radius,
    this.backgroundColor,
    this.labelColor,
    this.hasBorder = false,
    this.borderColor,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 20),
            side: hasBorder
                ? BorderSide(
                    color: borderColor ?? AppColors.primaryColor,
                    width: 2,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: textStyle ??
              buttonLabel.copyWith(color: labelColor ?? Colors.white),
        ),
      ),
    );
  }
}
