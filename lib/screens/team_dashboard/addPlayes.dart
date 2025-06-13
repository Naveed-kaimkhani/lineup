import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/globleController.dart';
import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/widgets/buttons/primary_button.dart';
import '../../constants/widgets/text_fields/primary_text_field.dart';

// final NewTeamController newTeamController = Get.find<NewTeamController>();

void showAddTeamPlayerDialog() {
  // Get.lazyPut<NewTeamController>(() => NewTeamController());

  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      // insetPadding: EdgeInsets.symmetric(
      //   horizontal: Get.width > 900 ? 150 : 20,
      //   vertical: 40,
      // ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = 600;

          if (constraints.maxWidth >= 1200) {
            // Desktop
            maxWidth = 600;
          } else if (constraints.maxWidth >= 800) {
            // Tablet
            maxWidth = 600;
          }

          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                  maxHeight: Get.height * 0.7,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(child: AddPlayerInTeamDialog()),
                ),
              ),
            ),
          );
        },
      ),
    ),
    barrierDismissible: true,
  );
}

class AddPlayerInTeamDialog extends StatelessWidget {
  AddPlayerInTeamDialog({super.key});
  // final TeamController controller = Get.find<TeamController>();
  // final NewTeamController newTeamController = Get.put(NewTeamController(),permanent: true);
  final NewTeamController newTeamController = Get.find<NewTeamController>();

  final TeamController controller = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView allows the content to scroll if it's too big for the screen
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final isMobile = screenWidth < 600;
            return Column(
              children: [
                // Add some spacing at the top (16 height units)
                SizedBox(height: 16.h),

                // Dialog title - converted to uppercase for emphasis
                Row(
                  children: [
                    Text(
                      'Add Player'.toUpperCase(),
                      style: tableContentHeader.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 25,
                      ),
                    ),
                    Spacer(),

                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.cancel, size: 50, color: Colors.red),
                    ),
                  ],
                ),

                // More vertical spacing (40 height units)
                SizedBox(height: 25),

                // First row of input fields (Country, Last Name, Jersey Number)
                Row(
                  children: [
                    // Country input field - takes 1/3 of the row width
                    Expanded(
                      child: PrimaryTextField(
                        controller: newTeamController.playerCountryController,
                        label: 'First Name',
                        hintText: 'Mick', // Example text shown in empty field
                      ),
                    ),

                    // Horizontal spacing between fields
                    SizedBox(width: 10),

                    // Last Name input field - takes 1/3 of the row width
                    Expanded(
                      child: PrimaryTextField(
                        controller: newTeamController.playerLastNameController,
                        label: 'Last Name',
                        hintText:
                            'Johnathan', // Example text shown in empty field
                      ),
                    ),

                    // Horizontal spacing between fields
                    SizedBox(width: 10),

                    // Jersey Number input field - takes 1/3 of the row width
                    Expanded(
                      child: PrimaryTextField(
                        controller:
                            newTeamController.playerJerseyNumberController,
                        label: 'Jersey Number',
                        hintText: '89', // Example text shown in empty field
                      ),
                    ),
                  ],
                ),

                // Second row of input fields (Email, Phone) and Add button
                Row(
                  children: [
                    // Email input field - takes 1/3 of the row width
                    Expanded(
                      child: PrimaryTextField(
                        controller: newTeamController.playerEmailController,
                        label: 'Email (Optional)',
                        hintText: '', // Example text shown in empty field
                      ),
                    ),

                    // Horizontal spacing between fields
                    SizedBox(width: 10.w),

                    // Phone input field - takes 1/3 of the row width
                    Expanded(
                      child: PrimaryTextField(
                        controller: newTeamController.playerPhoneController,
                        label: 'Phone (Optional)',
                        hintText: '', // Example text shown in empty field
                      ),
                    ),

                    // Horizontal spacing between fields
                    SizedBox(width: 20),
                    PrimaryButton(
                      // width: MediaQuery.of(context).size.width,
                      // When button is tapped, show a dialog to select player position
                      onTap: () async {
                        newTeamController.addPlayers(context);
                      },
                      title: '  Add Player  ', // Button text
                      backgroundColor:
                          AppColors.descriptiveTextColor, // Button color
                    ),
                    // Add Player button - takes 1/3 of the row width
                    // Expanded(
                    //   child: PrimaryButton(
                    //     // When button is tapped, show a dialog to select player position
                    //     onTap: () async {
                    //       newTeamController.addPlayer(context);
                    //       // showDialog creates a popup modal window
                    //       // await means it will wait for the dialog to close before continuing
                    //    // test
                    //    //   newTeamController
                    //       // await showDialog(
                    //       //   context: context,
                    //       //   barrierDismissible: true,  // Allow closing by tapping outside
                    //       //   builder: (_) => const SetFavoredPositionDialog(),  // Dialog content
                    //       // );
                    //     },
                    //     title: 'Add Player',  // Button text
                    //     backgroundColor: AppColors.descriptiveTextColor,  // Button color
                    //   ),
                    // ),
                  ],
                ),

                //  PrimaryButton(
                //  width: MediaQuery.of(context).size.width,
                //   // When button is tapped, show a dialog to select player position
                //   onTap: () async {
                //     newTeamController.addPlayer(context);
                //
                //   },
                //   title: 'Add Player',  // Button text
                //   backgroundColor: AppColors.descriptiveTextColor,  // Button color
                // ),
                SizedBox(width: 20),
                // Display the list of existing players
                PlayerListWidget(),

                // Add spacing at the bottom (20 pixels)
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}

