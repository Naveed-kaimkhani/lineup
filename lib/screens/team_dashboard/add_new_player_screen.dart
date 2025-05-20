import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/routes/routes_path.dart';
import 'package:gaming_web_app/screens/team_dashboard/print_out_alert_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/lineupController.dart';

class AddNewPlayerScreen extends StatefulWidget {
  const AddNewPlayerScreen({super.key});

  @override
  State<AddNewPlayerScreen> createState() => _AddNewPlayerScreenState();
}

class _AddNewPlayerScreenState extends State<AddNewPlayerScreen> {
  final LineupController controller = Get.put(LineupController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTeamsPositioned();
      controller.getGamePlayer();
    });

  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      body: LineupWidget(),
      customContent: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Team'.toUpperCase(),
                  style: descriptiveStyle.copyWith(
                    fontSize: 48.sp,
                    color: Colors.white, // Full white
                  ),
                ),
                SizedBox(height: 4.05.h),
                Text(
                  'Eagles'.toUpperCase(),
                  style: bannerMainLabelStyle.copyWith(
                    fontSize: 100.45.sp,
                    color: Colors.white, // Full white
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/vs.png', height: 150.h, width: 150.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Team'.toUpperCase(),
                  style: descriptiveStyle.copyWith(
                    fontSize: 48.sp,
                    color: Colors.white, // Full white
                  ),
                ),
                SizedBox(height: 4.05.h),
                Text(
                  'Tiger'.toUpperCase(),
                  style: bannerMainLabelStyle.copyWith(
                    fontSize: 100.45.sp,
                    color: Colors.white, // Full white
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LineupWidget extends StatelessWidget {
  LineupWidget({Key? key}) : super(key: key);
  final LineupController controller = Get.find<LineupController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateAndButtons(),
          const SizedBox(height: 16),
          _buildPositionChips(),
          const SizedBox(height: 16),
          Obx(()=>
          (controller.gameData.value.isNull ||
                  controller.gameData.value.players == null)
              ? SizedBox()
              : Column(
                children: [
                  // Main lineup tables
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isWideScreen = constraints.maxWidth > 900;
                      return isWideScreen
                          ? _buildWideScreenLayout()
                          : _buildNarrowScreenLayout();
                    },
                  ),

                  const SizedBox(height: 24),

                  // Action buttons
                  _buildActionButtons(context),

                  const SizedBox(height: 24),

                  // OUT section
                  /// out player
                  // _buildOutSection(),
                ],
              ),
          )],
      ),
    );
  }

  Widget _buildDateAndButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'APRIL 03 2025',
          style: TextStyle(
            color: const Color(0xFF2B4582),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA33838),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
              ),
              child: const Text('Previous Game'),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B4582),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
              ),
              child: const Text('Add New Game'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPositionChips() {
    final LineupController controller = Get.find<LineupController>();
    final List<Map<String, String>> positions = [
      {'label': 'Pitcher = P', 'color': 'white'},
      {'label': 'Catcher = C', 'color': 'white'},
      {'label': '1st Base = 1B', 'color': 'white'},
      {'label': '2nd Base = 2B', 'color': 'white'},
      {'label': '3rd Base = 3B', 'color': 'white'},
      {'label': 'Short Stop = SS', 'color': 'white'},
      {'label': 'Left Field = LF', 'color': 'white'},
      {'label': 'Right Field = RF', 'color': 'white'},
      {'label': 'Center Field = CF', 'color': 'white'},
      {'label': 'Bench = OUT', 'color': 'red'},
    ];

    return Obx(
      () =>
          controller.teamPositioned.isEmpty
              ? SizedBox()
              : Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    controller.teamPositioned.map((position) {
                      final bool isOut = position!.name == "OUT" ? true : false;
                      // final bool isOut = position['label']!.contains('OUT');
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isOut ? const Color(0xFFF01414) : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${position.display_name!} = ${position.name}",
                          style: TextStyle(
                            color: isOut ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
              ),
    );
  }

  Widget _buildWideScreenLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Table (Main lineup)
        Expanded(flex: 3, child: _buildMainLineupTable()),

        const SizedBox(width: 16),

        // Right Table (Playing time and position)
        Expanded(flex: 1, child: _buildStatsTable()),
      ],
    );
  }

  Widget _buildNarrowScreenLayout() {
    return Column(
      children: [
        _buildMainLineupTable(),
        const SizedBox(height: 16),
        _buildStatsTable(),
      ],
    );
  }

  Widget _buildMainLineupTable() {
    final LineupController controller = Get.find<LineupController>();
    // Mock player data
    final players = [
      {
        'number': '01',
        'name': 'Mick Johnathan',
        'jersey': '89',
        'position': 'CF',
      },
      {
        'number': '02',
        'name': 'Sophia Martinez',
        'jersey': '90',
        'position': 'C',
      },
      {
        'number': '03',
        'name': 'Liam Johnson',
        'jersey': '91',
        'position': '3B',
      },
      {'number': '04', 'name': 'Emma Brown', 'jersey': '92', 'position': 'SS'},
      {'number': '05', 'name': 'Noah Davis', 'jersey': '93', 'position': 'CF'},
      {
        'number': '06',
        'name': 'Olivia Wilson',
        'jersey': '94',
        'position': 'RF',
      },
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.grey[200],
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    'Lineup',
                    style: TextStyle(
                      color: const Color(0xFF8B3A3A),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Text(
                    'Player Name',
                    style: TextStyle(
                      color: const Color(0xFF8B3A3A),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    '#',
                    style: TextStyle(
                      color: const Color(0xFF8B3A3A),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 70),
                Expanded(
                  child: Row(
                    children: List.generate(
                      controller.gameData.value.innings!,
                      (i) => Expanded(
                        child: Text(
                          '${i + 1}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF8B3A3A),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),

          // Table rows
          Container(
            color: Colors.white,
            child:
                controller.gameData.isNull
                    ? SizedBox()
                    : controller.gameData.value.players == null
                    ? SizedBox()
                    : Column(
                      children: List.generate(
                        controller.gameData.value.players!.length!,
                        // players.length,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60,
                                child: Text(
                                  controller
                                      .gameData
                                      .value
                                      .players![index]
                                      .jerseyNumber!,
                                ),
                              ),
                              SizedBox(
                                width: 140,
                                child: Text(
                                  controller
                                      .gameData
                                      .value
                                      .players![index]
                                      .firstName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // SizedBox(width: 40, child: Text(players[index]['jersey']!)),

                              // Status chip
                              SizedBox(
                                width: 70,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFA33838),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Out',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),

                              // Position chips for innings
                              // Expanded(
                              //   child: Obx(() {
                              //     print("Obx rebuilt"); // This prints when UI rebuilds
                              //
                              //     final inningsCount = controller.gameData.value.innings ?? 0;
                              //     final lineup = controller.fetchAutoFillLineups.value.lineup;
                              //
                              //     return Row(
                              //       children: List.generate(
                              //         inningsCount,
                              //             (i) {
                              //           final inningKey = (i + 1).toString();
                              //
                              //           final inningsMap = (lineup != null && lineup.isNotEmpty) ? lineup[0].innings : null;
                              //
                              //           final position = (inningsMap != null &&
                              //               inningsMap.containsKey(inningKey) &&
                              //               inningsMap[inningKey] != null)
                              //               ? inningsMap[inningKey].toString()
                              //               : '--';
                              //
                              //           return Expanded(
                              //             child: Container(
                              //               margin: const EdgeInsets.symmetric(horizontal: 4),
                              //               alignment: Alignment.center,
                              //               child: Text(
                              //                 position,
                              //                 style: TextStyle(
                              //                   color: Colors.grey[700],
                              //                   fontSize: 14,
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //         },
                              //       ),
                              //     );
                              //   }),
                              // ),


                              Expanded(
                                child: Obx(() {
                                  final inningsCount = controller.gameData.value.innings ?? 0;
                                  final lineup = controller.fetchAutoFillLineups.value.lineup;

                                  if (lineup == null || lineup.isEmpty) {
                                    // No lineup data, show empty innings with '--'
                                    return Row(
                                      children: List.generate(
                                        inningsCount,
                                            (_) => Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 4),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '--',
                                              style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  // Use first player for example
                                  final inningsMap = lineup[0].innings ?? {};

                                  return Row(
                                    children: List.generate(inningsCount, (i) {
                                      final inningKey = i + 1; // integer key instead of string
                                      final position = inningsMap.containsKey(inningKey) && inningsMap[inningKey] != null
                                          ? inningsMap[inningKey].toString()
                                          : '--';

                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 4),
                                          alignment: Alignment.center,
                                          child: Text(
                                            position,
                                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                }),
                              ),



                              // Expanded(
                              //   child: Row(
                              //     children: List.generate(
                              //       controller.gameData.value.innings!,
                              //       (i) => Expanded(
                              //         child: Container(
                              //           margin: const EdgeInsets.symmetric(
                              //             horizontal: 4,
                              //           ),
                              //           alignment: Alignment.center,
                              //           child: Text(
                              //           "${controller.fetchAutoFillLineups.value.lineup![i].innings}"
                              //
                              //             '--',
                              //             style: TextStyle(
                              //               color: Colors.grey[700],
                              //               fontSize: 14,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
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

  Widget _buildStatsTable() {
    // Mock data for playing time and positions
    final stats = [
      {'time': '45%', 'position': 'CF'},
      {'time': '75%', 'position': 'C'},
      {'time': '45%', 'position': '3B'},
      {'time': '45%', 'position': 'SS'},
      {'time': '45%', 'position': 'CF'},
      {'time': '45%', 'position': 'RF'},
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Playing time %',
                    style: TextStyle(
                      color: const Color(0xFF8B3A3A),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Top Position',
                    style: TextStyle(
                      color: const Color(0xFF8B3A3A),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 5),
          // Rows
          Container(
            color: Colors.white,
            child: Column(
              children: List.generate(
                stats.length,
                (index) => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        stats[index]['time']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        stats[index]['position']!,
                        style: const TextStyle(fontSize: 14),
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

  Widget _buildActionButtons(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // For narrow screens, stack buttons vertically
        if (constraints.maxWidth < 600) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAutocompleteButton(),
              const SizedBox(height: 12),
              _buildSubmitButton(context),
            ],
          );
        }

        // For wider screens, place buttons side by side
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildAutocompleteButton(),
            const SizedBox(width: 16),
            _buildSubmitButton(context),
          ],
        );
      },
    );
  }

  Widget _buildAutocompleteButton() {
    final LineupController controller = Get.find<LineupController>();
    return SizedBox(
      height: 48,
      width: 220,
      child: ElevatedButton(
        onPressed: () {
          controller.autoFillLinupUsingPlayesId();


        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2A3648),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text('Autocomplete Lineup'),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final LineupController controller = Get.find<LineupController>();
    return SizedBox(
      height: 48,
      width: 220,
      child: ElevatedButton(
        onPressed: () {
          controller.submmitLineupDataPlayesId();

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2B4582),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text('Submit Lineup'),
      ),
    );
  }

  Widget _buildOutSection() {
    // Mock bench players
    final benchPlayers = [
      {'number': '01', 'name': 'Mick Johnathan'},
      {'number': '02', 'name': 'Sophie Turner'},
      {'number': '03', 'name': 'Lucas Grey'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1050,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'OUT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2B4582),
            ),
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 1050,

            color: Colors.white,
            child: Column(
              children:
                  benchPlayers
                      .map(
                        (player) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: Text(player['number']!),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  player['name']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 36,
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2A3648),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: const Text('Add'),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // OUT status indicators - showing only OUT
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    6,
                                    (i) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: const Text(
                                        'OUT',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1E4D92),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class PrintOutAlertDialog extends StatelessWidget {
  const PrintOutAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Print Lineup'),
      content: const Text('Would you like to print the current lineup?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2B4582),
          ),
          child: const Text('Print'),
        ),
      ],
    );
  }
}

// Additional dialog class for print functionality
// class LineupWidget extends StatelessWidget {
//   const LineupWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFFF8F8F8),
//       padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Top Role Labels
//           // Wrap(
//           //   spacing: 12,
//           //   runSpacing: 8,
//           //   children: [
//           //     for (final role in [
//           //       'Pitcher = P',
//           //       'Catcher = C',
//           //       '1st Base = 1B',
//           //       '2nd Base = 2B',
//           //       '3rd Base = 3B',
//           //       'Short Stop = SS',
//           //       'Left Field = LF',
//           //       'Right Field = RF',
//           //       'Center Field = CF',
//           //       'Bench = OUT',
//           //     ])
//           //       Chip(
//           //         label: Text(
//           //           role,
//           //           style: const TextStyle(fontWeight: FontWeight.bold),
//           //         ),
//           //         backgroundColor:
//           //             role.contains('OUT') ? Colors.red : Colors.grey.shade300,
//           //         labelStyle: TextStyle(
//           //           color: role.contains('OUT') ? Colors.white : Colors.black,
//           //         ),
//           //       ),
//           //   ],
//           // ),
//
//           const SizedBox(height: 24),
//
//           /// Lineup Section with Playing Time and Top Position in Separate Table
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Left Table
//               Expanded(
//                 flex: 3,
//                 child: Column(
//                   children: [
//                     /// Header
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 12,
//                       ),
//                       color: Colors.grey.shade200,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 50,
//                             child: Text(
//                               'Lineup',
//                               style: tableLabel.copyWith(
//                                 color: AppColors.primaryColor,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 120,
//                             child: Text(
//                               'Player Name',
//                               style: tableLabel.copyWith(
//                                 color: AppColors.primaryColor,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 120,
//                             child: Text(
//                               '#',
//                               style: tableLabel.copyWith(
//                                 color: AppColors.primaryColor,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           for (int i = 1; i <= 6; i++)
//                             SizedBox(
//                               width: 110,
//                               child: Text(
//                                 '$i',
//                                 style: tableLabel.copyWith(
//                                   color: AppColors.primaryColor,
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//
//                     /// Rows
//                     Container(
//                       color: Colors.white,
//                       child: Column(
//                         children: List.generate(6, (index) {
//                           return Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8,
//                               horizontal: 12,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(color: Colors.grey.shade300),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 50,
//                                   child: Text('0${index + 1}'),
//                                 ),
//                                 const SizedBox(
//                                   width: 120,
//                                   child: Text(
//                                     'Player Name',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 24, child: Text('89')),
//                                 // Chip(
//                                 //   label: Text('Out'),
//                                 //   backgroundColor: Color(0xFF822B2B),
//                                 //   labelStyle: TextStyle(
//                                 //     color: Colors.white,
//                                 //     fontSize: 12,
//                                 //   ),
//                                 // ),
//                                 SizedBox(
//   width: 60, // approximate width based on Chip size
//   height: 30, // approximate height based on Chip size
// ),
//
//                                 for (int i = 0; i < 6; i++)
//                                   SizedBox(
//                                     width: 110,
//                                     child: Chip(
//                                       label: Text(
//                                         '--',
//                                         style: descriptionStyle.copyWith(
//                                           color: AppColors.secondaryColor,
//                                           fontSize: 14.sp,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(width: 16),
//
//               /// Right Table
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 8,
//                         horizontal: 8,
//                       ),
//                       color: Colors.grey.shade200,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Playing time %',
//                             style: tableLabel.copyWith(
//                               color: AppColors.primaryColor,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                             'Top Position',
//                             style: tableLabel.copyWith(
//                               color: AppColors.primaryColor,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       color: Colors.white,
//                       child: Column(
//                         children: List.generate(6, (index) {
//                           return Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8,
//                               horizontal: 12,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(color: Colors.grey.shade300),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Chip(
//                                   label: Text(
//                                     '45%',
//                                     style: descriptionStyle.copyWith(
//                                       color: AppColors.secondaryColor,
//                                       fontSize: 14.sp,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 22,),
//                                 Chip(
//                                   label: Text(
//                                     'CF',
//                                     style: descriptionStyle.copyWith(
//                                       color: AppColors.secondaryColor,
//                                       fontSize: 14.sp,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           // const SizedBox(height: 24),
//
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.end,
//           //   children: [
//           //     PrimaryButton(
//           //       onTap: () {},
//           //       backgroundColor: const Color(0xFF1C1C1C),
//
//           //       title: 'Autocomplete Lineup',
//           //       width: 277.w,
//           //     ),
//           //     const SizedBox(width: 16),
//           //     PrimaryButton(
//           //       onTap:
//           //           () =>
//           //               Navigator.pushNamed(context, RoutesPath.savePdfScreen),
//           //       backgroundColor: const Color(0xFF0B3D91),
//           //       width: 277.w,
//
//           //       title: 'Submit Lineup',
//           //     ),
//           //   ],
//           // ),
//
//           const SizedBox(height: 24),
//   Wrap(
//             spacing: 12,
//             runSpacing: 8,
//             children: [
//               for (final role in [
//                 'Pitcher = P',
//                 'Catcher = C',
//                 '1st Base = 1B',
//                 '2nd Base = 2B',
//                 '3rd Base = 3B',
//                 'Short Stop = SS',
//                 'Left Field = LF',
//                 'Right Field = RF',
//                 'Center Field = CF',
//                 'Bench = OUT',
//               ])
//                 Chip(
//                   label: Text(
//                     role,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   backgroundColor:
//                       role.contains('OUT') ? Colors.red : Colors.grey.shade300,
//                   labelStyle: TextStyle(
//                     color: role.contains('OUT') ? Colors.white : Colors.black,
//                   ),
//                 ),
//             ],
//           ),
//
//           const SizedBox(height: 32),
//
//           /// OUT Section
//           Chip(
//             label: Text(
//               'OUT',
//               style: descriptionStyle.copyWith(
//                 color: AppColors.primaryColor,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           Container(
//             color: Colors.white,
//             child: Column(
//               children: List.generate(3, (index) {
//                 return Container(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 8,
//                     horizontal: 12,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(color: Colors.grey.shade300),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       SizedBox(width: 50, child: Text('0${index + 1}')),
//                       Text(
//                         'Player Name',
//                         style: tableContentHeader.copyWith(
//                           color: AppColors.secondaryColor,
//                           fontSize: 16.sp,
//                         ),
//                       ),
//                       SizedBox(width: 20.w),
//                       SizedBox(
//                         height: 50.h,
//                         // child: PrimaryButton(
//                         //   onTap: () {},
//                         //   textStyle: descriptionStyle.copyWith(
//                         //     color: Colors.white,
//                         //   ),
//                         //   backgroundColor: AppColors.descriptiveTextColor,
//                         //   title: 'Add',
//                         //   width: 60.w,
//                         // ),
//                       child: SizedBox.shrink(),
//                       ),
//                       const SizedBox(width: 12),
//                       for (int i = 0; i < 6; i++)
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 50.w),
//                           child: Chip(
//                             label: Text('OUT'),
//                             labelStyle: descriptionStyle.copyWith(
//                               color: AppColors.secondaryColor,
//                               fontSize: 14.sp,
//                             ),
//                             backgroundColor: Color(0xFFE7E7E7),
//                           ),
//                         ),
//
//
//                     ],
//                   ),
//                 );
//               }),
//             ),
//           ),
//            const SizedBox(height: 24),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               PrimaryButton(
//                 onTap: () {},
//                 backgroundColor: const Color(0xFF1C1C1C),
//
//                 title: 'Autocomplete Lineup',
//                 width: 277.w,
//               ),
//               const SizedBox(width: 16),
//               PrimaryButton(
//                 // onTap:
//                 //     () =>
//                 //         Navigator.pushNamed(context, RoutesPath.savePdfScreen),
//                 onTap: () async{
//                      await showDialog(
//                     context: context,
//                     barrierDismissible: true,
//                     builder: (_) => const PrintOutAlertDialog(),
//                   );
//
//                 },
//                 backgroundColor: const Color(0xFF0B3D91),
//                 width: 277.w,
//
//                 title: 'Submit Lineup',
//               ),
//             ],
//           ),
//
//         ],
//       ),
//     );
//   }
// }
