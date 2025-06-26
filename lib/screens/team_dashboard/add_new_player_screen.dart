// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
// import 'package:get/get.dart';
// import '../../Base/controller/lineupController.dart';
// import '../../Base/model/positioned.dart';
// import '../../constants/widgets/text_fields/primary_text_field.dart';
// import '../../routes/routes_path.dart';

// class AddNewPlayerScreen extends StatefulWidget {
//   const AddNewPlayerScreen({super.key});

//   @override
//   State<AddNewPlayerScreen> createState() => _AddNewPlayerScreenState();
// }

// class _AddNewPlayerScreenState extends State<AddNewPlayerScreen> {
//   final LineupController controller = Get.put(LineupController());
//   // FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchTeamsPositioned();
//       controller.getGamePlayer();
//     });

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // _focusNode.requestFocus();
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     return DashboardScaffold(
//       onTab: () {
//         controller.playersOut.value = [];
//         Get.toNamed(RoutesPath.teamDashboardScreen);
//       },
//       userImage: 'assets/images/dummy_image.png',
//       userName: 'Test User',
//       body: LineupWidget(),
//       customContent: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "",
//                   // 'Team'.toUpperCase(),
//                   style: descriptiveStyle.copyWith(
//                     fontSize: 48.sp,
//                     color: Colors.white, // Full white
//                   ),
//                 ),
//                 SizedBox(height: 4.05.h),
//                 Text(
//                   "",
//                   // 'Eagles'.toUpperCase(),
//                   style: bannerMainLabelStyle.copyWith(
//                     fontSize: 100.45.sp,
//                     color: Colors.white, // Full white
//                   ),
//                 ),
//               ],
//             ),
//             // Image.asset('assets/images/vs.png', height: 150.h, width: 150.w),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "",
//                   // 'Team'.toUpperCase(),
//                   style: descriptiveStyle.copyWith(
//                     fontSize: 48.sp,
//                     color: Colors.white, // Full white
//                   ),
//                 ),
//                 SizedBox(height: 4.05.h),
//                 Text(
//                   "",
//                   // 'Tiger'.toUpperCase(),
//                   style: bannerMainLabelStyle.copyWith(
//                     fontSize: 100.45.sp,
//                     color: Colors.white, // Full white
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// PlayerStat? sates;

// class LineupWidget extends StatefulWidget {
//   const LineupWidget({super.key});

//   @override
//   State<LineupWidget> createState() => _LineupWidgetState();
// }

// class _LineupWidgetState extends State<LineupWidget> {
//   final LineupController controller = Get.find<LineupController>();

//  late List<List<FocusNode>> lineupFocusNodes;

// late List<List<TextEditingController>> lineupControllers;

// int _playerCount = 0;

// int _inningCount = 0;
// /// Initializes or re-initializes the 2D lists of FocusNodes and
// /// TextEditingControllers based on the current number of players and innings.
// ///
// /// This method is called in `initState` and whenever `controller.gameData` changes,
// /// ensuring that the focus management structures are always in sync with the
// /// dynamically loaded lineup data.
// void _initializeFocusNodesAndControllers() {
//   // Only proceed if gameData and its players/innings are available.
//   // This prevents errors if data hasn't loaded yet.
//   if (controller.gameData.value.players != null &&
//       controller.gameData.value.innings != null) {

//     final newPlayerCount = controller.gameData.value.players!.length;
//     final newInningCount = controller.gameData.value.innings!;

//     // Only re-initialize if the number of players or innings has changed.
//     // This avoids unnecessary re-creations and disposes of existing resources.
//     if (newPlayerCount != _playerCount || newInningCount != _inningCount) {
//       // Dispose old nodes/controllers to prevent memory leaks before creating new ones.
//       _disposeFocusNodesAndControllers();

//       // Update the stored counts to reflect the new dimensions.
//       _playerCount = newPlayerCount;
//       _inningCount = newInningCount;

//       // Initialize 2D lists of FocusNodes and TextEditingControllers.
//       // `List.generate` creates the rows, and nested `List.generate` creates columns.
//       lineupFocusNodes = List.generate(
//         _playerCount,
//         (_) => List.generate(_inningCount, (_) => FocusNode()),
//       );
//       lineupControllers = List.generate(
//         _playerCount,
//         (playerIndex) => List.generate(
//           _inningCount,
//           (inningIndex) => TextEditingController(
//             // Initialize each controller with existing data from autoFillData.
//             // The inning key is '${inningIndex + 1}' (e.g., '1', '2', '3').
//             text: controller.autoFillData.value?.lineupp?[playerIndex]
//                 .innings['${inningIndex + 1}'] ?? '',
//           ),
//         ),
//       );

//       // Request focus for the very first field ([0][0]) after initialization.
//       // `WidgetsBinding.instance.addPostFrameCallback` ensures this runs
//       // after the widget tree has been fully built and rendered, preventing errors.
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (lineupFocusNodes.isNotEmpty && lineupFocusNodes[0].isNotEmpty) {
//           FocusScope.of(context).requestFocus(lineupFocusNodes[0][0]);
//         }
//       });

//       print('Focus Nodes and Controllers initialized: $_playerCount players, $_inningCount innings');
//     }
//   }
// }

// /// Disposes of all created FocusNodes and TextEditingControllers to prevent memory leaks.
// ///
// /// This helper is called by `dispose` and `_initializeFocusNodesAndControllers`
// /// when the widget is being removed or re-initialized.
// void _disposeFocusNodesAndControllers() {
//   // Ensure the widget is still mounted and the lists have been initialized
//   // before attempting to dispose (important for `late` variables).
//   if (mounted && lineupFocusNodes.isNotEmpty && lineupControllers.isNotEmpty) {
//     for (var rowNodes in lineupFocusNodes) {
//       for (var node in rowNodes) {
//         node.dispose();
//       }
//     }
//     for (var rowControllers in lineupControllers) {
//       for (var ctrl in rowControllers) {
//         ctrl.dispose();
//       }
//     }
//   }
// }
// @override
// void initState() {
//   super.initState();
//   // This is crucial: Use GetX's `ever` listener to react when `gameData` changes
//   // and is populated, which often happens asynchronously after `initState`.
//   // It ensures focus nodes and controllers are dynamically created when data is ready.
//   ever(controller.gameData, (_) {
//     _initializeFocusNodesAndControllers();
//   });

//   // Also call it once in case gameData is already available on initial build
//   _initializeFocusNodesAndControllers();
// }

// @override
// void dispose() {
//   // Call helper to dispose all created FocusNodes and TextEditingControllers
//   // to prevent memory leaks when the widget is removed from the tree.
//   _disposeFocusNodesAndControllers();
//   super.dispose();
// }

// void _handleKey(RawKeyEvent event, int currentRow, int currentCol) {
//   if (event is RawKeyDownEvent) { // Only process key down events
//     int newRow = currentRow;
//     int newCol = currentCol;

//     bool handled = false; // Flag to indicate if this event was handled by our logic

//     switch (event.logicalKey.keyLabel) {
//       case 'Arrow Up':
//         // Move up: decrease row, keep column. Clamp to prevent going out of bounds.
//         newRow = (currentRow - 1).clamp(0, _playerCount - 1);
//         newCol = currentCol;
//         handled = true;
//         break;
//       case 'Arrow Down':
//         // Move down: increase row, keep column. Clamp to prevent going out of bounds.
//         newRow = (currentRow + 1).clamp(0, _playerCount - 1);
//         newCol = currentCol;
//         handled = true;
//         break;
//       case 'Arrow Left':
//         // Move left: decrease column, keep row. Clamp to prevent going out of bounds.
//         newCol = (currentCol - 1).clamp(0, _inningCount - 1);
//         newRow = currentRow;
//         handled = true;
//         break;
//       case 'Arrow Right':
//         // Move right: increase column, keep row. Clamp to prevent going out of bounds.
//         newCol = (currentCol + 1).clamp(0, _inningCount - 1);
//         newRow = currentRow;
//         handled = true;
//         break;
//       case 'Enter': // Optional: Handle Enter key to move to the next field
//       case 'Numpad Enter':
//         if (currentCol < _inningCount - 1) {
//           // If not at the end of the current row, move to the next column
//           newCol = currentCol + 1;
//         } else if (currentRow < _playerCount - 1) {
//           // If at the end of the current row but not the last row, move to the first column of the next row
//           newRow = currentRow + 1;
//           newCol = 0;
//         } else {
//           // If at the very last field, you might want to unfocus or trigger a submit action for the whole form.
//           // For now, we'll just stop handling if it's the last field.
//           // FocusScope.of(context).unfocus(); // Uncomment to unfocus on last field Enter
//         }
//         handled = true;
//         break;
//       case 'Tab': // Let default Tab key behavior handle this
//         // We explicitly return here so the default tab navigation works
//         return;
//     }

//     // If our logic handled the key press, request focus for the new position
//     if (handled) {
//       // Extra safety check to ensure the calculated new position is valid
//       if (newRow >= 0 && newRow < _playerCount &&
//           newCol >= 0 && newCol < _inningCount) {
//         FocusScope.of(context).requestFocus(lineupFocusNodes[newRow][newCol]);
//       }
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       // ✅ Add vertical scroll
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           _buildPositionChips(),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final isWideScreen = constraints.maxWidth > 900;
//               return isWideScreen
//                   ? _buildWideScreenLayout()
//                   : _buildNarrowScreenLayout();
//             },
//           ),
//           const SizedBox(height: 24),
//           _buildActionButtons(context),
//           const SizedBox(height: 24),
//           _buildOutSection(), // 🔁 NO fixed height here
//         ],
//       ),
//     );
//   }

//   Widget _buildPositionChips() {
//     final LineupController controller = Get.find<LineupController>();

//     return Obx(
//       () =>
//           controller.teamPositioned.isEmpty
//               ? SizedBox()
//               : Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children:
//                     controller.teamPositioned.map((position) {
//                       final bool isOut = position!.name == "OUT" ? true : false;
//                       // final bool isOut = position['label']!.contains('OUT');
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 8,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isOut ? const Color(0xFFF01414) : Colors.white,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           "${position.display_name!} = ${position.name}",
//                           style: TextStyle(
//                             color: isOut ? Colors.white : Colors.black,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//               ),
//     );
//   }

//   Widget _buildWideScreenLayout() {
//     final LineupController controller = Get.find<LineupController>();
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left Table (Main lineup)
//             Expanded(
//               flex: 3,
//               child: Obx(
//                 () =>
//                     controller.isLoading.value
//                         ? _buildMainLineupTable()
//                         // ? SizedBox()
//                         : SizedBox(),
//               ),
//             ),

//             const SizedBox(width: 16),

//             // Right Table (Playing time and position)
//             Expanded(flex: 1, child: _buildStatsTable()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildNarrowScreenLayout() {
//     return Column(
//       children: [
//         _buildMainLineupTable(),
//         const SizedBox(height: 16),
//         _buildStatsTable(),
//         // _buildOutSection(),
//       ],
//     );
//   }

//   Widget _buildMainLineupTable() {
//     final LineupController controller = Get.find<LineupController>();

//     int i = 1;

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(8),
//       child: Column(
//         children: [
//           // Header row
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Obx(
//               () => Container(
//                 width: 1400,
//                 color: Colors.white,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 16,
//                   ),
//                   color: Colors.grey[200],
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 60,
//                         child: Text(
//                           'Lineup',
//                           style: TextStyle(
//                             color: const Color(0xFF8B3A3A),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 140,
//                         child: Text(
//                           'Player Name',
//                           style: TextStyle(
//                             color: const Color(0xFF8B3A3A),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 40,
//                         child: Text(
//                           '#      ',
//                           style: TextStyle(
//                             color: const Color(0xFF8B3A3A),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 45),
//                       Row(
//                         children: List.generate(
//                           controller.gameData.value.innings!,
//                           (i) => SizedBox(
//                             width: 75,
//                             child: Text(
//                               '${i + 1}',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: const Color(0xFF8B3A3A),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // SizedBox(height: 5),

//           // Table rows
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Obx(
//               () =>
//                   controller.gameData.value.players!.isNotEmpty
//                       ? Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             alignment: Alignment.bottomLeft,
//                             width: 1400,
//                             color: Colors.white,
//                             child:
//                                 controller.gameData.isNull
//                                     ? SizedBox()
//                                     : controller.gameData.value.players == null
//                                     ? SizedBox()
//                                     : Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: List.generate(
//                                         controller
//                                             .gameData
//                                             .value
//                                             .players!
//                                             .length,
//                                         (index) {
//                                           if (controller.playersOut.contains(
//                                             controller
//                                                 .gameData
//                                                 .value
//                                                 .players![index],
//                                           )) {
//                                             return SizedBox();
//                                           } else {
//                                             return Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                     vertical: 0,
//                                                     horizontal: 0,
//                                                   ),
//                                               decoration: BoxDecoration(
//                                                 border: Border(
//                                                   bottom: BorderSide(
//                                                     color: Colors.grey.shade200,
//                                                   ),
//                                                 ),
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   SizedBox(
//                                                     width: 60,
//                                                     child: Text(
//                                                       '${index + 1}',
//                                                       // '${i++}',
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                         color: const Color(
//                                                           0xFF8B3A3A,
//                                                         ),
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 140,
//                                                     child: Text(
//                                                       "${controller.gameData.value.players![index].firstName!} ${controller.gameData.value.players![index].lastName}",
//                                                       style: const TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 14,
//                                                       ),
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 40,
//                                                     child: Text(
//                                                       controller
//                                                           .gameData
//                                                           .value
//                                                           .players![index]
//                                                           .jerseyNumber
//                                                           .toString(),
//                                                     ),
//                                                   ),

//                                                   // Status chip
//                                                   InkWell(
//                                                     onTap: () {
//                                                       final player =
//                                                           controller
//                                                               .gameData
//                                                               .value
//                                                               .players?[index];
//                                                       final exists =
//                                                           controller
//                                                               .playersOut
//                                                               .any(
//                                                                 (p) =>
//                                                                     p.id ==
//                                                                     player!.id,
//                                                               ) ??
//                                                           false;

//                                                       if (!exists) {
//                                                         controller
//                                                             .playersOut
//                                                             .add(player!);
//                                                         // 2. Remove from players list

//                                                         controller
//                                                             .autoFillData
//                                                             .value!
//                                                             .lineupp![index]
//                                                             .isOut = true;

//                                                         controller.playersOut
//                                                             .refresh();
//                                                         controller.gameData
//                                                             .refresh();
//                                                       } else {}

//                                                       controller.playersOut
//                                                           .refresh();

//                                                       i = 1;

//                                                       // setState(() {
//                                                       //
//                                                       // });
//                                                       // controller.gameData.refresh();
//                                                     },

//                                                     child: SizedBox(
//                                                       width: 70,
//                                                       child: Container(
//                                                         padding:
//                                                             const EdgeInsets.symmetric(
//                                                               horizontal: 8,
//                                                               vertical: 4,
//                                                             ),
//                                                         decoration: BoxDecoration(
//                                                           color: const Color(
//                                                             0xFFA33838,
//                                                           ),
//                                                           borderRadius:
//                                                               BorderRadius.circular(
//                                                                 4,
//                                                               ),
//                                                         ),
//                                                         child: const Text(
//                                                           'Out',
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 12,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     // child: SizedBox(),
//                                                   ),

//                                                   controller.isAuto.value
//                                                       ? Center(
//                                                         // alignment: Alignment.bottomLeft,
//                                                         child: Text("helo"),
//                                                       )
//                                                       : Obx(
//                                                         () =>
//                                                             controller
//                                                                         .autoFillData
//                                                                         .value ==
//                                                                     null
//                                                                 ? Column(
//                                                                   children: [],
//                                                                 )
//                                                                 : Column(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: List.generate(1, (
//                                                                     i,
//                                                                   ) {
//                                                                     final valuesList =
//                                                                         controller
//                                                                             .autoFillData
//                                                                             .value!
//                                                                             .lineupp![index]
//                                                                             .innings
//                                                                             .keys;

//                                                                     return Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .start,
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .start,
//                                                                       children:
//                                                                           valuesList.map((
//                                                                             inningNumber,
//                                                                           ) {
//                                                                             bool
//                                                                             isLable =
//                                                                                 false;
//                                                                             TextEditingController
//                                                                             textEditingController =
//                                                                                 TextEditingController();
//                                                                             return RawKeyboardListener(
//                                                                               focusNode: FocusNode(
//     skipTraversal: true, // Don't include this listener in tab order
//     canRequestFocus: false, // Prevents it from being focused directly
//   ),
//   onKey:  (event) => _handleKey(event, index, inningNumber),

//                                                                               child: Focus( // This `Focus` widget makes the `LineupTextField` focusable.
//                                                                                   // Assign the specific FocusNode for this cell from our 2D array.
//                                                                                   focusNode: lineupFocusNodes[index][inningNumber],
//                                                                                   onFocusChange: (hasFocus) {
//                                                                                     if (!hasFocus) {
//                                                                                       // Your existing onFocusChange logic
//                                                                                       yourFunction(index); // This seems to be `yourFunction(index)`
//                                                                                       // Re-evaluate label status or trigger autofill when focus is lost
//                                                                                       // Ensure you're using the correct controller's text for this check
//                                                                                       String currentText = lineupControllers[index][inningNumber].text.trim().toUpperCase();
//                                                                                       filterPositionsByNamePrefix(controller.teamPositioned, controller.enerLable.value).then((result) {
//                                                                                         if (result != "") {
//                                                                                            // If autofocus on blur, ensure it only happens if field is empty or user wants it
//                                                                                            // Your current logic here might overwrite user input.
//                                                                                            // Consider: if (lineupControllers[playerIndex][inningColIndex].text.isEmpty) { ... }
//                                                                                            // For now, I'll keep your existing logic for the focus change side-effect,
//                                                                                            // but be aware it might not be the desired user experience.
//                                                                                           lineupControllers[index][inningNumber].text = result;
//                                                                                           controller.addFixedAssignment(
//                                                                                             controller.gameData.value.players![index].id.toString(),
//                                                                                             '${index + 1}', // Use actual inning number as key
//                                                                                             result,
//                                                                                           );
//                                                                                           controller.autoFillData.refresh(); // Refresh data model
//                                                                                         }
//                                                                                       });
//                                                                                     }
//                                                                                   },
//                                                                                 child: Container(
//                                                                                   padding: const EdgeInsets.all(
//                                                                                     8,
//                                                                                   ),
//                                                                                   color:
//                                                                                       Colors.white,
//                                                                                   child: LineupTextField(
//                                                                                     positions:
//                                                                                         controller.teamPositioned,
//                                                                                     // controller: TextEditingController(
//                                                                                     //   text:
//                                                                                     //       controller.autoFillData.value!.lineupp![index].innings[inningNumber],
//                                                                                     // ),
//                                                                                     controller: lineupControllers[index][inningNumber],
//                                                                                     // textEditingController,
//                                                                                     isLable: filterPositionsByNameMatch(
//                                                                                       controller.teamPositioned,
//                                                                                       textEditingController.text,
//                                                                                     ),
                                                                              
//                                                                                     onChanged: (
//                                                                                       val,
//                                                                                     ) {
//                                                                                       val =
//                                                                                           val.trim().toUpperCase();
//                                                                                       controller.enerLable.value = val;
//                                                                                     },
//                                                                                     onFieldSubmitted: (
//                                                                                       val,
//                                                                                     ) async {
//                                                                                       val =
//                                                                                           val.trim().toUpperCase(); // Normalize for consistent matching
                                                                              
//                                                                                       // Allow OUT always
//                                                                                       if (val ==
//                                                                                           "OUT") {
//                                                                                         controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
//                                                                                             "OUT";
//                                                                                         controller.autoFillData.refresh();
                                                                              
//                                                                                         // return;
//                                                                                         // controller.againCalculateStatsandTopPositions();
//                                                                                         controller.recalculatePlayerStats(
//                                                                                           index,
//                                                                                         );
//                                                                                       } else {
//                                                                                         final allLineups =
//                                                                                             controller.autoFillData.value?.lineupp ??
//                                                                                             [];
//                                                                                         final inningValues =
//                                                                                             allLineups
//                                                                                                 .asMap()
//                                                                                                 .entries
//                                                                                                 .where(
//                                                                                                   (
//                                                                                                     e,
//                                                                                                   ) =>
//                                                                                                       e.key !=
//                                                                                                       index,
//                                                                                                 ) // Exclude current row
//                                                                                                 .map(
//                                                                                                   (
//                                                                                                     e,
//                                                                                                   ) =>
//                                                                                                       e.value.innings[inningNumber]?.trim().toUpperCase(),
//                                                                                                 )
//                                                                                                 .toList();
                                                                              
//                                                                                         // ✅ Check for duplicate (excluding empty and OUT)
//                                                                                         if (inningValues.contains(
//                                                                                           val,
//                                                                                         )) {
//                                                                                           showDialog(
//                                                                                             context:
//                                                                                                 context,
//                                                                                             builder:
//                                                                                                 (
//                                                                                                   _,
//                                                                                                 ) => AlertDialog(
//                                                                                                   title: const Text(
//                                                                                                     "Duplicate Position",
//                                                                                                   ),
//                                                                                                   content: const Text(
//                                                                                                     "This position is already used in this inning (column). Duplicate values are not allowed.",
//                                                                                                   ),
//                                                                                                   actions: [
//                                                                                                     TextButton(
//                                                                                                       onPressed: () {
//                                                                                                         Navigator.pop(
//                                                                                                           context,
//                                                                                                         );
//                                                                                                         textEditingController.clear();
//                                                                                                       },
//                                                                                                       child: const Text(
//                                                                                                         "OK",
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                   ],
//                                                                                                 ),
//                                                                                           );
//                                                                                           return;
//                                                                                         }
//                                                                                       }
//                                                                                             if (inningNumber < _inningCount - 1) {
//             FocusScope.of(context).requestFocus(lineupFocusNodes[index][inningNumber + 1]);
//           } else if (index < _playerCount - 1) {
//             FocusScope.of(context).requestFocus(lineupFocusNodes[index + 1][0]);
//           } else {
//             // Optional: If last field, unfocus or move to a general submit button
//             // FocusScope.of(context).unfocus();
//           }
//                                                                                       // ✅ Get all values in current inning column
                                                                              
//                                                                                       // ✅ Save entered value
//                                                                                       controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
//                                                                                           val;
//                                                                                       controller.autoFillData.refresh();
                                                                              
//                                                                                       // Optional auto-fill from team positions
//                                                                                       String result = await filterPositionsByNamePrefix(
//                                                                                         controller.teamPositioned,
//                                                                                         controller.enerLable.value,
//                                                                                       );
                                                                              
//                                                                                       if (result !=
//                                                                                           "") {
//                                                                                         controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
//                                                                                             result;
//                                                                                         controller.autoFillData.refresh();
//                                                                                         textEditingController.text = result;
//                                                                                         controller.addFixedAssignment(
//                                                                                           controller.gameData.value.players![index].id.toString(),
//                                                                                           '$inningNumber',
//                                                                                           result,
//                                                                                         );
//                                                                                       }
//                                                                                     },
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             );
//                                                                           }).toList(),
//                                                                     );
//                                                                   }),
//                                                                 ),
//                                                       ),
//                                                 ],
//                                               ),
//                                             );
//                                           }
//                                         },
//                                       ),
//                                     ),
//                           ),
//                         ],
//                       )
//                       : SizedBox(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //
//   Future<String> filterPositionsByNamePrefix(
//     List<Position?> positions,
//     String query,
//   ) async {
//     final result =
//         positions.where((position) {
//           final name = position!.name?.toLowerCase() ?? '';
//           return name.startsWith(query.toLowerCase());
//         }).toList();

//     return result.isNotEmpty ? result.first!.name ?? "" : "";
//   }

//   void yourFunction(int index) {
//     // Your custom logic here
//   }

//   Widget _buildStatsTable() {
//     // Mock data for playing time and positions

//     final LineupController controller = Get.find<LineupController>();
//     // controller.statsList.clear();
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(8),
//       child: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             // padding: const EdgeInsets.symmetric(horizontal: 16),
//             color: Colors.grey[200],
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Playing time %',
//                     style: TextStyle(
//                       color: const Color(0xFF8B3A3A),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Top Position',
//                     style: TextStyle(
//                       color: const Color(0xFF8B3A3A),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(height: 5),
//           // Rows
//           Container(
//             color: Colors.white,
//             child: Obx(
//               () =>
//                   controller.statsList.isEmpty
//                       ? SizedBox()
//                       : Column(
//                         children: List.generate(
//                           controller.statsList.length,
//                           (index) => Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 12.7,
//                               horizontal: 16,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(color: Colors.grey.shade200),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   controller.statsList[index].playingTimePercent
//                                       .toString(),
//                                   // stats[index]['time']!,
//                                   style: const TextStyle(fontSize: 14),
//                                 ),
//                                 Text(
//                                   controller.statsList[index].topPosition
//                                       .toString(),
//                                   // stats[index]['position']!,
//                                   style: const TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // For narrow screens, stack buttons vertically
//         if (constraints.maxWidth < 600) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildAutocompleteButton(),
//               const SizedBox(height: 12),
//               _buildSubmitButton(context),
//             ],
//           );
//         }

//         // For wider screens, place buttons side by side
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             _buildAutocompleteButton(),
//             const SizedBox(width: 16),
//             _buildSubmitButton(context),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildAutocompleteButton() {
//     final LineupController controller = Get.find<LineupController>();
//     return SizedBox(
//       height: 48,
//       width: 220,
//       child: ElevatedButton(
//         onPressed: () {
//           controller.autoFillLinupUsingPlayesId();
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2A3648),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         child: const Text('Autocomplete Lineup'),
//       ),
//     );
//   }

//   Widget _buildSubmitButton(BuildContext context) {
//     final LineupController controller = Get.find<LineupController>();
//     return SizedBox(
//       height: 48,
//       width: 220,
//       child: ElevatedButton(
//         onPressed: () {
//           controller.submmitLineupDataPlayesId();
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2B4582),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         child: const Text(' Submit Lineup'),
//       ),
//     );
//   }

//   Widget _buildOutSection() {
//     int i = 1;

//     final LineupController controller = Get.find<LineupController>();

//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 1050,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               'OUT',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFF2B4582),
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               width: 1050,

//               color: Colors.white,
//               child: Obx(
//                 () =>
//                     controller.playersOut.isEmpty
//                         ? SizedBox()
//                         : Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children:
//                               controller.playersOut
//                                   .map(
//                                     (player) => Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 12,
//                                         horizontal: 16,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             color: Colors.grey.shade200,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           SizedBox(
//                                             width: 40,
//                                             child: Text(
//                                               '${i++}',
//                                               style: TextStyle(
//                                                 color: const Color(0xFF8B3A3A),
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             // child: Text(player!.id.toString()),
//                                           ),
//                                           Expanded(
//                                             flex: 2,
//                                             child: Text(
//                                               player.fullName!.toString(),
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 36,
//                                             width: 80,
//                                             child: ElevatedButton(
//                                               onPressed: () {
//                                                 i = 1;
//                                                 controller.playersOut.value
//                                                     .remove(player);
//                                                 final indexInLineup = controller
//                                                     .autoFillData
//                                                     .value!
//                                                     .lineupp!
//                                                     .indexWhere(
//                                                       (p) =>
//                                                           p.playerId ==
//                                                           player.id,
//                                                     );
//                                                 if (indexInLineup != -1) {
//                                                   controller
//                                                       .autoFillData
//                                                       .value!
//                                                       .lineupp![indexInLineup]
//                                                       .isOut = false;
//                                                 }
//                                                 controller.playersOut.refresh();
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: const Color(
//                                                   0xFF2A3648,
//                                                 ),
//                                                 foregroundColor: Colors.white,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(4),
//                                                 ),
//                                               ),
//                                               child: const Text('Add'),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 16),

//                                           // OUT status indicators - showing only OUT
//                                           Expanded(
//                                             flex: 3,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: List.generate(
//                                                 6,
//                                                 (i) => Container(
//                                                   padding:
//                                                       const EdgeInsets.symmetric(
//                                                         horizontal: 8,
//                                                         vertical: 4,
//                                                       ),
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     border: Border.all(
//                                                       color:
//                                                           Colors.grey.shade300,
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           2,
//                                                         ),
//                                                   ),
//                                                   child: const Text(
//                                                     'OUT',
//                                                     style: TextStyle(
//                                                       fontSize: 10,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: Color(0xFF1E4D92),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                   .toList(),
//                         ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class PlayerStat {
//   final List<int> percentage;
//   final String position;

//   PlayerStat({required this.percentage, required this.position});

//   // Parse from Map<String, dynamic>
//   factory PlayerStat.fromMap(Map<String, dynamic> map) {
//     return PlayerStat(
//       percentage: List<int>.from(map['percentage']),
//       position: map['position'] ?? '',
//     );
//   }

//   // Convert to Map<String, dynamic>
//   Map<String, dynamic> toMap() {
//     return {'percentage': percentage, 'position': position};
//   }
// }

