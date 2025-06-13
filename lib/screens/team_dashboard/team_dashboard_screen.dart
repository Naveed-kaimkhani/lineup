import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/team_dashboard/add_new_game_dialog.dart';
import 'package:gaming_web_app/screens/team_dashboard/edit_player_dialog.dart';
import 'package:gaming_web_app/screens/team_dashboard/previous_game_dialog.dart';
import 'package:get/get.dart';
import '../../Base/componant/alertDialog.dart';
import '../../Base/controller/getTeamData.dart';
import '../../Base/controller/globleController.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/routes_path.dart';
import 'addPlayes.dart';

final GlobleController globleController = Get.put(GlobleController());

// Main TeamDashboardScreen widget - entry point for the team dashboard
// Uses DashboardScaffold for consistent layout and navigation
class TeamDashboardScreen extends StatelessWidget {
  TeamDashboardScreen({super.key});
  // final TeamController controller = Get.put<TeamController>(TeamController());
  final TeamController controller = Get.find<TeamController>();

  @override
  Widget build(BuildContext context) {
    // controller.getData();
    // DashboardScaffold provides the overall structure including header, sidebar, etc.
    return
      Obx(()=>
      DashboardScaffold(
        onTab: (){
          Get.toNamed(RoutesPath.mainDashboardScreen);
        },
        isShowBanner:false,
        bg:false,
      userImage: 'assets/images/dummy_image.png', // Profile image for the user
      userName: 'Test User', // Display name for the user
      title:controller.selectTeam.value ?? 'Game-Ready', // Main title displayed in the header
      subtitle: 'Lineup', // Subtitle displayed in the header
      body: _TeamDashboardBody(), // Main content of the dashboard
    ));
  }
}

