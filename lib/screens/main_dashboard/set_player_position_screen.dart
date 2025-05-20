


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart' show AppColors;
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/screens/main_dashboard/add_position_screen.dart';
import 'package:gaming_web_app/screens/main_dashboard/edit_positon_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/teamController/teamController.dart';

class SetPlayerPositionScreen extends StatelessWidget {
  final VoidCallback onEdit;
  SetPlayerPositionScreen({super.key, required this.onEdit});
  final TeamController controller = Get.find<TeamController>();
  final List<Map<String, String>> position = [
    {"position": "P", "category": "INF"},
    {"position": "C", "category": "INF"},
    {"position": "OUT", "category": "OF"},
    {"position": "1B", "category": "INF"},
    {"position": "2B", "category": "INF"},
    {"position": "3B", "category": "INF"},
    {"position": "SS", "category": "INF"},
    {"position": "RF", "category": "OF"},
    {"position": "LF", "category": "OF"},
    {"position": "CF", "category": "OF"},
  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Text(
              'SET PLAYER POSITIONS',
              style: tableContentHeader.copyWith(
                color: AppColors.primaryColor,
                fontSize: 25
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Position',
                    style: tableLabel.copyWith(
                      color: Color(0xff555555),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Category',
                    style: tableLabel.copyWith(
                      color: Color(0xff555555),
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(), // Empty for Edit Button title
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 8.h),
            ...controller.teamPositioned.map((position) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          position!.name!,
                          style: tableContentHeader.copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          position.category!,
                          style: tableContentHeader.copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // EditPositionButton(),
                    ],
                  ),
                  SizedBox(height: 8.h),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class EditPositionButton extends StatelessWidget {
  const EditPositionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
     
        onTap: () {

showDialog(
  context: context,
  builder: (context) => Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.r), // More smooth curve
    ),
    insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h), // Controls how much space around dialog
    child: Padding(
      padding: EdgeInsets.all(20.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 200.h,
          maxHeight: 500.h, // Limits height, but flexible
          minWidth: 300.w,
          maxWidth: 450.w, // Limits width to avoid stretching too much
        ),
        child: AddPositionScreen(
            positionNameController: TextEditingController(),
          positionCategoryController: TextEditingController(),
                                  // onEdit: () {},
                                ),
      ),
    ),
  ),
);


},
        child: Container(
          height: 30.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color:Colors.blue,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'Edit',
            style: tableContentHeader.copyWith(
              fontSize: 14.sp,
              color:Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
