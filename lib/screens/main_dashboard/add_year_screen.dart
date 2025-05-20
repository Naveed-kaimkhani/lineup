import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/teamController/createTeamController.dart';

class AddYearScreen extends StatelessWidget {

  AddYearScreen({super.key, });
  final NewTeamController controller = Get.find<NewTeamController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Text(
          'ENTER A YEAR',
          style: tableContentHeader.copyWith(
            color: AppColors.primaryColor,
            fontSize: 25
          ),
        ),
        SizedBox(height: 24.h),
        PrimaryTextField(
          controller: controller.ageGroupController,
          label: 'Year',
          hintText: '2025',
        ),
      ],
    );
  }
}
