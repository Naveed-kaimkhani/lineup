import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
class EditPositionScreen extends StatelessWidget {
  final TextEditingController positionNameController;
  final TextEditingController positionCategoryController;
  const EditPositionScreen({
    super.key,
    required this.positionNameController,
    required this.positionCategoryController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Text(
          'EDIT POSITION',
          style: tableContentHeader.copyWith(
            color: AppColors.primaryColor,
            fontSize: 25.sp,
          ),
        ),
        SizedBox(height: 24.h),
        PrimaryTextField(
          controller: positionNameController,
          label: 'Position Name',
          hintText: 'RF',
        ),
        
        PrimaryTextField(
          controller: positionCategoryController,
          label: 'Category',
          hintText: 'INF',
        ),
      ],
    );
  }
}

