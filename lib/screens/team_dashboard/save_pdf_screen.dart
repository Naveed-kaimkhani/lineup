import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/colored_name_text.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' as html;

import '../../Base/controller/lineupController.dart';
import '../../Base/model/lineup/pdfModel.dart';
import 'package:flutter/foundation.dart';

import '../../constants/widgets/text_fields/primary_text_field.dart';
import '../../main.dart';
import '../../routes/routes_path.dart';

class SavePdfScreen extends StatelessWidget {
  const SavePdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      onTab: () {

        Get.toNamed(RoutesPath.mainDashboardScreen);
      },
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      isShowBanner: false,
      body: const _LineupWidget(),
    );
  }
}

class _LineupWidget extends StatefulWidget {
  const _LineupWidget({super.key});

  @override
  State<_LineupWidget> createState() => _LineupWidgetState();
}

class _LineupWidgetState extends State<_LineupWidget> {
  final LineupController controller = Get.put(LineupController());
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    controller.getPDF();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPDF();
      controller.fetchTeamsPositioned();
      controller.getGamePlayer();
    });
  }

  // new code
  Future<void> _generateAndSavePDF() async {
    try {
      toggleLoader(true);
      // Capture the widget as an image
      final image = await screenshotController.capture();

      if (image == null) {
        Get.snackbar('Error', 'Failed to capture screenshot');
        return;
      }

      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(image);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(child: pw.Image(pdfImage)),
        ),
      );

      final pdfBytes = await pdf.save();

      // Web-specific download
      if (kIsWeb) {
        // Use kIsWeb from 'dart:io' or 'package:flutter/foundation.dart'
        final blob = html.Blob([pdfBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor =
            html.document.createElement('a') as html.AnchorElement
              ..href = url
              ..style.display = 'none'
              ..download =
                  'lineup_${DateTime.now().millisecondsSinceEpoch}.pdf';
        html.document.body!.append(anchor);
        anchor.click();
        anchor.remove();
        html.Url.revokeObjectUrl(url);
        toggleLoader(false);
        Get.toNamed(RoutesPath.mainDashboardScreen);
        Get.snackbar('Success', 'PDF downloaded');
      } else {
        // Fallback for mobile/desktop (already handled in previous code)
        final directory =
            await getDownloadsDirectory() ??
            await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}/lineup_${DateTime.now().millisecondsSinceEpoch}.pdf';
        // final file = File(filePath);
        final file = await controller.getFileFromPath(filePath);
        // final file = File(filePath);
        await file.writeAsBytes(pdfBytes);
        toggleLoader(false);
        Get.snackbar('Success', 'PDF saved at $filePath');
        await OpenFile.open(filePath);
      }
    } catch (e) {
      toggleLoader(false);
      Get.snackbar('Error', 'Failed to generate PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.pDFMODEL.value.isNull) {
      controller.getPDF();
    }
    return  LayoutBuilder(
        builder: (context, constraints) {
          if (controller.pDFMODEL.value.isNull) {
            controller.getPDF();
          }
          final bool isDesktop = constraints.maxWidth > 800;

          return
            Obx(()=>controller.isPayment.value?



            Container(
            color: const Color(0xFFF8F8F8),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 100.w : 16.w,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: PrimaryButton(
                  onTap: _generateAndSavePDF, // Updated to generate PDF
                  backgroundColor: AppColors.secondaryColor,
                  title: 'Save PDF',
                  width: 277.w,
                ),),
                // Top Row: make it wrap or stack on mobile
              Screenshot(
                controller: screenshotController,
                child:    Column(children: [ isDesktop
                   ? Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   // SizedBox(width: 120.w),
                   _buildHeaderColumn(),
                   // PrimaryButton(
                   //   onTap: _generateAndSavePDF, // Updated to generate PDF
                   //   backgroundColor: AppColors.secondaryColor,
                   //   title: 'Save PDF',
                   //   width: 277.w,
                   // ),
                 ],
               )
                   : Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   _buildHeaderColumn(),
                   const SizedBox(height: 16),
                   // PrimaryButton(
                   //   onTap: _generateAndSavePDF, // Updated to generate PDF
                   //   backgroundColor: AppColors.secondaryColor,
                   //   title: 'Save PDF',
                   //   width: double.infinity,
                   // ),
                 ],
               ),
                 // const SizedBox(height: 32),
                 // _buildPositionChips(),
                 const SizedBox(height: 24),
                 Obx(
                       () =>
                   (controller.gameData.value.isNull ||
                       controller.gameData.value.players == null)
                       ? const SizedBox()
                       : Column(
                     children: [
                       LayoutBuilder(
                         builder: (context, constraints) {
                           bool isWideScreen =
                               constraints.maxWidth > 900;
                           return isWideScreen
                               ? _buildWideScreenLayout()
                               : _buildNarrowScreenLayout();
                         },
                       ),
                       const SizedBox(height: 24),
                     ],
                   ),
                 ),
                 const SizedBox(height: 24),],))
              ],
            ),
          ):Column(children: [


            Text("Access Denied. Team does not have active access.")

          ],));
        },

    );
  }

  Widget _buildMainLineupTable() {
    final LineupController controller = Get.find<LineupController>();

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
                // const SizedBox(width: 40),
                Container(
                  width: 1300,
                  child: Row(
                    children: List.generate(
                      controller.gameData.value.innings ?? 0,
                      (i) => Container(
                        width:  75,
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
          const SizedBox(height: 5),

          // Player rows
          Obx(() {
            var a = controller.gameData.value;
            print(a);
            final players = controller.gameData.value.players;
            final inningsCount = controller.gameData.value.innings ?? 0;
            final autoFillLineups = controller.autoFillData.value?.lineupp ?? [];

            if (players == null || players.isEmpty) return SizedBox();

            return Column(
              children: List.generate(players.length, (index) {
                final player = players[index];
                final innings =
                    autoFillLineups.isNotEmpty && autoFillLineups.length > index
                        ? autoFillLineups[index].innings ?? {}
                        : {};

                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Text(
                          '${index + 1}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF8B3A3A),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(
                          player.firstName ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(player.jerseyNumber?.toString() ?? ''),
                      ),
                      // SizedBox(
                      //   width: 70,
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 8,
                      //       vertical: 4,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xFFA33838),
                      //       borderRadius: BorderRadius.circular(4),
                      //     ),
                      //     child: const Text(
                      //       'Out',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Row(
                          children: List.generate(1, (i) {
                            final valuesList =
                                controller
                                    .pDFMODEL
                                    .value
                                    .lineupAssignments![index]
                                    .innings!
                                    .values;

                            return Row(
                              // mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children:
                                  valuesList.map((inningNumber) {
                                    TextEditingController
                                    textEditingController =
                                        TextEditingController();
                                    return Focus(
                                      onFocusChange: (hasFocus) async {},
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.white,
                                        child: LineupTextField(
                                          readAble:true ,
                                          positions:
                                              controller!.teamPositioned.value!,
                                          controller: TextEditingController(
                                            text: inningNumber,
                                            // controller
                                            //     .autoFillData
                                            //     .value!
                                            //     .lineup![index]
                                            //     .innings![inningNumber],
                                          ),
                                          // textEditingController,
                                          isLable: filterPositionsByNameMatch(
                                            controller!.teamPositioned.value!,
                                            textEditingController.text,
                                          ),
                                          onChanged: (val) {},
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
                    ],
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatsTable() {
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
          const SizedBox(height: 5),
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

  Widget _buildWideScreenLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Expanded(flex: 3, child: _buildMainLineupTable())],
    );
  }

  Widget _buildNarrowScreenLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainLineupTable(),
        // const SizedBox(height: 16),
        // _buildStatsTable(),
      ],
    );
  }

  Widget _buildHeaderColumn() {
    return
      Container(
        // alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width-350,
        // color: Colors.red,
        child:
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'PREVIEW       ',
          style: descriptionHeader.copyWith(color: AppColors.secondaryColor),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                "${controller.pDFMODEL.value.gameDetails?.teamName ?? 'TEAM EAGLE'} ",
                style: fieldLabelStyle,
              ),
            ),
            const ColoredNameText(
              name: 'VS',
              firstColor: Color(0xff454545),
              secondColor: Colors.black,
            ),
            Obx(
              () => Text(
                " ${controller.pDFMODEL.value.gameDetails?.opponentName ?? 'TEAM TIGER'}",
                style: fieldLabelStyle,
              ),
            ),
          ],
        ),
        Obx(
          () => Text(
            controller.pDFMODEL.value.gameDetails?.gameDate != null
                ? DateFormat(
                  'MMMM d y',
                ).format(controller.pDFMODEL.value.gameDetails!.gameDate!)
                : 'APRIL 03 2025',
            style: fieldLabelStyle.copyWith(
              fontSize: 32.sp,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildPositionChips() {
    final LineupController controller = Get.find<LineupController>();
    return Obx(
      () =>
          controller.teamPositioned.isEmpty
              ? const SizedBox()
              : Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    controller.teamPositioned.map((position) {
                      final bool isOut = position!.name == "OUT";
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

  Widget _buildLineupTable(bool isDesktop) {
    final LineupController controller = Get.find<LineupController>();
    return Obx(() {
      final model = controller.pDFMODEL.value;
      if (model == null) return const Center(child: Text("Loading..."));
      if (model.playersInfo == null ||
          model.lineupAssignments == null ||
          model.gameDetails == null) {
        return const Center(child: Text("No player data available."));
      }
      if (model.playersInfo!.isEmpty || model.lineupAssignments!.isEmpty) {
        return const Center(child: Text("No player data available."));
      }

      final double lineupWidth = isDesktop ? 50 : 30;
      final double playerNameWidth = isDesktop ? 120 : 80;
      final double jerseyWidth = isDesktop ? 24 : 20;
      final double inningWidth = isDesktop ? 110 : 70;

      return Container(
        color: Colors.white,
        child: Column(
          children: List.generate(model.playersInfo!.length, (index) {
            final player = model.playersInfo![index];
            final lineup = model.lineupAssignments!.firstWhere(
              (l) => l.playerId == player.id,
              orElse:
                  () => LineupAssignment(
                    playerId: player.id.toString(),
                    innings: {},
                  ),
            );

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: lineupWidth,
                    child: Text('${index + 1}'.padLeft(2, '0')),
                  ),
                  SizedBox(
                    width: playerNameWidth,
                    child: Text(
                      player.fullName ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: jerseyWidth,
                    child: Text(player.jerseyNumber?.toString() ?? ''),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (
                            int i = 1;
                            i <= (model.gameDetails?.inningsCount ?? 0);
                            i++
                          ) ...[
                            SizedBox(
                              width: inningWidth,
                              child: Chip(
                                label: Text(
                                  lineup.innings[i.toString()] ?? '--',
                                  style: descriptionStyle.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/colored_name_text.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
// import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
// import 'package:gaming_web_app/screens/team_dashboard/print_out_alert_dialog.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../Base/controller/lineupController.dart';
// import '../../Base/model/lineup/pdfModel.dart';
//
// class SavePdfScreen extends StatelessWidget {
//   const SavePdfScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DashboardScaffold(
//       userImage: 'assets/images/dummy_image.png',
//       userName: 'Test User',
//       isShowBanner: false,
//       body: _LineupWidget(),
//     );
//   }
// }
// class _LineupWidget extends StatefulWidget {
//   const _LineupWidget({super.key});
//
//   @override
//   State<_LineupWidget> createState() => _LineupWidgetState();
// }
//
// class _LineupWidgetState extends State<_LineupWidget> {
//
//   final LineupController controller = Get.put(LineupController());
//   @override
//   void initState()
//   {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.getPDF();
//       controller.fetchTeamsPositioned();
//     });
//
//
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final bool isDesktop = constraints.maxWidth > 800;
//
//         return Container(
//           color: const Color(0xFFF8F8F8),
//           padding: EdgeInsets.symmetric(
//             horizontal: isDesktop ? 100.w : 16.w,
//             vertical: 16,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top Row: make it wrap or stack on mobile
//               isDesktop
//                   ? Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   SizedBox(width: 120.w),
//                   _buildHeaderColumn(),
//                   PrimaryButton(
//                     onTap: () async {
//                       await showDialog(
//                         context: context,
//                         barrierDismissible: true,
//                         builder: (_) => const PrintOutAlertDialog(),
//                       );
//                     },
//                     backgroundColor: AppColors.secondaryColor,
//                     title: 'Save PDF',
//                     width: 277.w,
//                   ),
//                 ],
//               )
//                   : Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   _buildHeaderColumn(),
//                   SizedBox(height: 16),
//                   PrimaryButton(
//                     onTap: () async {
//                       await showDialog(
//                         context: context,
//                         barrierDismissible: true,
//                         builder: (_) => const PrintOutAlertDialog(),
//                       );
//                     },
//                     backgroundColor: AppColors.secondaryColor,
//                     title: 'Save PDF',
//                     width: double.infinity,
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 32),
//
//               /// Top Role Labels
//               // _buildPositionChips(),
//
//               const SizedBox(height: 24),
//
//               /// Lineup Table Section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: _buildLineupTable(isDesktop),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 24),
//
//               /// OUT Section (can also be responsive)
//               Chip(
//                 label: Text(
//                   'OUT',
//                   style: descriptionStyle.copyWith(
//                     color: AppColors.primaryColor,
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               Container(
//                 color: Colors.white,
//                 child: Column(
//                   children: List.generate(3, (index) {
//                     return Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 8,
//                         horizontal: 12,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: Colors.grey.shade300),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           SizedBox(width: 50, child: Text('0${index + 1}')),
//                           Text(
//                             'Player Name',
//                             style: tableContentHeader.copyWith(
//                               color: AppColors.secondaryColor,
//                               fontSize: 16.sp,
//                             ),
//                           ),
//                           SizedBox(width: 20.w),
//                           SizedBox(
//                             height: 50.h,
//                             child: PrimaryButton(
//                               onTap: () {},
//                               textStyle: descriptionStyle.copyWith(
//                                 color: Colors.white,
//                               ),
//                               backgroundColor: AppColors.descriptiveTextColor,
//                               title: 'Add',
//                               width: 60.w,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           for (int i = 0; i < 6; i++)
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 50.w),
//                               child: Chip(
//                                 label: Text('OUT'),
//                                 labelStyle: descriptionStyle.copyWith(
//                                   color: AppColors.secondaryColor,
//                                   fontSize: 14.sp,
//                                 ),
//                                 backgroundColor: Color(0xFFE7E7E7),
//                               ),
//                             ),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildHeaderColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'PREVIEW',
//           style: descriptionHeader.copyWith(
//             color: AppColors.secondaryColor,
//           ),
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('TEAM EAGLE ', style: fieldLabelStyle),
//             ColoredNameText(
//               name: 'VS TEAM',
//               firstColor: Color(0xff454545),
//               secondColor: Colors.black,
//             ),
//             Text('TIGER', style: fieldLabelStyle),
//           ],
//         ),
//         Text(
//           'APRIL 03 2025',
//           style: fieldLabelStyle.copyWith(
//             fontSize: 32.sp,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLineupTable(bool isDesktop) {
//     final LineupController controller = Get.find<LineupController>();
//
//     return Obx(() {
//       final model = controller.pDFMODEL.value;
//
//       if (model == null) return const Center(child: Text("Loading..."));
//       if (model.playersInfo == null ||
//           model.lineupAssignments == null ||
//           model.gameDetails == null) {
//         return const Center(child: Text("No player data available."));
//       }
//       if (model.playersInfo!.isEmpty || model.lineupAssignments!.isEmpty) {
//         return const Center(child: Text("No player data available."));
//       }
//
//       // Adjust column widths based on screen size:
//       final double lineupWidth = isDesktop ? 50 : 30;
//       final double playerNameWidth = isDesktop ? 120 : 80;
//       final double jerseyWidth = isDesktop ? 24 : 20;
//       final double inningWidth = isDesktop ? 110 : 70;
//
//       return Container(
//         color: Colors.white,
//         child: Column(
//           children: List.generate(model.playersInfo!.length, (index) {
//             final player = model.playersInfo![index];
//             final lineup = model.lineupAssignments!.firstWhere(
//                   (l) => l.playerId == player.id,
//               orElse: () =>
//                   LineupAssignment(playerId: player.id.toString(), innings: {}),
//             );
//
//             return Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey.shade300),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   SizedBox(width: lineupWidth, child: Text('${index + 1}'.padLeft(2, '0'))),
//                   SizedBox(
//                     width: playerNameWidth,
//                     child: Text(
//                       player.fullName ?? '',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(width: jerseyWidth, child: Text(player.jerseyNumber?.toString() ?? '')),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           for (int i = 1; i <= (model.gameDetails?.inningsCount ?? 0); i++) ...[
//                             SizedBox(
//                               width: inningWidth,
//                               child: Chip(
//                                 label: Text(
//                                   lineup.innings[i] ?? lineup.innings[i.toString()] ?? '--',
//                                   style: descriptionStyle.copyWith(
//                                     color: AppColors.secondaryColor,
//                                     fontSize: 14.sp,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                           ],
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }),
//         ),
//       );
//     });
//   }
//   Widget _buildPositionChips() {
//     final LineupController controller = Get.find<LineupController>();
//     final List<Map<String, String>> positions = [
//       {'label': 'Pitcher = P', 'color': 'white'},
//       {'label': 'Catcher = C', 'color': 'white'},
//       {'label': '1st Base = 1B', 'color': 'white'},
//       {'label': '2nd Base = 2B', 'color': 'white'},
//       {'label': '3rd Base = 3B', 'color': 'white'},
//       {'label': 'Short Stop = SS', 'color': 'white'},
//       {'label': 'Left Field = LF', 'color': 'white'},
//       {'label': 'Right Field = RF', 'color': 'white'},
//       {'label': 'Center Field = CF', 'color': 'white'},
//       {'label': 'Bench = OUT', 'color': 'red'},
//     ];
//
//     return Obx(
//           () =>
//       controller.teamPositioned.isEmpty
//           ? SizedBox()
//           : Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children:
//         controller.teamPositioned.map((position) {
//           final bool isOut = position!.name == "OUT" ? true : false;
//           // final bool isOut = position['label']!.contains('OUT');
//           return Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 8,
//             ),
//             decoration: BoxDecoration(
//               color: isOut ? const Color(0xFFF01414) : Colors.white,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               "${position.display_name!} = ${position.name}",
//               style: TextStyle(
//                 color: isOut ? Colors.white : Colors.black,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 14,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
