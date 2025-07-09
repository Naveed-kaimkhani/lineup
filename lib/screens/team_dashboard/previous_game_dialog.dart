import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/colored_name_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Base/controller/globleController.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../routes/routes_path.dart';
import '../../utils/SharedPreferencesUtil.dart';

class PreviousGameDialog extends StatelessWidget {
  final List<Map<String, String>> items;

  PreviousGameDialog({super.key, required this.items});

  final TeamController controller = Get.find<TeamController>();
  final GlobleController globleController = Get.put(GlobleController());
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 700;

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
            child: Container(
              width: isWideScreen ? 1000 : double.infinity,
              constraints: BoxConstraints(
                maxHeight:
                    isWideScreen
                        ? 1000
                        : MediaQuery.of(context).size.height * 0.8,
                maxWidth: isWideScreen ? 1000 : 700,
                // MediaQuery.of(context).size.width * ,
              ),
              padding: EdgeInsets.symmetric(
                vertical: isWideScreen ? 40 : 20,
                horizontal: isWideScreen ? 40 : 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Header Row
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Previous Game'.toUpperCase(),
                        style: TextStyle(
                          fontSize: isWideScreen ? 20 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Game List
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.teamData.value?.games?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = controller.teamData.value!.games![index];
                        final name = item.opponentName;
                        final date = item.gameDate;

                        /// sve game id
                        final parsedDate = DateTime.parse(date.toString());

                        // Format to MM-dd-yyyy
                        final formatted = DateFormat(
                          'dd-MM-yyyy',
                        ).format(parsedDate);

                        return item.isLineupSubmitted
                            ? InkWell(
                              onTap: () async {
                                await SharedPreferencesUtil.save(
                                  'gameID',
                                  item.id.toString(),
                                );
                                await SharedPreferencesUtil.saveCurrentRoute(
                                  RoutesPath.teamDashboardScreen,
                                );
                                Navigator.pushNamed(
                                  context,
                                  RoutesPath.addNewPlayerScreen,
                                );
                              },

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child:
                                    isWideScreen
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ColoredNameText(
                                              name: name,
                                              textStyle: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  // DateFormat(
                                                  //   'MM-dd-yyyy',
                                                  // ).format(date),
                                                  formatted,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () async {
                                                    await globleController
                                                        .gameDelete(item.id);
                                                    controller.fetchTeams();
                                                    Navigator.pop(context);
                                                    // TODO: Delete logic
                                                  },
                                                  child: Image.asset(
                                                    'assets/images/delete_icon.png',
                                                    height: 32,
                                                    width: 32,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                        : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ColoredNameText(name: name),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  // _formatDate(date.toString()),
                                                  DateFormat(
                                                    'MM-dd-yyyy',
                                                  ).format(date),

                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    globleController.gameDelete(
                                                      item.id,
                                                    );
                                                    // TODO: Delete logic
                                                  },
                                                  child: Image.asset(
                                                    'assets/images/delete_icon.png',
                                                    height: 32,
                                                    width: 32,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                              ),
                            )
                            : SizedBox();
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('MM-dd-yyyy').format(dateTime.toLocal());
    } catch (e) {
      return dateStr; // fallback if parsing fails
    }
  }
}
