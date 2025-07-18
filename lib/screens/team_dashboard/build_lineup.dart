import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/model/lineup/autofillLineup.dart';
import 'package:gaming_web_app/Base/model/lineup/fetchAutoLinup.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import '../../Base/controller/lineupController.dart';
import '../../Base/model/positioned.dart';
import '../../constants/widgets/text_fields/primary_text_field.dart';
import '../../routes/routes_path.dart';

class AddNewPlayerScreenForBuildLineup extends StatefulWidget {
  const AddNewPlayerScreenForBuildLineup({super.key});

  @override
  State<AddNewPlayerScreenForBuildLineup> createState() =>
      _AddNewPlayerScreenForBuildLineupState();
}

class _AddNewPlayerScreenForBuildLineupState
    extends State<AddNewPlayerScreenForBuildLineup> {
  final LineupController controller = Get.put(LineupController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTeamsPositioned();
      controller.getGamePlayer();
      // controller.getLineup(true);
      controller.autoFillData.value = controller.getDummyAutoFillData();

      // controller.playersOut.clear();
    });

    // controller.getLineup();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.getLineup(true);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // Reset Rx values
    controller.autoFillLineups.value = AutoFillLineups(); // Empty object
    controller.autoFillData.value = null; // Set to null
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      onTab: () {
        // controller.playersOut.value = [];
        controller.autoFillLineups.value = AutoFillLineups(); // Empty object
        controller.autoFillData.value = null; // Set to null
        // controller.firstNinePlayers1.clear();
        // controller.playersOut1.clear();
        Get.toNamed(RoutesPath.teamDashboardScreen);
      },
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
                  "",
                  // 'Team'.toUpperCase(),
                  style: descriptiveStyle.copyWith(
                    fontSize: 48.sp,
                    color: Colors.white, // Full white
                  ),
                ),
                SizedBox(height: 4.05.h),
                Text(
                  "",
                  // 'Eagles'.toUpperCase(),
                  style: bannerMainLabelStyle.copyWith(
                    fontSize: 100.45.sp,
                    color: Colors.white, // Full white
                  ),
                ),
              ],
            ),
            // Image.asset('assets/images/vs.png', height: 150.h, width: 150.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "",
                  style: descriptiveStyle.copyWith(
                    fontSize: 48.sp,
                    color: Colors.white, // Full white
                  ),
                ),
                SizedBox(height: 4.05.h),
                Text(
                  "",
                  // 'Tiger'.toUpperCase(),
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

PlayerStat? sates;

class LineupWidget extends StatefulWidget {
  const LineupWidget({super.key});

  @override
  State<LineupWidget> createState() => _LineupWidgetState();
}

class _LineupWidgetState extends State<LineupWidget> {
  final LineupController controller = Get.find<LineupController>();
  RxBool isAutoCompletePressed = false.obs;
  void onAutoCompletePressed() {
    isAutoCompletePressed.value = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // ✅ Add vertical scroll
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildPositionChips(),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 900;
              return isWideScreen
                  ? _buildWideScreenLayout()
                  : _buildNarrowScreenLayout();
            },
          ),
          const SizedBox(height: 24),
          _buildActionButtons(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPositionChips() {
    final LineupController controller = Get.find<LineupController>();

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
    final LineupController controller = Get.find<LineupController>();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Table (Main lineup)
            Expanded(
              flex: 3,
              child: Obx(
                () =>
                    controller.isLoading.value
                        ? _buildMainLineupTable()
                        : SizedBox(),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(flex: 1, child: _buildStatsTable()),
          ],
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout() {
    return Column(
      children: [
        _buildMainLineupTable(),
        const SizedBox(height: 16),
        _buildStatsTable(),
        // _buildOutSection(),
      ],
    );
  }

  KeyEventResult handleArrowKeyNavigation(
    RawKeyEvent event,
    int rowIndex,
    String colKey,
    FocusNode focus,
    TextEditingController editingController,
  ) {
    if (event is! RawKeyDownEvent)
      return KeyEventResult.ignored; // Ignore key-up events

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.backspace) {
      controller.isBackspacePressed.value = true;
      return KeyEventResult.ignored; // Let the TextField handle backspace
    } else {
      controller.isBackspacePressed.value = false;
    }

    // Only handle arrow keys for navigation
    if (key != LogicalKeyboardKey.arrowUp &&
        key != LogicalKeyboardKey.arrowDown &&
        key != LogicalKeyboardKey.arrowLeft &&
        key != LogicalKeyboardKey.arrowRight) {
      return KeyEventResult
          .ignored; // Ignore all other keys (letters, numbers, etc.)
    }

    final rows = controller.focusNodesGrid.keys.toList()..sort();
    final cols = controller.focusNodesGrid[rowIndex]!.keys.toList()..sort();

    int rowIdx = rows.indexOf(rowIndex);
    int colIdx = cols.indexOf(colKey);

    int newRow = rowIdx;
    int newCol = colIdx;

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      newRow = (rowIdx - 1).clamp(0, rows.length - 1);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      newRow = (rowIdx + 1).clamp(0, rows.length - 1);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _moveFocusAndSetCursorAtEnd(focus, editingController);
      newCol = (colIdx - 1).clamp(0, cols.length - 1);
      // _moveFocusAndSetCursorAtEnd(focus, editingController);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      newCol = (colIdx + 1).clamp(0, cols.length - 1);
    }

    // If no movement happened (already at an edge), ignore the event
    if (newRow == rowIdx && newCol == colIdx) {
      return KeyEventResult.ignored;
    }

    final nextRowKey = rows[newRow];
    final nextColKey = cols[newCol];

    final nextFocus = controller.focusNodesGrid[nextRowKey]?[nextColKey];
    final nextController =
        controller.textControllersGrid[nextRowKey]?[nextColKey];

    if (nextFocus != null && nextController != null) {
      FocusScope.of(Get.context!).requestFocus(nextFocus);
      // You can still keep the Future.delayed for robustness, but it's less critical now
      Future.delayed(Duration.zero, () {
        nextController.selection = TextSelection.fromPosition(
          TextPosition(offset: nextController.text.length),
        );
      });

      // ✅ CRITICAL FIX: Tell Flutter we handled this key event!
      return KeyEventResult.handled;
    }

    // If something went wrong, ignore the event.
    return KeyEventResult.ignored;
  }

  void _moveFocusAndSetCursorAtEnd(
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    focusNode.requestFocus();
    // By default, requestFocus() selects all text. To prevent this, we schedule a
    // post-frame callback to manually set the cursor position after the focus change has completed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controller.selection = TextSelection.fromPosition(
      //   TextPosition(offset: controller.text.length),
      // );
      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );
    });
  }

  Widget _buildNavigationChips() {
    final List<Map<String, dynamic>> keyGuides = [
      {'label': 'Shift + ↑', 'action': 'Select Up'},
      {'label': 'Shift + ↓', 'action': 'Select Down'},
      {'label': 'Shift + →', 'action': 'Select Right'},
      {'label': 'Shift + ←', 'action': 'Select Left'},
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          keyGuides.map((guide) {
            final bool isSelect = guide['label'].toString().contains('Shift');
            return Container(
              margin: const EdgeInsets.only(bottom: 6, left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: isSelect ? const Color(0xFF2B4582) : Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${guide['label']} = ${guide['action']}',
                style: TextStyle(
                  color: isSelect ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
    );
  }

  void swapLineupData(int oldIndex, int newIndex) {
    final lineups = controller.autoFillData.value?.lineupp;
    if (lineups == null ||
        oldIndex >= lineups.length ||
        newIndex >= lineups.length)
      return;
    log(oldIndex.toString());
    log(newIndex.toString());
    final temp = lineups[oldIndex];
    lineups[oldIndex] = lineups[newIndex];
    lineups[newIndex] = temp;

    controller.autoFillData.refresh();
  }

  //list from firstNinePlayer
  Widget _buildMainLineupTable() {
    final LineupController controller = Get.find<LineupController>();

    int i = 1;

    double tableWidth =
        60 + 140 + 40 + 70 + (controller.gameData.value.innings! * 79);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          // Header row
          _buildNavigationChips(),
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Container(
                width: tableWidth,
                // width: 1400,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
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
                          '#      ',
                          style: TextStyle(
                            color: const Color(0xFF8B3A3A),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 45),
                      Row(
                        children: List.generate(
                          controller.gameData.value.innings!,

                          // controller.gameData.value.!,
                          (i) => SizedBox(
                            width: 75,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () =>
                  controller.gameData.value.players!.isNotEmpty
                      // controller.gameData.value.playersNotOut!.isNotEmpty
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            // width: 1400,
                            width: tableWidth,
                            color: Colors.white,
                            child:
                                controller.gameData.isNull
                                    ? SizedBox()
                                    : controller.gameData.value.players == null
                                    ? SizedBox()
                                    : ReorderableColumn(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      needsLongPressDraggable:
                                          false, // drag by mouse click
                                      onReorder: (oldIndex, newIndex) {
                                        final player = controller
                                            // .firstNinePlayers1
                                            .gameData
                                            .value
                                            .players!
                                            .removeAt(oldIndex);

                                        controller.gameData.value.players!
                                            .insert(newIndex, player);
                                        if (true)
                                        // if (isAutoCompletePressed.value)
                                        {
                                          // final lineup = controller
                                          //     .autoFillData
                                          //     .value!
                                          //     .lineupp!
                                          //     .removeAt(oldIndex);
                                         

                                          // Now update the state with the modified list
                                          controller
                                              .autoFillData
                                              .value = FetchAutoFillLineups(
                                            lineupp: updatedLineup,
                                            playersInGame:
                                                controller
                                                    .autoFillData
                                                    .value!
                                                    .playersInGame,
                                            fixedAssignments:
                                                controller
                                                    .autoFillData
                                                    .value!
                                                    .fixedAssignments,
                                          );
                                          controller
                                              .autoFillData
                                              .value!
                                              .lineupp!
                                              .insert(newIndex, lineup);
                                          // swapLineupData(oldIndex, newIndex);

                                          final firstIndex = newIndex;
                                          final secondIndex = oldIndex;

                                          // ✅ Recalculate for both affected players
                                          controller.recalculatePlayerStats(
                                            firstIndex,
                                          );
                                          controller.recalculatePlayerStats(
                                            secondIndex,
                                          );

                                          // controller.updateColorsAfterReorder();
                                        }

                                        controller.gameData.refresh();
                                        controller.autoFillData.refresh();
                                        // reorderLineup(oldIndex, newIndex);
                                      },
                                     
                                      children: List.generate(
                                        controller
                                            .gameData
                                            .value
                                            .players!
                                            .length,
                                        (index) {
                                          if (false) {
                                            return SizedBox();
                                          } else {
                                            return Container(
                                              key: ValueKey(
                                                controller
                                                    .gameData
                                                    .value
                                                    .players![index]
                                                    .id,
                                              ), // ✅ <-- this is the fix

                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 0,
                                                  ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                      '${index + 1}',
                                                      // '${i++}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: const Color(
                                                          0xFF8B3A3A,
                                                        ),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 140,
                                                    child: Text(
                                                      // "${controller.firstNinePlayers1[index].firstName} ${controller.firstNinePlayers1[index].lastName}",
                                                      "${controller.gameData.value.players![index].firstName} ${controller.gameData.value.players![index].lastName}",

                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                    child: Text(
                                                      controller
                                                          .gameData
                                                          .value
                                                          .players![index]
                                                          .jerseyNumber
                                                          .toString(),
                                                    ),
                                                  ),

                                                  InkWell(
                                                    onTap: () {
                                                      final player =
                                                          controller
                                                              .gameData
                                                              .value
                                                              .players![index];
                                                      final exists =
                                                          controller.playersOut
                                                              .any(
                                                                (p) =>
                                                                    p.id ==
                                                                    player.id,
                                                              ) ??
                                                          false;
                                                      if (!exists) {
                                                        controller.playersOut
                                                            .add(player);
                                                        // 2. Remove from players list
                                                        controller
                                                            .gameData
                                                            .value
                                                            .players!
                                                            .remove(player);
                                                        controller
                                                            .autoFillData
                                                            .value!
                                                            .lineupp![index]
                                                            .isOut = true;

                                                        controller.playersOut
                                                            .refresh();
                                                        controller.gameData
                                                            .refresh();

                                                        // controller.gameData
                                                        //     .refresh();
                                                      } else {}

                                                      controller.playersOut
                                                          .refresh();

                                                      i = 1;
                                                    },

                                                    child: SizedBox(
                                                      width: 70,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFFA33838,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                4,
                                                              ),
                                                        ),
                                                        child: const Text(
                                                          'Out',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // child: SizedBox(),
                                                  ),

                                                  controller.isAuto.value
                                                      ? Center(
                                                        // alignment: Alignment.bottomLeft,
                                                        child: Text("helo"),
                                                      )
                                                      : Obx(
                                                        () =>
                                                            controller
                                                                        .autoFillData
                                                                        .value ==
                                                                    null
                                                                ? Column(
                                                                  children: [],
                                                                )
                                                                : Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: List.generate(1, (
                                                                    i,
                                                                  ) {
                                                                    final valuesList =
                                                                        controller
                                                                            .autoFillData
                                                                            .value!
                                                                            .lineupp![index]
                                                                            .innings
                                                                            .keys;

                                                                    return Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          valuesList.map((
                                                                            inningNumber,
                                                                          ) {
                                                                            final key =
                                                                                "${index}_$inningNumber"; // ✅ unique key for player-row + inning-column

                                                                            final focusNode =
                                                                                controller.focusNodesGrid.putIfAbsent(
                                                                                      index,
                                                                                      () =>
                                                                                          {},
                                                                                    )[inningNumber.toString()] ??=
                                                                                    FocusNode();
                                                                            final controllerNode =
                                                                                controller.textControllersGrid.putIfAbsent(
                                                                                  index,
                                                                                  () =>
                                                                                      {},
                                                                                )[inningNumber.toString()] ??= controller.getCellController(
                                                                                  rowIndex:
                                                                                      index,
                                                                                  inningNumber:
                                                                                      inningNumber,
                                                                                  initialText:
                                                                                      controller.autoFillData.value!.lineupp![index].innings[inningNumber] ??
                                                                                      '',
                                                                                );

                                                                            bool
                                                                            isLable =
                                                                                false;
                                                                            TextEditingController
                                                                            textEditingController =
                                                                                TextEditingController();

                                                                            return Focus(
                                                                              onFocusChange: (
                                                                                hasFocus,
                                                                              ) async {
                                                                                if (!hasFocus) {
                                                                                  yourFunction(
                                                                                    index,
                                                                                  );
                                                                                  // controller.teamPositioned
                                                                                  String result = await filterPositionsByNamePrefix(
                                                                                    controller.teamPositioned,
                                                                                    controller.enerLable.value,
                                                                                  );

                                                                                  if (result !=
                                                                                      "") {
                                                                                    isLable =
                                                                                        true;

                                                                                    // controller.fixedAssignments!.add({});
                                                                                    controller.addFixedAssignment(
                                                                                      controller.gameData.value.players![index].id.toString(),
                                                                                      '${inningNumber}',
                                                                                      result,
                                                                                    );

                                                                                    // });
                                                                                  }
                                                                                  // The widget lost focus, run your function here
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.all(
                                                                                  8,
                                                                                ),
                                                                                color:
                                                                                    Colors.white,
                                                                                child: RawKeyboardListener(
                                                                                  focusNode: FocusNode(
                                                                                    skipTraversal:
                                                                                        true,
                                                                                  ),
                                                                                  onKey:
                                                                                      (
                                                                                        event,
                                                                                      ) => handleArrowKeyNavigation(
                                                                                        event,
                                                                                        index,

                                                                                        inningNumber.toString(),
                                                                                        focusNode,

                                                                                        TextEditingController(
                                                                                          text:
                                                                                              controller.autoFillData.value!.lineupp![index].innings[inningNumber],
                                                                                        ),
                                                                                        // controller.getCellController(
                                                                                        //   rowIndex:
                                                                                        //       index,
                                                                                        //   inningNumber:
                                                                                        //       inningNumber,
                                                                                        //   initialText:
                                                                                        //       controller.autoFillData.value!.lineupp![index].innings[inningNumber] ??
                                                                                        //       '',
                                                                                        // ),
                                                                                      ),
                                                                                  child: LineupTextField(
                                                                                    textColor:
                                                                                        controller.textColors[key] ??
                                                                                        Colors.black,

                                                                                    // color
                                                                                    positions:
                                                                                        controller.teamPositioned,

                                                                                    // controller: TextEditingController(
                                                                                    //   text:
                                                                                    //       controller.autoFillData.value!.lineupp![index].innings[inningNumber],
                                                                                    // ),
                                                                                    controller: controller.getCellController(
                                                                                      rowIndex:
                                                                                          index,
                                                                                      inningNumber:
                                                                                          inningNumber,
                                                                                      initialText:
                                                                                          controller.autoFillData.value!.lineupp![index].innings[inningNumber] ??
                                                                                          '',
                                                                                    ),
                                                                                    focusNode:
                                                                                        focusNode,

                                                                                    isLable: filterPositionsByNameMatch(
                                                                                      controller.teamPositioned,
                                                                                      textEditingController.text,
                                                                                      // controller
                                                                                      //     .getCellController(
                                                                                      //       rowIndex:
                                                                                      //           index,
                                                                                      //       inningNumber:
                                                                                      //           inningNumber,
                                                                                      //       initialText:
                                                                                      //           controller.autoFillData.value!.lineupp![index].innings[inningNumber] ??
                                                                                      //           '',
                                                                                      //     )
                                                                                      //     .text,
                                                                                    ),

                                                                                    onChanged: (
                                                                                      val,
                                                                                    ) async {
                                                                                      val =
                                                                                          val.trim().toUpperCase();

                                                                                      if (controller.isBackspacePressed.value) {
                                                                                        // Clear lineup data
                                                                                        controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                            '';

                                                                                        // ✅ Remove the fixed assignment
                                                                                        final playerId =
                                                                                            controller.gameData.value.players![index].id.toString();
                                                                                        controller.fixedAssignments?[playerId]?.remove(
                                                                                          '$inningNumber',
                                                                                        );

                                                                                        // controller.autoFillData.refresh();
                                                                                        controller.isBackspacePressed.value = false;
                                                                                        return;
                                                                                      }

                                                                                      // 🔁 If empty, just clear
                                                                                      if (val.isEmpty) {
                                                                                        controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                            '';

                                                                                        controller.autoFillData.refresh();
                                                                                        return;
                                                                                      }

                                                                                      // 🔁 Shortcuts
                                                                                      final shortcuts = {
                                                                                        'L':
                                                                                            'LF',
                                                                                        'P':
                                                                                            'P',
                                                                                        'R':
                                                                                            'RF',
                                                                                        'O':
                                                                                            'OUT',
                                                                                        'S':
                                                                                            'SS',
                                                                                        '1':
                                                                                            '1B',
                                                                                        '2':
                                                                                            '2B',
                                                                                        '3':
                                                                                            '3B',
                                                                                      };

                                                                                      if (val.length ==
                                                                                              1 &&
                                                                                          shortcuts.containsKey(
                                                                                            val,
                                                                                          )) {
                                                                                        final completed =
                                                                                            shortcuts[val]!;
                                                                                        if (controllerNode.text !=
                                                                                            completed) {
                                                                                          controllerNode.text = completed;
                                                                                          controllerNode.selection = TextSelection.fromPosition(
                                                                                            TextPosition(
                                                                                              offset:
                                                                                                  controllerNode.text.length,
                                                                                            ),
                                                                                          );

                                                                                          val =
                                                                                              completed;
                                                                                        }
                                                                                      }

                                                                                      // 🔁 Check for duplicate (ignore if OUT or empty)
                                                                                      final allLineups =
                                                                                          controller.autoFillData.value?.lineupp ??
                                                                                          [];
                                                                                      final inningValues =
                                                                                          allLineups
                                                                                              .asMap()
                                                                                              .entries
                                                                                              .where(
                                                                                                (
                                                                                                  e,
                                                                                                ) =>
                                                                                                    e.key !=
                                                                                                    index,
                                                                                              )
                                                                                              .map(
                                                                                                (
                                                                                                  e,
                                                                                                ) =>
                                                                                                    e.value.innings[inningNumber]?.trim().toUpperCase(),
                                                                                              )
                                                                                              .toList();

                                                                                      controller.updateTextColor(
                                                                                        index:
                                                                                            index,
                                                                                        inningNumber:
                                                                                            inningNumber,
                                                                                        val:
                                                                                            val,
                                                                                      );

                                                                                      // ✅ Save input
                                                                                      controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                          val;
                                                                                      controller.enerLable.value = val;
                                                                                      controller.autoFillData.refresh();

                                                                                      if (val ==
                                                                                          "OUT") {
                                                                                        controller.recalculatePlayerStats(
                                                                                          index,
                                                                                        );
                                                                                        return;
                                                                                      }

                                                                                      // 🔁 Prefix autocomplete using team positions
                                                                                      final result = await filterPositionsByNamePrefix(
                                                                                        controller.teamPositioned,
                                                                                        val,
                                                                                      );

                                                                                      if (result.isNotEmpty &&
                                                                                          result !=
                                                                                              val) {
                                                                                        controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                            result;
                                                                                        controllerNode.text = result;
                                                                                        controllerNode.selection = TextSelection.fromPosition(
                                                                                          TextPosition(
                                                                                            offset:
                                                                                                result.length,
                                                                                          ),
                                                                                        );

                                                                                        // new
                                                                                        if (val.length ==
                                                                                                1 &&
                                                                                            shortcuts.containsKey(
                                                                                              val,
                                                                                            )) {
                                                                                          final completed =
                                                                                              shortcuts[val]!;
                                                                                          if (controllerNode.text !=
                                                                                              completed) {
                                                                                            controllerNode.text = completed;
                                                                                            controllerNode.selection = TextSelection.fromPosition(
                                                                                              TextPosition(
                                                                                                offset:
                                                                                                    completed.length,
                                                                                              ),
                                                                                            );

                                                                                            val =
                                                                                                completed;
                                                                                          }
                                                                                        }

                                                                                        controller.addFixedAssignment(
                                                                                          controller.gameData.value.players![index].id.toString(),
                                                                                          '$inningNumber',
                                                                                          result,
                                                                                        );
                                                                                      }
                                                                                    },
                                                                                    onFieldSubmitted: (
                                                                                      val,
                                                                                    ) async {
                                                                                      val =
                                                                                          val.trim().toUpperCase(); // Normalize for consistent matching

                                                                                      // Allow OUT always
                                                                                      if (val ==
                                                                                          "OUT") {
                                                                                        controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                            "OUT";
                                                                                        controller.autoFillData.refresh();

                                                                                        // return;
                                                                                        // controller.againCalculateStatsandTopPositions();
                                                                                        controller.recalculatePlayerStats(
                                                                                          index,
                                                                                        );
                                                                                      } else {
                                                                                        final allLineups =
                                                                                            controller.autoFillData.value?.lineupp ??
                                                                                            [];
                                                                                        final inningValues =
                                                                                            allLineups
                                                                                                .asMap()
                                                                                                .entries
                                                                                                .where(
                                                                                                  (
                                                                                                    e,
                                                                                                  ) =>
                                                                                                      e.key !=
                                                                                                      index,
                                                                                                ) // Exclude current row
                                                                                                .map(
                                                                                                  (
                                                                                                    e,
                                                                                                  ) =>
                                                                                                      e.value.innings[inningNumber]?.trim().toUpperCase(),
                                                                                                )
                                                                                                .toList();

                                                                                        // ✅ Check for duplicate (excluding empty and OUT)
                                                                                        if (inningValues.contains(
                                                                                          val,
                                                                                        )) {
                                                                                          SnackbarUtils.showErrorr(
                                                                                            "This position $val is already used in this inning (column). Duplicate values are not allowed.",
                                                                                            onOkPressed: () {
                                                                                              controllerNode.clear();
                                                                                              controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                                  '';
                                                                                              controller.autoFillData.refresh();
                                                                                            },
                                                                                          );
                                                                                          return;
                                                                                        }
                                                                                      }
                                                                                      // ✅ Get all values in current inning column

                                                                                      // ✅ Save entered value
                                                                                      controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                          val;
                                                                                      controller.autoFillData.refresh();

                                                                                      // Optional auto-fill from team positions
                                                                                      String result = await filterPositionsByNamePrefix(
                                                                                        controller.teamPositioned,
                                                                                        controller.enerLable.value,
                                                                                      );

                                                                                      if (result !=
                                                                                          "") {
                                                                                        controller.autoFillData.value!.lineupp![index].innings[inningNumber] =
                                                                                            result;
                                                                                        controller.autoFillData.refresh();
                                                                                        // textEditingController.text = result;
                                                                                        controller
                                                                                            .getCellController(
                                                                                              rowIndex:
                                                                                                  index,
                                                                                              inningNumber:
                                                                                                  inningNumber,
                                                                                              initialText:
                                                                                                  controller.autoFillData.value!.lineupp![index].innings[inningNumber] ??
                                                                                                  '',
                                                                                            )
                                                                                            .text = result;
                                                                                        controller.addFixedAssignment(
                                                                                          controller.gameData.value.players![index].id.toString(),
                                                                                          '$inningNumber',
                                                                                          result,
                                                                                        );
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                    );
                                                                  }),
                                                                ),
                                                      ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                          ),
                        ],
                      )
                      : SizedBox(),
            ),
          ),
          SizedBox(height: 40),
          _buildOutSecton(), // 🔁 NO fixed height here
        ],
      ),
    );
  }

  //
  Future<String> filterPositionsByNamePrefix(
    List<Position?> positions,
    String query,
  ) async {
    final result =
        positions.where((position) {
          final name = position!.name?.toLowerCase() ?? '';
          return name.startsWith(query.toLowerCase());
        }).toList();

    return result.isNotEmpty ? result.first!.name ?? "" : "";
  }

  void yourFunction(int index) {
    // Your custom logic here
  }

  Widget _buildStatsTable() {
    // Mock data for playing time and positions

    final LineupController controller = Get.find<LineupController>();
    // controller.statsList.clear();
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          // Header
          SizedBox(height: 55),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            // padding: const EdgeInsets.symmetric(horizontal: 16),
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
            child: Obx(
              () =>
                  controller.statsList.isEmpty
                      ? SizedBox()
                      : Column(
                        children: List.generate(
                          controller.statsList.length,
                          (index) => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.7,
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
                                  controller.statsList[index].playingTimePercent
                                      .toString(),
                                  // stats[index]['time']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  controller.statsList[index].topPosition
                                      .toString(),
                                  // stats[index]['position']!,
                                  style: const TextStyle(fontSize: 14),
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
          onAutoCompletePressed();
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
          controller.submmitLineupDataPlayesIdFromBuildLineupScreen();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2B4582),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(' Submit Lineup'),
      ),
    );
  }

  Widget _buildOutSecton() {
    int i = 1;

    final LineupController controller = Get.find<LineupController>();
    double tableWidth =
        60 + 140 + 40 + 70 + (controller.gameData.value.innings! * 79);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: tableWidth,
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
              width: tableWidth,

              color: Colors.white,
              child: Obx(
                () =>
                    controller.playersOut.isEmpty
                        ? SizedBox()
                        : Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              controller.playersOut
                                  .map(
                                    (player) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              '${i++}',
                                              style: TextStyle(
                                                color: const Color(0xFF8B3A3A),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            // child: Text(player!.id.toString()),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${player.firstName ?? ''} ${player.lastName ?? ''}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 36,
                                            width: 80,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // if (controller
                                                //         .firstNinePlayers1
                                                //         .length >=
                                                //     11) {
                                                //   SnackbarUtils.showErrorr(
                                                //     "You can only add 9 or 11 players to the lineup. To add more, please remove a player from the current lineup above.",
                                                //   );
                                                //   return;
                                                // }

                                                i = 1;

                                                controller.playersOut.remove(
                                                  player,
                                                );

                                                controller
                                                    .gameData
                                                    .value
                                                    .players!
                                                    .add(player);
                                                final indexInLineup = controller
                                                    .autoFillData
                                                    .value!
                                                    .lineupp!
                                                    .indexWhere(
                                                      (p) =>
                                                          p.playerId ==
                                                          player.id,
                                                    );
                                                if (indexInLineup != -1) {
                                                  controller
                                                      .autoFillData
                                                      .value!
                                                      .lineupp![indexInLineup]
                                                      .isOut = false;
                                                }
                                                controller.playersOut.refresh();

                                                // controller.gameData
                                                //     .refresh();

                                                controller.gameData.refresh();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFF2A3648,
                                                ),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          2,
                                                        ),
                                                  ),
                                                  child: const Text(
                                                    'OUT',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
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
          ),
        ],
      ),
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

class PlayerStat {
  final List<int> percentage;
  final String position;

  PlayerStat({required this.percentage, required this.position});

  // Parse from Map<String, dynamic>
  factory PlayerStat.fromMap(Map<String, dynamic> map) {
    return PlayerStat(
      percentage: List<int>.from(map['percentage']),
      position: map['position'] ?? '',
    );
  }

  // Convert to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {'percentage': percentage, 'position': position};
  }
}