// This widget displays the list of existing players
// It shows each player's ID, name, and a remove button
class PlayerListWidget extends StatelessWidget {
  final GlobleController globleController = Get.put(GlobleController());
  final TeamController controller = Get.find<TeamController>();
  // Hard-coded sample data of players
  // In a real app, this would likely come from a database or API
  final List<Map<String, String>> players = [
    {'id': '#89', 'name': 'Mick Johnathan'},
    {'id': '#14', 'name': 'John Anderson'},
    {'id': '#99', 'name': 'Darren Smith'},
  ];

  @override
  Widget build(BuildContext context) {
    // Card creates a material design card with rounded corners and elevation
    return Card(
      // key: GlobalKey(),
      elevation: 0,
      color: Colors.white,
      // margin: EdgeInsets.all(16),  // Space around the card
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  // Rounded corners
      child: Obx(
        () => Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12, // Black border color
              width: 1.0, // Border width
            ),
          ),
          child: ListView.separated(
            // padding: EdgeInsets.all(16),  // Space inside the card
            shrinkWrap: true, // Make the list only as tall as its content
            itemCount:
                controller.getPlayer.length, // Number of items to display
            // Function to build dividers between items
            separatorBuilder: (_, __) => Divider(), // Simple line divider
            // Function to build each player item
            itemBuilder: (context, index) {
              final player = controller.getPlayer[index];
              // Create a row with player info and remove button
              return InkWell(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: true,  // Allow closing by tapping outside
                  //   builder: (_) => SetFavoredPositionDialog(),  // Dialog content
                  // );
                  // Get the current player from the list
                },

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween, // Space items at opposite ends
                      children: [
                        // Player ID and name display
                        Text(
                          '# ${player!.id!}     ${player.firstName}', // Format: #89 Mick Johnathan
                          style: TextStyle(fontSize: 16),
                        ),
                        // Remove button with red background and icon
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red.shade700, // Dark red background
                            shape:
                                StadiumBorder(), // Fully rounded sides (pill shape)
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ), // Button padding
                          ),
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ), // X icon
                          label: Text(
                            'Remove',
                            style: TextStyle(color: Colors.white),
                          ), // Button text
                          onPressed: () {
                            controller.getPlayer.clear();
                            Navigator.pop(context);
                            final globleController = Get.put(
                              GlobleController(),
                            );
                            globleController.playesDelete(player.id);

                            // This is where you would add code to remove the player
                            // Currently empty - would need implementation
                          },
                        ),
                      ],
                    ),
                    // Divider(color: Colors.grey.shade300),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