// Private widget that contains the main content of the team dashboard
// Separated from the main class for better organization
class _TeamDashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView allows scrolling if content is larger than screen
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 89.w,
        ), // Horizontal padding for entire content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the left
          children: [
            // Space at the top of the screen
            SizedBox(height: 30.h),

            // Summary section with action buttons (Add Player, Previous Game, Add Game)
            _buildSummaryAndActions(context),

            // Vertical spacing between sections
            SizedBox(height: 20.h),

            // Players data table/list section
            _buildPlayersTable(context),

            // Space at the bottom of the screen
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // This method builds the summary statistics header and action buttons
  // It's responsive - changes layout based on screen width
  Widget _buildSummaryAndActions(BuildContext context) {
    // LayoutBuilder provides the available space constraints
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth; // Get available width

        // For narrow screens (mobile layout)
        if (width < 600) {
          // Stack the title and buttons vertically
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Statistics title
              Text(
                'SUMMARY STATISTICS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E40AF), // Blue color
                ),
              ),
              SizedBox(height: 15.h),

              // "Add New Player" button - navigates to player creation screen
              _buildActionButton(
                'Add New Player',
                Color(0xFF475569), // Slate gray color
                () {
                  /// for commant
                  //     Navigator.pushNamed(context, RoutesPath.addNewPlayerScreen);
                  showAddTeamPlayerDialog();
                  // Navigator.pushNamed(context, RoutesPath.addNewPlayerScreen);
                },
              ),
              SizedBox(height: 10.h),

              // "Previous Game" button - shows dialog with past games
              _buildActionButton(
                'Games',
                Color(0xFF9B1C1C), // Dark red color
                () async {
                  // Show a dialog with list of previous games
                  await showDialog(
                    context: context,
                    builder:
                        (context) => PreviousGameDialog(
                          items: [
                            // Sample past game data
                            {'name': 'At Tigers', 'date': 'April 03, 2025'},
                            {'name': 'Vs Commanders', 'date': 'April 06, 2025'},
                            {'name': 'At Wildcats', 'date': 'April 10, 2025'},
                          ],
                        ),
                  );
                },
              ),
              SizedBox(height: 10.h),

              // "Add New Game" button - shows dialog to create a game
              _buildActionButton(
                'Add New Game',
                Color(0xFF1E40AF), // Blue color
                () async {
                  // Show dialog to add a new game
                  await showDialog(
                    context: context,
                    barrierDismissible:
                        true, // Allow closing by tapping outside
                    builder: (_) => const AddNewGameDialog(),
                  );
                },
              ),
            ],
          );
        } else {
          // For wider screens (tablet & desktop layout)
          // Place title on left, buttons in a row on right
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Summary Statistics title
              Text(
                'SUMMARY STATISTICS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E40AF), // Blue color
                ),
              ),

              // Row of action buttons
              Row(
                children: [
                  // "Add New Player" button with fixed width
                  _buildActionButton(
                    'Add New Player',
                    Color(0xFF475569), // Slate gray color
                    () {
                      showAddTeamPlayerDialog();
                      // Navigator.pushNamed(context, RoutesPath.addNewPlayerScreen);
                      // showAddTeamPlayerDialog();
                      // Navigator.pushNamed(context, RoutesPath.addNewPlayerScreen);
                    },
                    width: 180.w,
                  ),
                  SizedBox(width: 15.w),

                  // "Previous Game" button with fixed width
                  _buildActionButton(
                    'Previous Games',
                    Color(0xFF9B1C1C), // Dark red color
                    () async {
                      // Show dialog with list of previous games
                      await showDialog(
                        context: context,
                        builder:
                            (context) => PreviousGameDialog(
                              items: [
                                // Sample past game data
                                {'name': 'At Tigers', 'date': 'April 03, 2025'},
                                {
                                  'name': 'Vs Commanders',
                                  'date': 'April 06, 2025',
                                },
                                {
                                  'name': 'At Wildcats',
                                  'date': 'April 10, 2025',
                                },
                              ],
                            ),
                      );
                    },
                    width: 180.w,
                  ),
                  SizedBox(width: 15.w),

                  // "Add New Game" button with fixed width
                  _buildActionButton(
                    'Add New Game',
                    Color(0xFF1E40AF), // Blue color
                    () async {
                      // Show dialog to add a new game
                      await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => const AddNewGameDialog(),
                      );
                    },
                    width: 180.w,
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  // Helper method to create a standardized action button
  // Used to maintain consistent button styling throughout the dashboard
  Widget _buildActionButton(
    String title,
    Color color,
    VoidCallback onTap, {
    double? width,
  }) {
    return PrimaryButton(
      // If width is provided use it, otherwise take full width available
      width: width ?? double.infinity,
      // Function to call when button is tapped
      onTap: onTap,
      // Rounded corners
      radius: 20.r,
      // Text styling for button label
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      // Button text
      title: title,
      // Button background color
      backgroundColor: color,
    );
  }

  // This method builds the players table/list section
  // Uses responsive design to show either a table or cards based on screen width
  Widget _buildPlayersTable(BuildContext context) {
    final TeamController controller = Get.find<TeamController>();
    // final TeamController controller = Get.put(TeamController());
    controller.fetchGetTeamData();
    // final TeamController controller = Get.find<TeamController>();
    // Sample player data - in a real app would come from a database or API
    final List<Map<String, dynamic>> players = [
      {
        'number': '89',
        'name': 'Mick Johnathan',
        'inningsPlayed': '50%',
        'totalInnings': '25',
        'inf': '25%',
        'position': 'P',
        'average': '8.5',
      },
      {
        'number': '92',
        'name': 'Sara Williams',
        'inningsPlayed': '55%',
        'totalInnings': '75',
        'inf': '30%',
        'position': 'LF',
        'average': '9.0',
      },
      {
        'number': '85',
        'name': 'John Smith',
        'inningsPlayed': '45%',
        'totalInnings': '78',
        'inf': '20%',
        'position': 'RF',
        'average': '7.0',
      },
      {
        'number': '95',
        'name': 'Emily Davis',
        'inningsPlayed': '60%',
        'totalInnings': '75',
        'inf': '35%',
        'position': 'SS',
        'average': '10.0',
      },
      {
        'number': '92',
        'name': 'Ella Fitzgerald',
        'inningsPlayed': '55%',
        'totalInnings': '60',
        'inf': '30%',
        'position': 'CF',
        'average': '9.0',
      },
      {
        'number': '76',
        'name': 'John Doe',
        'inningsPlayed': '45%',
        'totalInnings': '70',
        'inf': '20%',
        'position': '1B',
        'average': '7.5',
      },
      {
        'number': '85',
        'name': 'Sarah Connor',
        'inningsPlayed': '52%',
        'totalInnings': '70',
        'inf': '28%',
        'position': '2B',
        'average': '8.0',
      },
      {
        'number': '91',
        'name': 'Leonardo DiCaprio',
        'inningsPlayed': '60%',
        'totalInnings': '75',
        'inf': '40%',
        'position': '3B',
        'average': '9.5',
      },
      {
        'number': '88',
        'name': 'Jane Smith',
        'inningsPlayed': '48%',
        'totalInnings': '55',
        'inf': '35%',
        'position': 'LF',
        'average': '8.2',
      },
    ];

    // LayoutBuilder to create responsive UI based on available width
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // For narrow screens, show cards list layout
        if (width < 600) {
          return _MobilePlayerList();
        } else {
          // For wider screens, show table layout
          return _ResponsivePlayerTable();
          // return _ResponsivePlayerTable(players: players);
        }
      },
    );
  }
}

