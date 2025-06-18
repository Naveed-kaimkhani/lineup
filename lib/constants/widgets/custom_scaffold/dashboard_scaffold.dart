import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:get/get.dart';

import '../../../Base/controller/authController/userProfileController.dart';
import '../../../routes/routes_path.dart';
import '../../../screens/authentication/userProfile.dart';
import '../buttons/primary_button.dart';

class DashboardScaffold extends StatelessWidget {
  final bool bg;
  final String userImage;
  final String userName;
  final Widget? actionWidget;
  final String title;
  final String subtitle;
  final Function()? onTab;
  final Widget body;
  final Widget? customContent;
  final bool isShowBanner;
  const DashboardScaffold({
    super.key,
    required this.userImage,
     this.onTab,
    required this.userName,
     this.bg=true,
    this.actionWidget,
    this.title = '',
    this.subtitle = '',
    required this.body,
    this.customContent,
    this.isShowBanner = true,
  });

  @override
  Widget build(BuildContext context) {
    final UserProfileController controller = Get.put(UserProfileController());
    return Scaffold(
      body:


      SingleChildScrollView(
        child: Column(
          children: [
        LayoutBuilder(
        builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      final isDesktop = constraints.maxWidth > 1024;
      double width = constraints.maxWidth;

        return   Row(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 117.w, right: 100.w),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      onTab ==null?SizedBox():   BackButtons(onTab: onTab!,),

                         InkWell(
                             onTap: (){
                               Get.toNamed(RoutesPath.mainDashboardScreen);
                             },
                             child:
                      Container(child:   Image.asset(
                        'assets/images/line_up_hero_header.png',
                        width:isMobile ?90: 185.44.w,
                        height: 75.h,
                      ))),
                      InkWell(
                          onTap: (){
                            Get.dialog(UserprofileDialog());
                          },
                          child:
                      Row(
                        children: [
                          CircleAvatar(
                            radius:isMobile ?20: 30.r,
                            backgroundColor:Colors.grey,
                            // AppColors.secondaryColor,
                             child: Icon(Icons.person),
                            // backgroundImage: AssetImage(userImage),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome 👋',
                                style: appBarHeader.copyWith(fontSize:isMobile ? 12:16,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Obx(()=>Text(
                                controller.firstName.toUpperCase(),
                                style: descriptionStyle.copyWith(
                                  color: AppColors.descriptiveTextColor,
                                  fontSize: isMobile ? 10:14,
                                ),
                              )),
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            );}),
            SizedBox(height: 27.h),
           
            body,
          ],
        ),
      ),
    );
  }
}
