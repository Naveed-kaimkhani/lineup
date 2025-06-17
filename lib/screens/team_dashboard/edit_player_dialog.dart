import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/controller/teamController/playerEditController.dart';
import 'package:gaming_web_app/Base/model/player/getPlayerModel.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:gaming_web_app/screens/team_dashboard/edit_single_player_positionDialog.dart';
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
      print("iddd kya arhi hyyyy");
      print(widget.players!.id.toString());
      _firstNameController.text = widget.players!.firstName.toString();
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
                              'Edit ${widget.players?.firstName ?? ""} ${widget.players?.lastName ?? ""}'
                                  .toUpperCase(),
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
                        Divider(
                          height: 1,
                          color: Color(0xffEAEAEA),
                          thickness: 1,
                        ),
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
                                  width:
                                      maxWidth > 600
                                          ? (768 / 2 - 80).w
                                          : double.infinity,
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
                                  width:
                                      maxWidth > 600
                                          ? (768 / 2 - 80).w
                                          : double.infinity,
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
                                  width:
                                      maxWidth > 600
                                          ? (768 / 2 - 80).w
                                          : double.infinity,
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
                                  width:
                                      maxWidth > 600
                                          ? (768 / 2 - 80).w
                                          : double.infinity,
                                  child: PrimaryTextField(
                                    controller: _emailController,
                                    label: 'Email',
                                    hintText: 'mick@gmail.com',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      final emailRegex = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      );
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      maxWidth > 600
                                          ? (768 / 2 - 80).w
                                          : double.infinity,
                                  child: PrimaryTextField(
                                    controller: _phoneController,
                                    label: 'Phone',
                                    hintText: '1234567890',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Phone number is required';
                                      }
                                      if (!RegExp(
                                        r'^\d{10,15}$',
                                      ).hasMatch(value)) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (_) => EditSinglePlayerPositionDialog(
                                            player:
                                                convertTeamPlayerToGetPlayer(
                                                  widget.players!,
                                                ),
                                          ),
                                    );
                                  },
                                  child: const Text("Edit Positions"),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 30.h),
                        Divider(
                          height: 1,
                          color: Color(0xffEAEAEA),
                          thickness: 1,
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
                                onTap: () async {
                                  if (_firstNameController.text.isNotEmpty ||
                                      _lastNameController.text.isNotEmpty ||
                                      _numberController.text.isNotEmpty) {
                                    final response =
                                        await TeamsApi.updatePlayer(
                                          UpdatePlayerModel(
                                            firstName:
                                                _firstNameController.text
                                                    .trim(),
                                            lastName:
                                                _lastNameController.text.trim(),
                                            jerseyNumber:
                                                _numberController.text.trim(),
                                            email: _emailController.text.trim(),
                                            phone: _phoneController.text.trim(),
                                          ),
                                          widget.players!.id,
                                        );

                                    if (response.success!) {
                                      Get.back();
                                      SnackbarUtils.showSuccess(
                                        response.message!,
                                      );
                                      controllers.fetchGetTeamData();
                                    } else {
                                      SnackbarUtils.showErrorr(
                                        response.message!,
                                      );
                                    }
                                  }
                                },
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
          ),
        ],
      ),
    );
  }
}

GetPlayer convertTeamPlayerToGetPlayer(TeamPlayer player) {
  return GetPlayer(
    id: player.id,
    teamId: player.teamId,
    firstName: player.firstName,
    lastName: player.lastName,
    jerseyNumber: player.jerseyNumber,
    email: player.email,
    // stats: Stats( // Convert PlayerStats to Stats manually
    //   matches: player.stats.matches,
    //   runs: player.stats.runs,
    //   wickets: player.stats.wickets,
    //   // Add more fields if Stats has additional ones
    // ),
    // team: TeamP( // Convert TeamInfo to TeamP manually
    //   id: player.team.id,
    //   name: player.team.name,
    //   // Add more fields as per your TeamP model
    // ),
  );
}
