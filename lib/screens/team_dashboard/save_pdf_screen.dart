import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/colored_name_text.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:gaming_web_app/screens/team_dashboard/print_out_alert_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/lineupController.dart';
import '../../Base/model/lineup/pdfModel.dart';

class SavePdfScreen extends StatelessWidget {
  const SavePdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      isShowBanner: false,
      body: _LineupWidget(),
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
  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPDF();
      controller.fetchTeamsPositioned();
    });



  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 800;

        return Container(
          color: const Color(0xFFF8F8F8),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 100.w : 16.w,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: make it wrap or stack on mobile
              isDesktop
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 120.w),
                  _buildHeaderColumn(),
                  PrimaryButton(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => const PrintOutAlertDialog(),
                      );
                    },
                    backgroundColor: AppColors.secondaryColor,
                    title: 'Save PDF',
                    width: 277.w,
                  ),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeaderColumn(),
                  SizedBox(height: 16),
                  PrimaryButton(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => const PrintOutAlertDialog(),
                      );
                    },
                    backgroundColor: AppColors.secondaryColor,
                    title: 'Save PDF',
                    width: double.infinity,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              /// Top Role Labels
              _buildPositionChips(),

              const SizedBox(height: 24),

              /// Lineup Table Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildLineupTable(isDesktop),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// OUT Section (can also be responsive)
              Chip(
                label: Text(
                  'OUT',
                  style: descriptionStyle.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                color: Colors.white,
                child: Column(
                  children: List.generate(3, (index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 50, child: Text('0${index + 1}')),
                          Text(
                            'Player Name',
                            style: tableContentHeader.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          SizedBox(
                            height: 50.h,
                            child: PrimaryButton(
                              onTap: () {},
                              textStyle: descriptionStyle.copyWith(
                                color: Colors.white,
                              ),
                              backgroundColor: AppColors.descriptiveTextColor,
                              title: 'Add',
                              width: 60.w,
                            ),
                          ),
                          const SizedBox(width: 12),
                          for (int i = 0; i < 6; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: Chip(
                                label: Text('OUT'),
                                labelStyle: descriptionStyle.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 14.sp,
                                ),
                                backgroundColor: Color(0xFFE7E7E7),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'PREVIEW',
          style: descriptionHeader.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('TEAM EAGLE ', style: fieldLabelStyle),
            ColoredNameText(
              name: 'VS TEAM',
              firstColor: Color(0xff454545),
              secondColor: Colors.black,
            ),
            Text('TIGER', style: fieldLabelStyle),
          ],
        ),
        Text(
          'APRIL 03 2025',
          style: fieldLabelStyle.copyWith(
            fontSize: 32.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ],
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

      // Adjust column widths based on screen size:
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
              orElse: () =>
                  LineupAssignment(playerId: player.id.toString(), innings: {}),
            );

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: lineupWidth, child: Text('${index + 1}'.padLeft(2, '0'))),
                  SizedBox(
                    width: playerNameWidth,
                    child: Text(
                      player.fullName ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: jerseyWidth, child: Text(player.jerseyNumber?.toString() ?? '')),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 1; i <= (model.gameDetails?.inningsCount ?? 0); i++) ...[
                            SizedBox(
                              width: inningWidth,
                              child: Chip(
                                label: Text(
                                  lineup.innings[i] ?? lineup.innings[i.toString()] ?? '--',
                                  style: descriptionStyle.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      );
    });
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
}
