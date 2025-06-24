import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/controller/org_controller/org_teams_controller.dart';
import 'package:gaming_web_app/Base/model/teamModel/org_team_model.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Base/componant/alertDialog.dart';

class OrgTeamMobileLayout extends StatelessWidget {
  final List<OrgTeamModel> teams;

  final OrgTeamsController controller = Get.find<OrgTeamsController>();
  OrgTeamMobileLayout({required this.teams});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          teams.map((team) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Team Name", team.name),

                  // _buildInfoRow("Year", team.year.toString()),
                  _buildInfoRow("Year", "2023"),
                  _buildInfoRow("Season", team.season ?? "-"),
                  _buildInfoRow("Age Group", team.ageGroup),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          title: 'Delete Team',
                          description:
                              'Are you sure you want to delete this team?',
                          onOk: () async {
                            Navigator.pop(context); // close dialog
                            await controller.deleteTeam(team.id);
                          },
                          onCancel: () => Navigator.pop(context),
                        );
                      },
                      child: Image.asset(
                        'assets/images/delete_icon.png',
                        height: 36.h,
                        width: 40.w,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: tableLabel.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: fieldLabelStyle.copyWith(
              fontSize: 10,
              color: AppColors.descriptiveTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
