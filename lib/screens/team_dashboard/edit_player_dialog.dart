import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/drop_down/dynamic_dropdown_list.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';

class EditPlayerDialog extends StatelessWidget {
  EditPlayerDialog({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 600.h),
              child: Container(
                width: 768.w,
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 60.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit Mick Johnathan'.toUpperCase(),
                        style: formHeaderStyle.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Divider(
                          height: 1,
                          color: Color(0xffEAEAEA),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// Form Fields
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryTextField(
                                  controller: _firstNameController,
                                  label: 'First Name',
                                  hintText: 'Mick',
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: PrimaryTextField(
                                  controller: _lastNameController,
                                  label: 'Last Name',
                                  hintText: 'Johnathan',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryTextField(
                                  controller: _numberController,
                                  label: 'Number',
                                  hintText: '123 456 789',
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: PrimaryTextField(
                                  controller: _emailController,
                                  label: 'Email',
                                  hintText: 'mick@gmail.com',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Text('Positions', style: fieldLabelStyle),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Player’s preferred Positions',
                                style: descriptionStyle.copyWith(
                                  fontSize: 14,
                                  color: AppColors.activeGreenColor,
                                ),
                              ),
                              Text(
                                'Position Player’s Doesn\'t play',
                                style: descriptionStyle.copyWith(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Expanded(
                          //       child: DynamicDropdownList<String>(
                          //         items: [
                          //           'Striker',
                          //           'Goalkeeper',
                          //           'Defender',
                          //           'Midfielder',
                          //         ],
                          //         itemLabelBuilder: (item) => item,
                          //         dropdownWidth: 300,
                          //       ),
                          //     ),
                          //     SizedBox(width: 20.w),
                          //     Expanded(
                          //       child: DynamicDropdownList<String>(
                          //         items: [
                          //           'Striker',
                          //           'Goalkeeper',
                          //           'Defender',
                          //           'Midfielder',
                          //         ],
                          //         itemLabelBuilder: (item) => item,
                          //         dropdownWidth: 300,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Divider(
                          height: 1,
                          color: Color(0xffEAEAEA),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              onTap: () => Navigator.pop(context),
                              title: 'Cancel',
                              backgroundColor: Color(0xFFC5C5C5),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: PrimaryButton(
                              onTap: () => Navigator.pop(context),
                              title: 'Confirm',
                              backgroundColor: AppColors.activeGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
