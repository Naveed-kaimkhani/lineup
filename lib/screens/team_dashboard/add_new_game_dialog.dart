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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                           Row(children: [
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
                               onTap: (){
                                 Navigator.pop(context);
                               },

                               child: Icon(Icons.cancel, color: Colors.red,),),


                           ],),
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
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryTextField(
                                    controller: teamController.dateController,
                                    label: 'DATE',
                                    hintText: 'April 03 2025',
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: PrimaryTextField(
                                    controller: teamController.insController,
                                    label: 'INS\'S',
                                    hintText: '06',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
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
                                      side: MaterialStateBorderSide.resolveWith(
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
                                  child: Checkbox(
                                    value: teamController.isHomeSelected.value,
                                    onChanged: (val) {
                                      teamController.isHomeSelected.value =
                                          !teamController.isHomeSelected.value;
                                      teamController.type.value =
                                          teamController.isHomeSelected.value
                                              ? "home"
                                              : "away";
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text('Home', style: fieldLabelStyle),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
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
                                      side: MaterialStateBorderSide.resolveWith(
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
                                  child: Checkbox(
                                    value:
                                        teamController
                                            .isPreviousLineUpTemplate
                                            .value,
                                    onChanged: (val) {
                                      teamController
                                          .isPreviousLineUpTemplate
                                          .value = !teamController
                                              .isPreviousLineUpTemplate
                                              .value;
                                      teamController.type.value =
                                          teamController
                                                  .isPreviousLineUpTemplate
                                                  .value
                                              ? "away"
                                              : "home";
                                      // teamController.isPreviousLineUpTemplate= teamController.isPreviousLineUpTemplate;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Use previous lineup as template',
                                  style: fieldLabelStyle,
                                ),
                              ],
                            ),
                            if (teamController
                                .isPreviousLineUpTemplate
                                .value) ...[
                              SizedBox(height: 20),
                              CustomDropdown(
                                hintText: 'At Commanders April 06 2025',
                                items: ['Baseball', 'Softball'],
                                onChanged: (value) {},
                                itemLabelBuilder: (item) => item,
                              ),
                            ],
                            SizedBox(height: 50.h),
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
                                    onTap:
                                        () => teamController
                                            .validateAndSubmitAddGame(
                                              context,
                                              controller.teamDataIndex.value,
                                            ),
                                    title: 'Create',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// // StatefulWidget that creates a dialog for adding a new game
// class AddNewGameDialog extends StatefulWidget {
//   const AddNewGameDialog({super.key});
//
//   @override
//   State<AddNewGameDialog> createState() => _AddNewGameDialogState();
// }
//
// class _AddNewGameDialogState extends State<AddNewGameDialog> {
//   // Controllers for the text input fields
//   // final TextEditingController _opponentController = TextEditingController();
//   // final TextEditingController _dateController = TextEditingController();
//   // final TextEditingController _insController = TextEditingController();
//
//   // State variables to track checkbox selections
//   // bool _ishomeSelected = false; // Tracks whether "Home" is selected
//   // bool _isPreviousLineUpTemplate = false; // Tracks whether to use previous lineup template
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent, // Transparent background for the dialog
//       insetPadding: EdgeInsets.zero, // No padding around the dialog
//       child: Stack(
//         children: [
//           // 1️⃣ Blurred backdrop - Creates a blurred background effect behind the dialog
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6), // Blur effect strength
//               child: Container(color: Colors.black.withOpacity(0.3)), // Semi-transparent overlay
//             ),
//           ),
//           Center(
//             child: Container(
//               // Dialog dimensions - Note that dialog height changes based on checkbox selection
//               width: 768.w, // Width using responsive sizing from screenutil
//               height: _isPreviousLineUpTemplate ? 880.h : 849.h, // Height changes if template option is selected
//               padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 80.w), // Internal padding
//               decoration: BoxDecoration(
//                 color: Colors.white, // White background for dialog
//                 borderRadius: BorderRadius.circular(16.r), // Rounded corners
//                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)], // Shadow effect
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Dialog title
//                   Text(
//                     'Add New Game '.toUpperCase(), // Converts text to uppercase
//                     style: formHeaderStyle.copyWith(
//                       color: AppColors.secondaryColor, // Using app color constants
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//
//                   SizedBox(height: 40.h), // Vertical spacing
//                   // Divider line below the title
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.w),
//                     child: Divider(
//                       height: 1,
//                       color: Color(0xffEAEAEA), // Light gray color
//                       thickness: 1,
//                     ),
//                   ),
//                   SizedBox(height: 40.h), // Vertical spacing
//
//                   // Opponent name text field
//                   PrimaryTextField(
//                     controller: _opponentController, // Links controller to the field
//                     label: 'Opponent Name',
//                     hintText: 'Tiger', // Placeholder text
//                   ),
//                   // Row containing Date and INS fields side by side
//                   Row(
//                     children: [
//                       Expanded(
//                         child: PrimaryTextField(
//                           controller: _dateController,
//                           label: 'DATE',
//                           hintText: 'April 03 2025',
//                         ),
//                       ),
//                       SizedBox(width: 10.w), // Horizontal spacing
//
//                       Expanded(
//                         child: PrimaryTextField(
//                           controller: _insController,
//                           label: 'INS\'S', // Note the escape character for apostrophe
//                           hintText: '06',
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Home checkbox row
//                   Row(
//                     children: [
//                       // Theme customization for checkbox appearance
//                       Theme(
//                         data: Theme.of(context).copyWith(
//                           checkboxTheme: CheckboxThemeData(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                 4,
//                               ), // Rounded corners for checkbox
//                             ),
//                             fillColor: MaterialStateProperty.resolveWith<
//                                 Color
//                             >((states) {
//                               if (states.contains(MaterialState.selected)) {
//                                 return Colors.white; // White fill when selected
//                               }
//                               return Colors
//                                   .white; // White fill when unselected (optional)
//                             }),
//                             checkColor: MaterialStateProperty.all(
//                               Colors.blue,
//                             ), // Blue check icon
//                             side: MaterialStateBorderSide.resolveWith((states) {
//                               if (states.contains(MaterialState.selected)) {
//                                 return BorderSide(
//                                   color: Colors.blue,
//                                   width: 2,
//                                 ); // Blue border when selected
//                               }
//                               return BorderSide(
//                                 color: Colors.grey.shade400,
//                                 width: 1,
//                               ); // Default gray border
//                             }),
//                           ),
//                         ),
//                         // Home checkbox
//                         child: Checkbox(
//                           value: _ishomeSelected, // Controlled by state variable
//                           onChanged: (val) {
//                             setState(() {
//                               _ishomeSelected = val ?? false; // Update state when checkbox changes
//                             });
//                           },
//                         ),
//                       ),
//
//                       SizedBox(width: 10.w), // Horizontal spacing
//                       Text('Home', style: fieldLabelStyle), // Checkbox label
//                     ],
//                   ),
//                   SizedBox(height: 20.h), // Vertical spacing
//                   // Previous lineup template checkbox row
//                   Row(
//                     children: [
//                       // Theme customization for checkbox (identical to the Home checkbox)
//                       Theme(
//                         data: Theme.of(context).copyWith(
//                           checkboxTheme: CheckboxThemeData(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                 4,
//                               ),
//                             ),
//                             fillColor: MaterialStateProperty.resolveWith<
//                                 Color
//                             >((states) {
//                               if (states.contains(MaterialState.selected)) {
//                                 return Colors.white;
//                               }
//                               return Colors
//                                   .white;
//                             }),
//                             checkColor: MaterialStateProperty.all(
//                               Colors.blue,
//                             ),
//                             side: MaterialStateBorderSide.resolveWith((states) {
//                               if (states.contains(MaterialState.selected)) {
//                                 return BorderSide(
//                                   color: Colors.blue,
//                                   width: 2,
//                                 );
//                               }
//                               return BorderSide(
//                                 color: Colors.grey.shade400,
//                                 width: 1,
//                               );
//                             }),
//                           ),
//                         ),
//                         // Template checkbox
//                         child: Checkbox(
//                           value: _isPreviousLineUpTemplate, // Controlled by state variable
//                           onChanged: (val) {
//                             setState(() {
//                               _isPreviousLineUpTemplate = val ?? false; // Update state when checkbox changes
//                             });
//                           },
//                         ),
//                       ),
//
//                       SizedBox(width: 10.w), // Horizontal spacing
//                       Text(
//                         'Use previous lineup as template',
//                         style: fieldLabelStyle, // Using predefined text style
//                       ),
//                     ],
//                   ),
//                   // Conditional rendering - Only show dropdown if template option is selected
//                   if (_isPreviousLineUpTemplate) ...[
//                     SizedBox(height: 20), // Vertical spacing
//                     CustomDropdown(
//                       hintText: 'At Commanders April 06 2025',
//                       items: ['Baseball', 'Softball'], // Dropdown options
//                       onChanged: (value) {}, // Empty callback for now
//                       itemLabelBuilder: (item) => item, // How to display each item
//                     ),
//                   ],
//                   SizedBox(height: 50.h), // Vertical spacing
//                   // Button row with Cancel and Create buttons
//                   Row(
//                     children: [
//                       // Cancel button
//                       Expanded(
//                         child: PrimaryButton(
//                           onTap: () => Navigator.pop(context), // Closes dialog when tapped
//                           title: 'Cancel',
//                           backgroundColor: Color(0xFFC5C5C5), // Gray color
//                         ),
//                       ),
//                       SizedBox(width: 20.w), // Horizontal spacing
//                       // Create button
//                       Expanded(
//                         child: PrimaryButton(
//                           onTap: () => Navigator.pop(context), // Closes dialog when tapped - would normally save data too
//                           title: 'Create',
//                           backgroundColor: AppColors.activeGreenColor, // Green color from app constants
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
