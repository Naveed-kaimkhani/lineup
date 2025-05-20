import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';

class ColoredNameText extends StatelessWidget {
  final String name;
  final Color? firstColor;
  final Color? secondColor;
  final TextStyle? textStyle;

  const ColoredNameText({
    super.key,
    required this.name,
    this.firstColor,
    this.secondColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final parts = name.trim().split(' ');
    final firstPart = parts.isNotEmpty ? parts[0] : '';
    final secondPart = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return RichText(
      text: TextSpan(
        style:
            textStyle ??
            DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
        children: [
          TextSpan(
            text: firstPart,
            style: tableLabel.copyWith(
              color: firstColor ?? AppColors.primaryColor,
              fontFamily: 'Poppins',
            ),
          ),
          if (secondPart.isNotEmpty)
            TextSpan(
              text: ' $secondPart',
              style: fieldLabelStyle.copyWith(
                color: secondColor ?? AppColors.descriptiveTextColor,
              ),
            ),
        ],
      ),
    );
  }
}
