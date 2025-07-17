import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Package for responsive UI
import 'package:gaming_web_app/constants/app_colors.dart'; // App color constants
import 'package:gaming_web_app/constants/app_text_styles.dart'; // Text style constants
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart'; // Custom button widget
import 'package:gaming_web_app/constants/widgets/drop_down/custom_drop_down.dart'; // Custom dropdown widget
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/teamController.dart'; // Custom text field widget

class AddNewGameDialog extends StatelessWidget {
  const AddNewGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX controller binding
    // final GameController controller = Get.put(GameController());
    // final NewTeamController teamController = Get.put(NewTeamController());

    final NewTeamController teamController = Get.find<NewTeamController>();
    final TeamController controller = Get.find<TeamController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Center(
        child: Container(
          width:
              MediaQuery.of(context).size.width < 600
                  ? MediaQuery.of(context).size.width * 0.95
                  : 768.w,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
            // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Obx(
              () => Stack(
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(),
                    ),
                  ),
                  Center(
                    child: Container(
                      // width: 768.w,
                      // height: teamController.isPreviousLineUpTemplate.value ? 880.h : 849.h,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 12),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          width: 600,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    'Add New Game'.toUpperCase(),
                                    style: formHeaderStyle.copyWith(
                                      color: AppColors.secondaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      teamController.clearGameFormFields();
                                      Navigator.pop(context);
                                    },

                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Divider(
                                  height: 1,
                                  color: Color(0xffEAEAEA),
                                  thickness: 1,
                                ),
                              ),
                              SizedBox(height: 40.h),
                              PrimaryTextField(
                                controller: teamController.opponentController,
                                label: 'Opponent Name',
                                hintText: 'Tiger',
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment:
                                    Alignment
                                        .centerLeft, // Aligns to start (left)
                                child: Text(
                                  "              Select Date",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  teamController.selectDate(context);
                                },
                                child: Container(
                                  width: 500,
                                  padding: EdgeInsets.all(
                                    8,
                                  ), // Optional: Add padding around text
                                  decoration: BoxDecoration(
                                    color:
                                        Colors
                                            .white, // Optional: background color
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(
                                        0.2,
                                      ), // Change this to your desired border color
                                      width:
                                          1.5, // Optional: thickness of the border
                                    ),
                                  ),
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        teamController.datess.value == ""
                                            ? Text("Select Date")
                                            : Text(
                                              convertToMMddyyyy(
                                                teamController.datess.value,
                                              ),
                                            ),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),
                              PrimaryTextField(
                                controller: teamController.insController,
                                label: 'IN’s',
                                hintText: '06',
                              ),

                              Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((states) {
                                              if (states.contains(
                                                MaterialState.selected,
                                              )) {
                                                return Colors.white;
                                              }
                                              return Colors.white;
                                            }),
                                        checkColor: MaterialStateProperty.all(
                                          Colors.blue,
                                        ),
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                              (states) {
                                                if (states.contains(
                                                  MaterialState.selected,
                                                )) {
                                                  return BorderSide(
                                                    color: Colors.blue,
                                                    width: 2,
                                                  );
                                                }
                                                return BorderSide(
                                                  color: Colors.grey.shade400,
                                                  width: 1,
                                                );
                                              },
                                            ),
                                      ),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 50),

                                      child: Checkbox(
                                        value:
                                            teamController.isHomeSelected.value,
                                        onChanged: (val) {
                                          teamController.isHomeSelected.value =
                                              !teamController
                                                  .isHomeSelected
                                                  .value;
                                          teamController.type.value =
                                              teamController
                                                      .isHomeSelected
                                                      .value
                                                  ? "home"
                                                  : "away";
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 16.57.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 50.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      onTap: () {
                                        teamController.clearGameFormFields();
                                        Navigator.pop(context);
                                      },
                                      title: 'Cancel',
                                      backgroundColor: Color(0xFFC5C5C5),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: PrimaryButton(
                                      onTap:
                                          () => teamController
                                              .validateAndSubmitAddGame(
                                                context,
                                                controller.teamDataIndex.value,
                                              ),
                                      title: 'Create',
                                      backgroundColor:
                                          AppColors.activeGreenColor,
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
            ),
          ),
        ),
      ),
    );
  }
}

String convertToMMddyyyy(String dateString) {
  try {
    // Parse the input date (dd-MM-yyyy)
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(dateString);

    // Format to MM-dd-yyyy
    return DateFormat('MM-dd-yyyy').format(parsedDate);
  } catch (e) {
    return 'Invalid date';
  }
}
