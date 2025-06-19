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

  AddYearScreen({super.key, });
  final NewTeamController controller = Get.find<NewTeamController>();
  @override
  Widget build(BuildContext context) {
    List<String> years = List.generate(2191 - 1990, (index) => (1990 + index).toString());

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
         Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
         Text("Years",textAlign: TextAlign.start,),
        SizedBox(height: 16,),
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

         ],)






        //
        //
        //
        // PrimaryTextField(
        //   controller: controller.ageGroupController,
        //   label: 'Year',
        //   hintText: '2025',
        // ),
      ],
    );
  }
}



class AdGeGroup extends StatelessWidget {

  AdGeGroup({super.key, });
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
              fontSize: 25
          ),
        ),
        SizedBox(height: 24.h),
        PrimaryTextField(
          controller: controller.enterAgeGroupController,
          label: 'Enter Age Group',
          hintText: '',
        ),
      ],
    );
  }
}
