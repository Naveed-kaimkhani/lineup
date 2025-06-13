import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:get/get.dart';
import '../../Base/controller/lineupController.dart';
import '../../Base/model/lineup/fetchAutoLinup.dart';
import '../../Base/model/positioned.dart';
import '../../constants/widgets/text_fields/primary_text_field.dart';
import '../../routes/routes_path.dart';

class AddNewPlayerScreen extends StatefulWidget {
  const AddNewPlayerScreen({super.key});

  @override
  State<AddNewPlayerScreen> createState() => _AddNewPlayerScreenState();
}

class _AddNewPlayerScreenState extends State<AddNewPlayerScreen> {
  final LineupController controller = Get.put(LineupController());
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTeamsPositioned();
      controller.getGamePlayer();
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(Duration(seconds: 1), () {
    //     controller.fetchTeamsPositioned();
    //     controller.getGamePlayer();
    // });
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.fetchTeamsPositioned();
    //   controller.getGamePlayer();
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }
  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      // Check if Enter key is pressed
      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        checkFocus();
        // textFieldKey
        // checkFocus()
        // print('Enter key pressed!');
        // Add your custom logic here
      }
    }
  }



  void checkFocus() {
    print(textFieldKey[textFieldIndex]);
    print("az");

    // Use the focusNode list instead of widget state
    // if (focusNode[textFieldIndex].hasFocus) {
    //   print('TextField is focused!');
    // } else {
    //   print('TextField is not focused.');
    // }
  }



  @override
  Widget build(BuildContext context) {
    // controller.statsList.clear();
    return DashboardScaffold(
      onTab: () {
        Get.toNamed(RoutesPath.teamDashboardScreen);
      },
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      body: RawKeyboardListener(
    focusNode: _focusNode,
    onKey: _handleKey,
    child: LineupWidget()),
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
                  // 'Team'.toUpperCase(),
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
  @override
  Widget build(BuildContext context) {
    textFieldKey.clear();
    // focusNode.clear();
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildDateAndButtons(),
          const SizedBox(height: 16),
          _buildPositionChips(),
          const SizedBox(height: 16),

          // ? SizedBox()
          // :
          Column(
            children: [
              // Main lineup tables
              // LayoutBuilder(
              //   builder: (context, constraints) {
              //     bool isWideScreen = constraints.maxWidth > 900;
              //     return
              //       (controller.gameData.value.isNull ||
              //           controller.gameData.value.players == null)? SizedBox():
              //
              //       isWideScreen
              //         ? _buildWideScreenLayout()
              //         : _buildNarrowScreenLayout();
              //   },
              // ),
              // Obx(() {
              //   final gameData = controller.gameData.value;
              //   if (gameData == null || gameData.players == null) {
              //     return SizedBox();
              //   }

                // return
              LayoutBuilder(
                  builder: (context, constraints) {
                    // Avoid calling setState or updating observables here directly
                    final isWideScreen = constraints.maxWidth > 900;

                    // If you need to update something based on constraints, do it after build
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   controller.fetchTeamsPositioned();
                    //   controller.getGamePlayer();
                    // });

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
              Container(
                width: double.infinity,
                height: 900,
                margin: EdgeInsets.only(left: 50),
                // color: Colors.black,
                child: _buildOutSection(),
              ),
            ],
          ),
        ],
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
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xFFA33838),
            //     foregroundColor: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 16,
            //       vertical: 20,
            //     ),
            //   ),
            //   child: const Text('Previous Game'),
            // ),
            const SizedBox(width: 12),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xFF2B4582),
            //     foregroundColor: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 16,
            //       vertical: 20,
            //     ),
            //   ),
            //   child: const Text('Add New Game'),
            // ),
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
    final LineupController controller = Get.find<LineupController>();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Table (Main lineup)
            Expanded(flex: 3, child:
       Obx(()=>controller.isLoading.value?     _buildMainLineupTable():SizedBox())


            ),

            const SizedBox(width: 16),

            // Right Table (Playing time and position)
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

  Widget _buildMainLineupTable() {
    final LineupController controller = Get.find<LineupController>();
    // controller.statsList.clear();
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

    // !controller.isAuto.value

    // controller.isLoading.value ? controller.autoFillData.value = controller.generateAutoFillLineups(
    //       playerCount: controller.gameData.value.players!.length!,
    //       inningsCount: controller.gameData.value.innings!,
    //     )
    //     : "";

    int i = 1;

    // final inningsCount = controller.gameData.value.innings ?? 0;
    // final lineup = controller.fetchAutoFillLineups.value.lineup;
    return  ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            // Header row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(()=>Container(
              width: 1400,
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
              Container(
                child: Row(
                  children: List.generate(
                    controller.gameData.value.innings!,
                        (i) => Container(
                      width:75,
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
    )),
            ),
            // SizedBox(height: 5),

            // Table rows
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(()=>controller.gameData.value.players!.isNotEmpty?Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 1400,
                  color: Colors.white,
                  child:
                  controller.gameData.isNull
                      ? SizedBox()
                      : controller.gameData.value.players == null
                      ? SizedBox()
                      :

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      controller.gameData.value.players!.length,
                      // players.length,
                          (index) {
                        if (controller.playersOut.contains(
                          controller.gameData.value.players![index],
                        )) {
                          return SizedBox();
                        } else {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal:0,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    '${index + 1}',
                                    // '${i++}',
                                    textAlign: TextAlign.center,
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
                                    "${controller.gameData.value.players![index].firstName!} ${controller.gameData.value.players![index].lastName}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                    ),
                                    overflow: TextOverflow.ellipsis,
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

                                // Status chip
                                InkWell(
                                  onTap: () {

                                    print("name");
                                    final player =
                                    controller
                                        .gameData
                                        .value
                                        .players?[index];
                                    final exists =
                                        controller.playersOut.value
                                            ?.any(
                                              (p) => p.id == player!.id,
                                        ) ??
                                            false;

                                    if (!exists) {
                                      controller.playersOut.value?.add(
                                        player!,
                                      );
                                      print("Player added.");
                                    } else {
                                      print("Player already exists.");
                                    }

                                    print(
                                      controller
                                          .playersOut
                                          .value
                                          ?.length ??
                                          0,
                                    );
                                    controller.playersOut.refresh();

                                    i = 1;

                                    // setState(() {
                                    //
                                    // });
                                    // controller.gameData.refresh();
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
                                        color: const Color(0xFFA33838),
                                        borderRadius:
                                        BorderRadius.circular(4),
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
                                ),

                                controller.isAuto.value
                                    ? Center(

                                  // alignment: Alignment.bottomLeft,
                                  child:Text("helo")
                                )
                                    : Obx(
                                      () =>
                                  controller
                                      .autoFillData
                                      .value ==
                                      null
                                      ? Column(children: [])
                                      : Container(

                                    child:


                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: List.generate(1, (
                                          i,
                                          ) {
                                        final a =
                                            controller
                                                .autoFillData
                                                .value!
                                                .lineupp;
                                        final valuesList =
                                            controller
                                                .autoFillData
                                                .value!
                                                .lineupp![index]
                                                .innings!
                                                .keys;


                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:
                                          valuesList.map((
                                              inningNumber,
                                              ) {
                                            bool
                                            isLable =
                                            false;
                                            TextEditingController
                                            textEditingController =
                                            TextEditingController();
                                            return

                                              Focus(
                                              onFocusChange: (
                                                  hasFocus,
                                                  ) async {
                                                if (!hasFocus) {
                                                  yourFunction(
                                                    index,
                                                  );
                                                  // controller.teamPositioned
                                                  String
                                                  result = await filterPositionsByNamePrefix(
                                                    controller!.teamPositioned.value!,
                                                    controller.enerLable.value,
                                                  );
                                                  print(
                                                    "Matched name: $result",
                                                  );
                                                  if (result !=
                                                      "") {
                                                    controller.autoFillData.value!.lineupp![index].innings![inningNumber] =
                                                        result;
                                                    controller.autoFillData.refresh();
                                                    textEditingController.text =
                                                        result;
                                                    // setState(() {
                                                    isLable =
                                                    true;

                                                    // controller.fixedAssignments!.add({});
                                                 controller.addFixedAssignment(
                                                     controller
                                                         .gameData
                                                         .value
                                                         .players![index].id.toString()
                                                 , '${inningNumber}', result);


                                                    // });
                                                  }
                                                  // The widget lost focus, run your function here
                                                  print(
                                                    'Widget unfocused — run your function',
                                                  );
                                                }
                                              },
                                              child:

                                              Container(
                                                padding:
                                                const EdgeInsets.all(
                                                  8,
                                                ),
                                                color:
                                                Colors.white,
                                                child:

                                                LineupTextField(
                                                  positions:
                                                  controller!.teamPositioned.value!,
                                                  controller: TextEditingController(
                                                    text:
                                                    controller.autoFillData.value!.lineupp![index].innings![inningNumber],
                                                  ),
                                                  // textEditingController,
                                                  isLable: filterPositionsByNameMatch(
                                                    controller!.teamPositioned.value!,
                                                    textEditingController.text,
                                                  ),
                                                  onChanged: (
                                                      val,
                                                      ) {

                                                    print("heloo");

                                                    controller.enerLable.value =
                                                        val.toString();
                                                    print(
                                                      "inningNumber.toString()",
                                                    );
                                                    print(
                                                      controller.autoFillData.value!.lineupp![index].innings!.keys,
                                                    );
                                                    print(
                                                      inningNumber.toString(),
                                                    );
                                                    // ✅ Only update the specific inning number (key)
                                                    // int inningKey = int.parse(inningNumber); // or get this dynamically based on UI
                                                    controller.autoFillData.value!.lineupp![index].innings![inningNumber] =
                                                        val;
                                                    print(
                                                      controller.autoFillData.toJson(),
                                                    );
                                                  },
                                                ),
                                                //   position,
                                                //   style: const TextStyle(
                                                //     fontSize: 16,
                                                //     color: Colors.black87,
                                                //   ),
                                                // ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  //     ),
                  //   ),
                  // ),
                  //     ),

                )
              ],):SizedBox()),
            ),
          ],
        ),
      )
    ;
  }

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
    print('Function called for index $index');
  }

  // Container(
  // child: Column(
  // children: List.generate(9, (i) {
  // // final valuesList =
  // //     lineup![index].innings!.values.toList();
  //
  // return Row(
  // mainAxisSize: MainAxisSize.max,
  // mainAxisAlignment:
  // MainAxisAlignment.spaceBetween,
  // children:
  // valuesList.map((position) {
  // return
  // Container(
  // padding: const EdgeInsets.all(8),
  // color: Colors.white,
  // child: LineupTextField(onChanged: (val){
  //
  // },)
  // //   position,
  // //   style: const TextStyle(
  // //     fontSize: 16,
  // //     color: Colors.black87,
  // //   ),
  // // ),
  // );
  // }).toList(),
  // );
  // }),
  // ),
  // ),

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
    final LineupController controller = Get.find<LineupController>();
    // controller.statsList.clear();
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
            child: Obx(
              () =>
                  controller.statsList.value.isEmpty
                      ? SizedBox()
                      : Column(
                        children: List.generate(
                          controller.statsList.length,
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
    int i = 1;
    // Mock bench players
    final benchPlayers = [
      {'number': '01', 'name': 'Mick Johnathan'},
      {'number': '02', 'name': 'Sophie Turner'},
      {'number': '03', 'name': 'Lucas Grey'},
    ];
    final LineupController controller = Get.find<LineupController>();

    // controller.autoFillData.value!
    //     .lineupp!
    //     .where((lineup) => lineup.isOut)
    //     .length
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
              child: Obx(
                () =>
                    controller.playersOut.value.isEmpty
                        ? SizedBox()
                        : Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              controller.playersOut.value!
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
                                              player.fullName!.toString(),
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
                                                i = 1;
                                                controller.playersOut.value
                                                    .remove(player);
                                                controller.playersOut.refresh();
                                                // controller.gameData.refresh();
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
