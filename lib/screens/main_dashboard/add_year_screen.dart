import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/componant/dropdown.dart';
import '../../Base/controller/teamController/createTeamController.dart';

class AddYearScreen extends StatelessWidget {
  AddYearScreen({super.key});
  final NewTeamController controller = Get.find<NewTeamController>();
  @override
  Widget build(BuildContext context) {
    List<String> years = List.generate(
      2191 - 1990,
      (index) => (1990 + index).toString(),
    );

    return Column(
      children: [
        SizedBox(height: 16.h),
        Text(
          'ENTER A YEAR',
          style: tableContentHeader.copyWith(
            color: AppColors.primaryColor,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 24.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Years", textAlign: TextAlign.start),
            SizedBox(height: 16),
            DynamicDropdownList<String>(
              items: years,
              selectedItem: controller.ageGroupController.text,
              itemLabelBuilder: (year) => year ?? 'No Year',
              onChanged: (val) {
                controller.ageGroupController.text = val.toString();
              },
              hint: "Select a year",
              dropdownWidth: 400,
            ),
          ],
        ),
      ],
    );
  }
}

class AdGeGroup extends StatelessWidget {
  AdGeGroup({super.key});
  final NewTeamController controller = Get.find<NewTeamController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Text(
          'ENTER AGE GROUP',
          style: tableContentHeader.copyWith(
            color: AppColors.primaryColor,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 24.h),
        PrimaryTextField(
          controller: controller.enterAgeGroupController,
          label: 'Enter Age Group',
          hintText: '18 yrs',
        ),
      ],
    );
  }
}

// class AdGeGroup extends StatelessWidget {
//   AdGeGroup({super.key});

//   final NewTeamController controller = Get.find<NewTeamController>();

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final fontSizeHeader = screenSize.width < 600 ? 18.0 : 25.0;
//     final verticalSpacing1 = screenSize.height * 0.02;
//     final verticalSpacing2 = screenSize.height * 0.025;
//     final textFieldWidth = screenSize.width < 400 ? double.infinity : 400.0;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(height: verticalSpacing1),
//         Text(
//           'ENTER AGE GROUP',
//           style: TextStyle(
//             color: AppColors.primaryColor,
//             fontSize: fontSizeHeader,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: verticalSpacing2),
//         Center(
//           child: SizedBox(
//             width: textFieldWidth,
//             child: PrimaryTextField(
//               controller: controller.enterAgeGroupController,
//               label: 'Enter Age Group',
//               hintText: 'e.g., U18, U21',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