// Widget for displaying players as a list of cards on mobile devices
// Each player gets their own card with all details stacked vertically
class _MobilePlayerList extends StatelessWidget {
  final TeamController controller = Get.find<TeamController>();
  _MobilePlayerList();
  @override
  Widget build(BuildContext context) {
    // Create a column of player cards
    return Obx(
      () => Column(
        children:
            controller.teamData.value!.players!.map((player) {
              // Each player card is a container with shadow and rounded corners
              return Container(
                margin: EdgeInsets.only(bottom: 10.h), // Space between cards
                padding: EdgeInsets.all(10), // Inner padding
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.circular(8.r), // Rounded corners
                  boxShadow: [
                    // Subtle shadow for elevation effect
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Player details as rows of label/value pairs
                   Expanded(child:  _buildPlayerInfoRow('Player #', player.jerseyNumber),),
                    _buildPlayerInfoRow('Name', player.firstName),
                    _buildPlayerInfoRow(
                      'Innings Played',
                      player.stats.pctInningsPlayed.toString(),
                    ),
                    _buildPlayerInfoRow(
                      'Total Innings',
                      player.stats.totalInningsParticipatedIn.toString(),
                    ),
                    _buildPlayerInfoRow(
                      '% INF',
                      player.stats.pctInfPlayed.toString(),
                    ),
                    _buildPlayerInfoRow(
                      'Position',
                      player.stats.topPosition.toString(),
                    ),
                    _buildPlayerInfoRow(
                      'Average',
                      player.stats.avgBattingLoc.toString(),
                    ),
                    SizedBox(height: 10.h),
                    Row(children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showCustomDialog(
                            context: context,
                            title: 'Delete Player',
                            description:
                            'Are you sure you want to delete This Player?',
                            onOk: () async {
                              await handleDeleteAndRefresh(player.id!);
                            },
                            onCancel: () {
                              print("Cancel pressed");
                            },
                          );
                        },
                        child: Image.asset(
                          'assets/images/delete_icon.png',
                          height: 36.h,
                          width: 40.w,
                        ),
                      ),
                           SizedBox(width: 20,),
                      _buildEditButton(context,player),
                    ],)



                    // Edit and Delete buttons
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,  // Align to right side
                    //   children: [
                    //     _buildEditButton(context),  // Edit button with pencil icon
                    //     SizedBox(width: 10.w),
                    //     // _buildDeleteButton(),  // Delete button with trash icon
                    //   ],
                    // ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  // Your delete and refresh logic
  Future<void> handleDeleteAndRefresh(int playerId) async {
    final globleController = Get.find<GlobleController>();
    final controller = Get.find<TeamController>();

    await globleController.playesDelete(playerId);

    // await controller.fetchGetTeamData();
  }

  // Helper method to create a consistent row with label and value
  Widget _buildPlayerInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Label on left, value on right
        children: [
          // Field label (left side)
          Text(
            label,
            style: tableLabel.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          // Field value (right side)
          Text(
            value,
            style: tableLabel.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }



  // Delete button (currently no action implemented)
  Widget _buildDeleteButton() {
    return InkWell(
      child: Image.asset(
        'assets/images/delete_icon.png', // Trash icon image
        height: 18.h,
        width: 20.w,
      ),
      onTap: () {
        // Delete functionality would be implemented here
      },
    );
  }
}

// Widget for displaying players in a table format for larger screens
// Shows all players in rows with columns for each attribute
class _ResponsivePlayerTable extends StatelessWidget {
  // List of player data to display
  // List<GetPlayer?> players;
  // final List<Map<String, dynamic>> players;

  _ResponsivePlayerTable();
  // final TeamController controller = Get.put(TeamController());
  final TeamController controller = Get.find<TeamController>();
  // final TeamController controller = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    // Container for the entire table with shadow and rounded corners
    return
      // Obx(
      // () =>
          Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), // Rounded corners
          boxShadow: [
            // Subtle shadow for elevation effect
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child:Obx(()=> Column(
          children: [
            // Table Header Row - column titles
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F6), // Light gray background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
              ),
              child: Row(
                children: [
                  // Column headers with flex to control relative widths
                  _buildHeaderCell('#', flex: 1), // Jersey number
                  _buildHeaderCell('Player Names', flex: 3), // Player name
                  _buildHeaderCell(
                    '% innings played',
                    flex: 2,
                  ), // Percentage of innings played
                  _buildHeaderCell(
                    'Total innings',
                    flex: 2,
                  ), // Total innings count
                  _buildHeaderCell('% INF', flex: 1), // Percentage infield
                  _buildHeaderCell(
                    'Favorite Position',
                    flex: 2,
                  ), // Preferred position
                  _buildHeaderCell('Average players', flex: 2), // Player rating

                  _buildHeaderCell('Actions', flex: 1), // Edit/delete buttons
                ],
              ),
            ),

            // Generate a row for each player in the data list
            // The ... (spread operator) adds each row to the column children
            ...controller.teamData.value!.players!
                .map((player) => _buildPlayerRow(context, player))
                .toList(),
          ],
        )),
      );
    // );
  }

  // Helper method to create consistent header cells
  Widget _buildHeaderCell(String text, {required int flex}) {
    return Expanded(
      flex: flex, // Controls relative width of the column
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xff8B3A3A), // Dark red color
          fontWeight: FontWeight.w600, // Semi-bold
          fontSize: 14,
        ),
      ),
    );
  }

  // Helper method to create a row for each player
  Widget _buildPlayerRow(BuildContext context, TeamPlayer players) {
    final TeamController controller = Get.find<TeamController>();
    return Column(
      children: [
        // Row content with player data
        InkWell(
          onTap: (){
            // controller.selectTeam.value=players.firstName!.toString();
          },

            child:Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          color: Colors.white, // White background
          child: Row(
            children: [
              // Player number column
              Expanded(
                flex: 1,
                child: Text(
                  players.jerseyNumber,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // Player name column
              Expanded(
                flex: 3,
                child: Text("${players.firstName} ${players.lastName}", style: TextStyle(fontSize: 14)),
              ),
              // Innings played percentage column
              Expanded(
                flex: 2,
                child: Text(
                  players.stats.pctInningsPlayed.toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // Total innings column
              Expanded(
                flex: 2,
                child: Text(
                  // player['totalInnings'],
                  players.stats.totalInningsParticipatedIn.toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // INF percentage column
              Expanded(
                flex: 1,
                child: Text(
                  // player['inf'],
                  players.stats.pctInfPlayed.toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // Favorite position column
              Expanded(
                flex: 2,
                child: Text(
                  // player['position'],
                  players.stats.topPosition ==""?"- -":players.stats.topPosition,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // Average player rating column
              Expanded(
                flex: 2,
                child: Text(
                  // player['average'],
                  players.stats.avgBattingLoc.toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // Actions column (edit and delete buttons)

              Row(children: [


                InkWell(
                  onTap: () {
                    showCustomDialog(
                      context: context,
                      title: 'Delete Player',
                      description: 'Are you sure you want to delete This Team?',
                      onOk: () {
                        globleController.playesDelete(players.id!);
                      },
                      onCancel: () {
                        print("Cancel pressed");
                      },
                    );
                  },
                  child: Image.asset(
                    'assets/images/delete_icon.png',
                    height: 36.h,
                    width: 40.w,
                  ),
                ),
                _buildEditButton(context,players),
              ],)
              /// action button
              // Expanded(
              //   flex: 2,
              //   child: Row(
              //     children: [
              //       // Edit button
              //       InkWell(
              //         child: Image.asset(
              //           'assets/images/edit_icon.png',  // Pencil icon
              //           height: 18.h,
              //           width: 20.w,
              //         ),
              //         onTap: () {},  // Edit functionality would be implemented here
              //       ),
              //       SizedBox(width: 15.w),
              //       // Delete button
              //       InkWell(
              //         child: Image.asset(
              //           'assets/images/delete_icon.png',  // Trash icon
              //           height: 18.h,
              //           width: 20.w,
              //         ),
              //         onTap: () {},  // Delete functionality would be implemented here
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ) ),

        Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
      ],
    );
  }
}
// Edit button with click handler to show edit dialog
Widget _buildEditButton(BuildContext context,TeamPlayer? players) {
  return InkWell(
    onTap: () async {
      // Show dialog to edit player details
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => EditPlayerDialog(players: players,),
      );
    },
    child:  Image.asset(
        'assets/images/edit_icon.png', // Pencil icon image
        height: 36.h,
        width: 40.w,
      ),


  );
}