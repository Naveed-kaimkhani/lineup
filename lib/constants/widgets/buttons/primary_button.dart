
import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';

import '../../../utils/SharedPreferencesUtil.dart';

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













class BackButtons extends StatelessWidget {
  final Function() onTab;
  const BackButtons({required this.onTab});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
          // _navigateBack(context),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  void _navigateBack(BuildContext context) async {
    final lastRoute = await SharedPreferencesUtil.read('last_route');
    if (lastRoute != null && lastRoute.isNotEmpty) {
      Navigator.pushNamed(context, lastRoute);
    } else {
      Navigator.of(context).pop();
    }
  }
}








