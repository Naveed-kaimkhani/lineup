import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/controller/org_controller/team_detail_controller.dart';
import 'package:gaming_web_app/Base/model/teamModel/player_stats.dart';
import 'package:gaming_web_app/constants/widgets/custom_scaffold/dashboard_scaffold.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TeamDetailsScreen extends StatelessWidget {
  final int teamId;

  TeamDetailsScreen({super.key, required this.teamId});

  final controller = Get.put(TeamDetailController());

  @override
  Widget build(BuildContext context) {
    controller.fetchTeamData(teamId);

    return DashboardScaffold(
      userImage: 'assets/images/dummy_image.png',
      userName: 'Test User',
      title: 'My Team',
      subtitle: 'Lineup',
      body: Obx(
        () =>
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : _TeamDashboardBody(players: controller.players),
      ),
    );
  }
}

class _TeamDashboardBody extends StatelessWidget {
  final List<OrgPlayer> players;

  const _TeamDashboardBody({required this.players});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 89.w),
      child: _ResponsivePlayerTable(players: players),
    );
  }
}

class _ResponsivePlayerTable extends StatelessWidget {
  final List<OrgPlayer> players;

  const _ResponsivePlayerTable({required this.players});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        ...players.map((player) => _buildRow(player)).toList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: const [
          Expanded(flex: 1, child: Text('#')),
          Expanded(flex: 3, child: Text('Player Name')),
          Expanded(flex: 2, child: Text('% Innings Played')),
          Expanded(flex: 2, child: Text('Total Innings')),
          Expanded(flex: 1, child: Text('% INF')),
          Expanded(flex: 2, child: Text('Position')),
          Expanded(flex: 2, child: Text('Average')),
        ],
      ),
    );
  }

  Widget _buildRow(OrgPlayer player) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: const EdgeInsets.only(bottom: 1),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(player.jerseyNumber)),
          Expanded(flex: 3, child: Text(player.fullName)),
          Expanded(flex: 2, child: Text("${player.stats.pctInningsPlayed}%")),
          Expanded(flex: 2, child: Text("${player.stats.totalInnings}")),
          Expanded(
            flex: 1,
            child: Text("${player.stats.pctInningsPlayed}%"),
          ), // reuse if INF not available
          Expanded(flex: 2, child: Text(player.stats.topPosition ?? "--")),
          Expanded(
            flex: 2,
            child: Text("${player.stats.avgBattingLoc ?? 0.0}"),
          ),
        ],
      ),
    );
  }
}
