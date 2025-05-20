import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';

class PrimaryDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String hintText;
  final double borderRadius;

  const PrimaryDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hintText,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 19.75.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: fieldLabelStyle.copyWith(color: Color(0xff555555)),
          ),
          SizedBox(height: 9.79.h),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius.r),
              border: Border.all(
                color: const Color(0xB0DEDEDE),
                width: 1.22,
              ),
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              hint: Text(
                hintText,
                style: tableLabel.copyWith(color: Color(0xffB7B7B7)),
              ),
              onChanged: onChanged,
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: tableContentHeader.copyWith(fontSize: 16.sp),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
