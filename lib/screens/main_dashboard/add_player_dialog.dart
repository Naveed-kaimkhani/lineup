import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/text_fields/primary_text_field.dart';
import 'package:gaming_web_app/screens/main_dashboard/setFavouritPosition.dart';
import 'package:gaming_web_app/screens/main_dashboard/set_favored_position_dialog.dart';
import 'package:get/get.dart';
import '../../Base/controller/globleController.dart';
import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/teamController.dart';


class AddPlayerDialog extends StatelessWidget {
  AddPlayerDialog({super.key});
  final TeamController controller = Get.find<TeamController>();
  final NewTeamController newTeamController = Get.find<NewTeamController>();
  // These controllers manage the text inputs for each field
  // TextEditingController keeps track of what the user types


  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView allows the content to scroll if it's too big for the screen
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          controller.getPlayer.refresh();
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 600;
      return

        Column(
        children: [
          // Add some spacing at the top (16 height units)
          SizedBox(height: 16.h),

          // Dialog title - converted to uppercase for emphasis
          Text(
            'Add Player'.toUpperCase(),
            style: tableContentHeader.copyWith(
              color: AppColors.primaryColor,
              fontSize: 20,
            ),
          ),

          // More vertical spacing (40 height units)
          // SizedBox(height:25),

          // First row of input fields (Country, Last Name, Jersey Number)
          Row(
            children: [
              // Country input field - takes 1/3 of the row width
              Expanded(
                child: PrimaryTextField(
                  controller: newTeamController.playerCountryController,
                  label: 'First Name',
                  hintText: 'Mick',  // Example text shown in empty field
                ),
              ),

              // Horizontal spacing between fields
              SizedBox(width: 10),

              // Last Name input field - takes 1/3 of the row width
              Expanded(
                child: PrimaryTextField(
                  controller:  newTeamController.playerLastNameController,
                  label: 'Last Name',
                  hintText: 'Johnathan',  // Example text shown in empty field
                ),
              ),

              // Horizontal spacing between fields
              SizedBox(width: 10),

              // Jersey Number input field - takes 1/3 of the row width
              Expanded(
                child: PrimaryTextField(
                  controller:  newTeamController.playerJerseyNumberController,
                  label: 'Jersey Number',
                  hintText: '89',  // Example text shown in empty field
                ),
              ),
            ],
          ),

          // Second row of input fields (Email, Phone) and Add button
          Row(
            children: [
              // Email input field - takes 1/3 of the row width
              Expanded(
                // flex: 2,
                child: PrimaryTextField(
                  controller:  newTeamController.playerEmailController,
                  label: 'Email (Optional)',
                  hintText: '',  // Example text shown in empty field
                ),
              ),

              // Horizontal spacing between fields
              SizedBox(width: 10.w),

              // Phone input field - takes 1/3 of the row width
              Expanded(
                // width: 200,
                child:  PrimaryTextField(
                controller:  newTeamController.playerPhoneController,
                label: 'Phone (Optional)',
                hintText: '',  // Example text shown in empty field
              ),),


              // Horizontal spacing between fields
              SizedBox(width:20),
             Expanded(
                 // flex: 2,
                 child:  PrimaryButton(
               // width: MediaQuery.of(context).size.width,
               // When button is tapped, show a dialog to select player position
               onTap: () async {
                 newTeamController.addPlayer(context);

               },
               title: '  Add Player  ',  // Button text
               backgroundColor: AppColors.descriptiveTextColor,  // Button color
             )),
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

          SizedBox(width:20),
          // Display the list of existing players
          PlayerListWidget(),

          // Add spacing at the bottom (20 pixels)
          // SizedBox(height: 20,)
        ],
      );



      },
    ));
  }
}

// This widget displays the list of existing players
// It shows each player's ID, name, and a remove button
class PlayerListWidget extends StatelessWidget {
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
      elevation: 0,
      color: Colors.white,
      // margin: EdgeInsets.all(16),  // Space around the card
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  // Rounded corners
      child: Obx((){
        controller.getPlayer.refresh();
          return


          Container(
          padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12, // Black border color
            width: 1.0,           // Border width
          ),
        ),
        child:

            Column(children: [
              Text(
                'Team Players'.toUpperCase() +
                    (controller.getPlayer.isEmpty
                        ? ''
                        : ' (${controller.getPlayer.length})'),
                style: tableContentHeader.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 25,
                ),
              ),
              ListView.separated(
                // padding: EdgeInsets.all(16),  // Space inside the card
                shrinkWrap: true,  // Make the list only as tall as its content
                itemCount: controller.getPlayer.length,  // Number of items to display
                // Function to build dividers between items
                separatorBuilder: (_, __) => Divider(),  // Simple line divider
                // Function to build each player item
                itemBuilder: (context, index) {
                  final player = controller.getPlayer[index];
                  // Create a row with player info and remove button
                  return InkWell(
                    onTap: (){
                      // showSetFavoredPositionDialog(context,player.id);
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: true,  // Allow closing by tapping outside
                      //   builder: (_) => SetFavoredPositionDialog(),  // Dialog content
                      // );
                      // Get the current player from the list

                    },

                    child:
                    Column(children: [


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Space items at opposite ends
                        children: [
                          // Player ID and name display
                          Text(
                            '# ${player!.jerseyNumber!}        ${player.firstName} ${player.lastName}',  // Format: #89 Mick Johnathan
                            style: TextStyle(fontSize: 12),
                          ),
                          // Remove button with red background and icon
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,  // Dark red background
                              shape: StadiumBorder(),  // Fully rounded sides (pill shape)
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical:0),  // Button padding
                            ),
                            icon: Icon(Icons.close, size: 14, color: Colors.white),  // X icon
                            label: Text('Remove', style: TextStyle(color: Colors.white)),  // Button text
                            onPressed: () {
                              final globleController = Get.put(GlobleController());
                              globleController.playesDelete(player.id);
                              // This is where you would add code to remove the player
                              // Currently empty - would need implementation
                            },
                          ),
                        ],
                      ),
                      // Divider(color: Colors.grey.shade300),
                    ],)

                    ,);
                },
              )

            ],)


         );}),
    );
  }
}



 showSetFavoredPositionDialog(BuildContext context, int playerId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => SetFavoredPositionDialog(),
  );
}
