
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int maxLines;
  final String label;
  final double borderRadius;
  final String? hintText;
  final bool readAble;

  const PrimaryTextField({
    super.key,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLines = 1,
    this.borderRadius = 12.0,
    required this.label,
    this.hintText,
    this.readAble = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.only(bottom: 19.75.h),
      child: SizedBox(
        width: isMobile ? double.infinity : 500, // adjust width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: fieldLabelStyle.copyWith(
                color: const Color(0xff555555),
                fontSize: isMobile ? 18 : 12,
              ),
            ),
            SizedBox(height: 9.79.h),
            SizedBox(
              height: 50, // responsive height
              child: TextFormField(
                readOnly: readAble,
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                maxLines: obscureText ? 1 : maxLines,
                validator: validator,
                style: tableLabel.copyWith(fontSize: isMobile ? 16 : 16),
                decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  filled: true,
                  hintText: hintText,
                  hintStyle: tableLabel.copyWith(color: Colors.black26),
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: isMobile ? 14.h : 18.h,
                    horizontal: 20.w,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: const BorderSide(
                      color: Color(0xB0DEDEDE),
                      width: 1.22,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      color: Color(0xFFDEDEDE),
                      width: 1.5,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      color: Color(0xB0DEDEDE),
                      width: 1.22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





