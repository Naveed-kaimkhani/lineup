import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/model/positioned.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/drop_down/dynamic_dropdown_list.dart';
import 'package:get/get.dart';
import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../constants/widgets/buttons/primary_button.dart';

class SetFavoredPositionDialogg extends StatelessWidget {
  final NewTeamController controller = Get.find<NewTeamController>();
  final TeamController teamController = Get.find<TeamController>();

  @override
  Widget build(BuildContext context) {
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 900;

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight * 0.95,
                    maxWidth: isMobile ? constraints.maxWidth * 0.95 : 768.w,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 20.h : 40.h,
                      horizontal: isMobile ? 20.w : 60.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(children: [

                          Text(
                            'Set Favored Positions'.toUpperCase(),
                            style:
                            formHeaderStyle.copyWith(fontSize: 24,
                              color: AppColors.secondaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                            Spacer(),
                            InkWell(
                              onTap: (){

                                Get.back();
                              },

                              child: Icon(Icons.cancel,color: Colors.red,),)

                        ],),
                        SizedBox(height: 20.h),
                        Text(
                          'Allocate what positions you want each player to play over the season',
                          style: descriptionStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.h),

                        /// ✅ Scrollable content
                        Flexible(
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: List.generate(
                                teamController.getPlayer.value.length,
                                    (i) {
                                  final player = teamController.getPlayer[i];
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      // Determine width based on screen size
                                      final isMobile = MediaQuery.of(context).size.width < 900;
                                      final itemWidth = isMobile
                                          ? MediaQuery.of(context).size.width * 0.9
                                          : (768.w / 2) - 40; // Two columns on desktop

                                      return SizedBox(
                                        width: itemWidth,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                player!.firstName.toString(),
                                                style: descriptionStyle.copyWith(
                                                  fontSize: 14,
                                                  color: AppColors.descriptiveTextColor,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Player’s preferred Positions',
                                                style: descriptionStyle.copyWith(
                                                  fontSize: 14,
                                                  color: AppColors.activeGreenColor,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              DynamicDropdownList<Position?>(
                                                items: teamController.teamPositioned!,
                                                selectedItem: teamController.positioned,
                                                itemLabelBuilder: (item) => item?.name ?? 'N/A',
                                                dropdownWidth: 200,
                                                onChanged: (value) {},
                                              ),
                                              DynamicDropdownList<Position?>(
                                                items: teamController.teamPositioned!,
                                                selectedItem: teamController.positioned,
                                                itemLabelBuilder: (item) => item?.category ?? 'N/A',
                                                dropdownWidth: 200,
                                                onChanged: (value) {},
                                              ),
                                              SizedBox(height: 10),
                                              PrimaryButton(
                                                width: double.infinity,
                                                onTap: () {},
                                                title: 'Add',
                                                backgroundColor: AppColors.descriptiveTextColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
