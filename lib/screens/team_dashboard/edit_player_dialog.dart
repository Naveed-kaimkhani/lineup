import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/controller/teamController/playerEditController.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:gaming_web_app/service/api/team.dart';
import 'package:get/get.dart';


import '../../Base/controller/getTeamData.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../Base/model/updatePlayer.dart';
import '../../utils/snackbarUtils.dart';


class EditPlayerDialog extends StatefulWidget {
  final TeamPlayer? players;
  EditPlayerDialog({this.players});

  @override
  State<EditPlayerDialog> createState() => _EditPlayerDialogState();
}

class _EditPlayerDialogState extends State<EditPlayerDialog> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TeamController controllers = Get.find<TeamController>();
  final controller = Get.put(PlayerEditController());

  @override
  void initState() {
    super.initState();
    controller.fetchTeamsPositioned();

    // Initialize text controllers with existing player data
    if (widget.players != null) {
      _firstNameController.text = widget.players!.firstName;
      _lastNameController.text = widget.players!.lastName;
      _numberController.text = widget.players!.jerseyNumber;
      _emailController.text = widget.players!.email;
      _phoneController.text = widget.players!.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;

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
              constraints: BoxConstraints(
                maxWidth: maxWidth > 800 ? 768.w : maxWidth * 0.9,
                maxHeight: maxHeight * 0.9,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 40.h,
                  horizontal: maxWidth > 600 ? 60.w : 20.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'Edit ${widget.players?.firstName ?? ""} ${widget.players?.lastName ?? ""}'.toUpperCase(),
                              style: formHeaderStyle.copyWith(
                                color: AppColors.secondaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () => Get.back(),
                              child: Icon(Icons.cancel, color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Divider(height: 1, color: Color(0xffEAEAEA), thickness: 1),
                        SizedBox(height: 20.h),

                        /// Form Fields
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: [
                                SizedBox(
                                  width: maxWidth > 600 ? (768 / 2 - 80).w : double.infinity,
                                  child: PrimaryTextField(
                                    controller: _firstNameController,
                                    label: 'First Name',
                                    hintText: 'Mick',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'First name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: maxWidth > 600 ? (768 / 2 - 80).w : double.infinity,
                                  child: PrimaryTextField(
                                    controller: _lastNameController,
                                    label: 'Last Name',
                                    hintText: 'Johnathan',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Last name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: [
                                SizedBox(
                                  width: maxWidth > 600 ? (768 / 2 - 80).w : double.infinity,
                                  child: PrimaryTextField(
                                    controller: _numberController,
                                    label: 'Jersey Number',
                                    hintText: '5',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Jersey number is required';
                                      }
                                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                                        return 'Enter a valid number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: maxWidth > 600 ? (768 / 2 - 80).w : double.infinity,
                                  child: PrimaryTextField(
                                    controller: _emailController,
                                    label: 'Email',
                                    hintText: 'mick@gmail.com',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: maxWidth > 600 ? (768 / 2 - 80).w : double.infinity,
                                  child: PrimaryTextField(
                                    controller: _phoneController,
                                    label: 'Phone',
                                    hintText: '1234567890',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Phone number is required';
                                      }
                                      if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 30.h),
                        Divider(height: 1, color: Color(0xffEAEAEA), thickness: 1),
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
                                onTap: () async {
                                  if ( _firstNameController.text.isNotEmpty ||_lastNameController.text.isNotEmpty||_numberController.text.isNotEmpty) {
                                    final response =await TeamsApi.updatePlayer(
                                        UpdatePlayerModel(
                                          firstName: _firstNameController.text
                                              .trim(),
                                          lastName: _lastNameController.text
                                              .trim(),
                                          jerseyNumber: _numberController.text
                                              .trim(),
                                          email: _emailController.text.trim(),
                                          phone: _phoneController.text.trim(),
                                        ), widget.players!.id);

                                   if(response.success!){
                                     Get.back();
                                     SnackbarUtils.showSuccess(response.message!);
                                     controllers.fetchGetTeamData();
                                   }else{
                                     SnackbarUtils.showErrorr(response.message!);
                                   }

                                  }},
                                    // if (response.) {
                                    //   Navigator.pop(context);
                                    // },


                                  title: 'Confirm',
                                  backgroundColor: AppColors.activeGreenColor

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
          ),
        ],
      ),
    );
  }
}






// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/Base/model/positioned.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
// import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
//
// import '../../Base/componant/dropdown.dart';
// import '../../Base/controller/admin/OrgnizationController.dart';
// import '../../Base/controller/getTeamData.dart';
// import '../../Base/controller/teamController/playerEditController.dart';
// import '../../Base/model/teamModel/teamModel.dart';
// import '../../service/api/team.dart';
//
// class EditPlayerDialog extends StatefulWidget {
//   final TeamPlayer? players;
//   EditPlayerDialog({this.players});
//
//   @override
//   State<EditPlayerDialog> createState() => _EditPlayerDialogState();
// }
//
// class _EditPlayerDialogState extends State<EditPlayerDialog> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _numberController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final controller = Get.put(PlayerEditController()); // or pass as argument
//   @override
//   void initState() {
//     super.initState();
//     controller.fetchTeamsPositioned();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final maxWidth = MediaQuery.of(context).size.width;
//     final maxHeight = MediaQuery.of(context).size.height;
//     _firstNameController.text = widget.players!.firstName;
//     _lastNameController.text = widget.players!.lastName;
//     _numberController.text = widget.players!.jerseyNumber;
//     _emailController.text = widget.players!.email;
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.zero,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//               child: Container(color: Colors.black.withOpacity(0.3)),
//             ),
//           ),
//           Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: maxWidth > 800 ? 768.w : maxWidth * 0.9,
//                 maxHeight: maxHeight * 0.9,
//               ),
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 40.h,
//                   horizontal: maxWidth > 600 ? 60.w : 20.w,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16.r),
//                   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: [
//                           Spacer(),
//                           Text(
//                             'Edit Mick Johnathan'.toUpperCase(),
//                             style: formHeaderStyle.copyWith(
//                               color: AppColors.secondaryColor,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Spacer(),
//                           InkWell(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Icon(Icons.cancel, color: Colors.red),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 30.h),
//                       Divider(
//                         height: 1,
//                         color: Color(0xffEAEAEA),
//                         thickness: 1,
//                       ),
//                       SizedBox(height: 20.h),
//
//                       /// Form Fields
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Wrap(
//                             spacing: 10.w,
//                             runSpacing: 10.h,
//                             children: [
//                               SizedBox(
//                                 width:
//                                     maxWidth > 600
//                                         ? (768 / 2 - 80).w
//                                         : double.infinity,
//                                 child: PrimaryTextField(
//                                   controller: _firstNameController,
//                                   label: 'First Name',
//                                   hintText: 'Mick',
//                                 ),
//                               ),
//                               SizedBox(
//                                 width:
//                                     maxWidth > 600
//                                         ? (768 / 2 - 80).w
//                                         : double.infinity,
//                                 child: PrimaryTextField(
//                                   controller: _lastNameController,
//                                   label: 'Last Name',
//                                   hintText: 'Johnathan',
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20.h),
//                           Wrap(
//                             spacing: 10.w,
//                             runSpacing: 10.h,
//                             children: [
//                               SizedBox(
//                                 width:
//                                     maxWidth > 600
//                                         ? (768 / 2 - 80).w
//                                         : double.infinity,
//                                 child: PrimaryTextField(
//                                   controller: _numberController,
//                                   label: 'Number',
//                                   hintText: '123 456 789',
//                                 ),
//                               ),
//                               SizedBox(
//                                 width:
//                                     maxWidth > 600
//                                         ? (768 / 2 - 80).w
//                                         : double.infinity,
//                                 child: PrimaryTextField(
//                                   controller: _emailController,
//                                   label: 'Email',
//                                   hintText: 'mick@gmail.com',
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                         ],
//                       ),
//                       SizedBox(height: 30.h),
//                       Divider(
//                         height: 1,
//                         color: Color(0xffEAEAEA),
//                         thickness: 1,
//                       ),
//                       SizedBox(height: 30.h),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: PrimaryButton(
//                               onTap: () => Navigator.pop(context),
//                               title: 'Cancel',
//                               backgroundColor: Color(0xFFC5C5C5),
//                             ),
//                           ),
//                           SizedBox(width: 20.w),
//                           Expanded(
//                             child: PrimaryButton(
//                               onTap: () {
//                                 final response = TeamsApi.updatePlayer();
//                               },
//
//                               // Navigator.pop(context),
//                               title: 'Confirm',
//                               backgroundColor: AppColors.activeGreenColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// SizedBox(height: 30.h),
// Text('Positions', style: fieldLabelStyle),
// SizedBox(height: 20.h),
// GetBuilder<PlayerEditController>(
//   builder: (controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Player’s preferred Positions',
//           style: descriptionStyle.copyWith(
//             fontSize: 14,
//             color: AppColors.activeGreenColor,
//           ),
//         ),
//         const SizedBox(height: 10),
//
//         // ✅ Wrap makes items flow into multiple lines if needed
//         Wrap(
//           spacing: 8, // Horizontal space
//           runSpacing: 10, // Vertical space between lines
//           children: List.generate(
//     widget.players.
//             // controller.preferredPositions.length,
//                 (index) => SizedBox(
//               width: 150, // Set width to make items fit in Row
//               child: DynamicDropdownList<Position>(
//                 items: controller.teamPositioned,
//                 selectedItem: controller.preferredPositions[index],
//                 itemLabelBuilder: (pos) => pos?.name ?? 'No Name',
//                 onChanged: (val) {
//                   if (val != null) {
//                     controller.updatePreferredPosition(index, val);
//                   }
//                 },
//                 hint: "Select",
//               ),
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 10),
//
//         ElevatedButton(
//           onPressed: controller.addPreferredPosition,
//           child: const Text("Add Position"),
//         ),
//       ],
//     );
//   },
// ),

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Column(
//       children: [
//         Text(
//           'Player’s preferred Positions',
//           style: descriptionStyle.copyWith(
//             fontSize: 14,
//             color: AppColors.activeGreenColor,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: GetBuilder<PlayerEditController>(
//             builder: (controller) {
//               // if (controller.isLoading) {
//               //   return const Center(child: CircularProgressIndicator());
//               // }
//
//               return DynamicDropdownList<Position>(
//                 items: controller.teamPositioned!,
//                 selectedItem:
//                     controller.teamPositioned![0],
//                 itemLabelBuilder:
//                     (pos) => pos?.name ?? 'No Name',
//                 onChanged: (val) {
//                   if (val != null) {
//                     // controller.selectedPosition.value = val;
//                     // print('Selected ID: ${val.id}');
//                     // organizationController.setSelectedOrganization(); // Add logic if needed
//                   }
//                 },
//                 hint: "Select a position",
//                 // dropdownWidth: 400,
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: GetBuilder<PlayerEditController>(
//             builder: (controller) {
//               // if (controller.isLoading) {
//               //   return const Center(child: CircularProgressIndicator());
//               // }
//
//               return DynamicDropdownList<Position>(
//                 items: controller.teamPositioned!,
//                 selectedItem:
//                     controller.teamPositioned![0],
//                 itemLabelBuilder:
//                     (pos) => pos?.name ?? 'No Name',
//                 onChanged: (val) {
//                   if (val != null) {
//                     // controller.selectedPosition.value = val;
//                     // print('Selected ID: ${val.id}');
//                     // organizationController.setSelectedOrganization(); // Add logic if needed
//                   }
//                 },
//                 hint: "Select a position",
//                 // dropdownWidth: 400,
//               );
//             },
//           ),
//         ),
//         Expanded(
//           child: PrimaryButton(
//             onTap: () => Navigator.pop(context),
//             title: 'Confirm',
//             backgroundColor: AppColors.activeGreenColor,
//           ),
//         ),
//       ],
//     ),
//
//
//     Text(
//       'Position Player’s Doesn\'t play',
//       style: descriptionStyle.copyWith(
//         fontSize: 14,
//         color: Colors.red,
//       ),
//     ),
//   ],
// ),
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
// import 'package:gaming_web_app/constants/widgets/drop_down/dynamic_dropdown_list.dart';
// import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
//
// class EditPlayerDialog extends StatelessWidget {
//   EditPlayerDialog({super.key});
//
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _numberController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.zero,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//               child: Container(color: Colors.black.withOpacity(0.3)),
//             ),
//           ),
//           Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxHeight: 600.h),
//               child: Container(
//                 width: 768.w,
//                 padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 60.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16.r),
//                   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Edit Mick Johnathan'.toUpperCase(),
//                         style: formHeaderStyle.copyWith(
//                           color: AppColors.secondaryColor,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 50.h),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 18.w),
//                         child: Divider(
//                           height: 1,
//                           color: Color(0xffEAEAEA),
//                           thickness: 1,
//                         ),
//                       ),
//                       SizedBox(height: 20.h),
//
//                       /// Form Fields
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: PrimaryTextField(
//                                   controller: _firstNameController,
//                                   label: 'First Name',
//                                   hintText: 'Mick',
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Expanded(
//                                 child: PrimaryTextField(
//                                   controller: _lastNameController,
//                                   label: 'Last Name',
//                                   hintText: 'Johnathan',
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20.h),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: PrimaryTextField(
//                                   controller: _numberController,
//                                   label: 'Number',
//                                   hintText: '123 456 789',
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                               Expanded(
//                                 child: PrimaryTextField(
//                                   controller: _emailController,
//                                   label: 'Email',
//                                   hintText: 'mick@gmail.com',
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 30.h),
//                           Text('Positions', style: fieldLabelStyle),
//                           SizedBox(height: 20.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Player’s preferred Positions',
//                                 style: descriptionStyle.copyWith(
//                                   fontSize: 14,
//                                   color: AppColors.activeGreenColor,
//                                 ),
//                               ),
//                               Text(
//                                 'Position Player’s Doesn\'t play',
//                                 style: descriptionStyle.copyWith(
//                                   fontSize: 14,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                         ],
//                       ),
//                       SizedBox(height: 30.h),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 18.w),
//                         child: Divider(
//                           height: 1,
//                           color: Color(0xffEAEAEA),
//                           thickness: 1,
//                         ),
//                       ),
//                       SizedBox(height: 30.h),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: PrimaryButton(
//                               onTap: () => Navigator.pop(context),
//                               title: 'Cancel',
//                               backgroundColor: Color(0xFFC5C5C5),
//                             ),
//                           ),
//                           SizedBox(width: 20.w),
//                           Expanded(
//                             child: PrimaryButton(
//                               onTap: () => Navigator.pop(context),
//                               title: 'Confirm',
//                               backgroundColor: AppColors.activeGreenColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
