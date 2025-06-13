// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import 'package:gaming_web_app/Base/model/positioned.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/drop_down/dynamic_dropdown_list.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
//
// import '../../Base/controller/teamController/createTeamController.dart';
// import '../../Base/controller/teamController/favoritPositionedConteroller.dart';
// import '../../Base/controller/teamController/teamController.dart';
//
// class SetFavoredPositionDialog extends StatefulWidget {
//   const SetFavoredPositionDialog({super.key});
//
//   @override
//   State<SetFavoredPositionDialog> createState() =>
//       _SetFavoredPositionDialogState();
// }
//
// class _SetFavoredPositionDialogState extends State<SetFavoredPositionDialog> {
//   final NewTeamController controller = Get.find<NewTeamController>();
//   final TeamController teamController = Get.find<TeamController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final players = teamController.getPlayer;
//
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.zero,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.9,
//           maxWidth: MediaQuery.of(context).size.width * 0.95,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: List.generate(players.length, (index) {
//               final player = players[index];
//
//               // Proper reference list
//               final positioned =
//                   teamController.teamPositioned.whereType<Position>().toList();
//
//               final controllerTag = 'controller_$index';
//
//               final favoriteController = Get.put(
//                 FavoritePositionedController(),
//                 tag: controllerTag,
//               );
//
//               return SizedBox(
//                 width: double.infinity,
//                 child: GetBuilder<FavoritePositionedController>(
//                   tag: controllerTag,
//                   builder: (ctrl) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: PlayerFavWidget(
//                             player: player,
//                             controller: favoriteController,
//                             list: positioned,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: PlayerResWidget(
//                             player: player,
//                             controller: favoriteController,
//                             list: positioned,
//                           ),
//                         ),
//                         // Expanded(child: PlayerResWidget(player, ctrl, positioned)),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget buildPlayerFav(player, FavoritePositionedController controller, List<Position> list) {
//   //   return Container(
//   //     padding: EdgeInsets.all(16),
//   //     decoration: BoxDecoration(
//   //       color: Colors.indigo[50],
//   //       border: Border.all(color: AppColors.secondaryColor),
//   //       borderRadius: BorderRadius.circular(12.r),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Text(
//   //           player.firstName ?? "Player",
//   //           style: descriptionStyle.copyWith(
//   //             fontSize: 14,
//   //             color: AppColors.descriptiveTextColor,
//   //           ),
//   //         ),
//   //         SizedBox(height: 4),
//   //         Text(
//   //           'Player’s Preferred Positions',
//   //           style: descriptionStyle.copyWith(
//   //             fontSize: 14,
//   //             color: AppColors.activeGreenColor,
//   //           ),
//   //         ),
//   //         SizedBox(height: 10),
//   //         DynamicDropdownList<Position?>(
//   //           items: list,
//   //           selectedItem: controller.selectedFavPosition,
//   //           itemLabelBuilder: (item) => item?.name ?? 'N/A',
//   //           onChanged: (value) {
//   //             controller.selectedFavPosition = value;
//   //             controller.update();
//   //           },
//   //         ),
//   //         SizedBox(height: 20),
//   //         Text(
//   //           'Player’s Restricted Positions',
//   //           style: descriptionStyle.copyWith(
//   //             fontSize: 14,
//   //             color: Colors.redAccent,
//   //           ),
//   //         ),
//   //         SizedBox(height: 10),
//   //         PrimaryButton(
//   //           width: double.infinity,
//   //           onTap: () {
//   //             log("Player ID: ${player.id}");
//   //             log("Preferred: ${controller.selectedFavPosition?.id}");
//   //             log("Restricted: ${controller.selectedResPosition?.id}");
//   //           },
//   //           title: 'Add',
//   //           backgroundColor: AppColors.descriptiveTextColor,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   // Widget buildPlayerRes(player, FavoritePositionedController controller, List<Position> list) {
//   //   List<String> res=[];
//   //   return Container(
//   //     padding: EdgeInsets.all(16),
//   //     decoration: BoxDecoration(
//   //       color: Colors.indigo[50],
//   //       border: Border.all(color: AppColors.secondaryColor),
//   //       borderRadius: BorderRadius.circular(12.r),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Text(
//   //           player.firstName ?? "Player",
//   //           style: descriptionStyle.copyWith(
//   //             fontSize: 14,
//   //             color: AppColors.descriptiveTextColor,
//   //           ),
//   //         ),
//   //         SizedBox(height: 4),
//   //         Text(
//   //           'Player’s Restricted Positions',
//   //           style: descriptionStyle.copyWith(
//   //             fontSize: 14,
//   //             color: Colors.redAccent,
//   //           ),
//   //         ),
//   //         res.isNotEmpty?
//   //         Container(
//   //           height: 50,
//   //           width: 100,
//   //           decoration: BoxDecoration(
//   //         border: Border.all(color: Colors.black),
//   //     borderRadius: BorderRadius.circular(8), // optional
//   //   ),
//   //           child:Row(children: [
//   //
//   //
//   //             Text(res[ res.length - 1]),
//   //                 Spacer(),
//   //             Icon(Icons.arrow_drop_down)
//   //
//   //           ],),
//   //         ):SizedBox(),
//   //
//   //         SizedBox(height: 10),
//   //         DynamicDropdownList<Position?>(
//   //           items: list,
//   //           selectedItem: controller.selectedResPosition,
//   //           itemLabelBuilder: (item) => item?.name ?? 'N/A',
//   //           onChanged: (value) {
//   //             setState(() {
//   //               res.add(value!.name!);
//   //             });
//   //             controller.selectedResPosition = value;
//   //
//   //             print(res);
//   //             controller.update();
//   //           },
//   //         ),
//   //         SizedBox(height: 20),
//   //         PrimaryButton(
//   //           width: double.infinity,
//   //           onTap: () {
//   //             log("Player ID: ${player.id}");
//   //             log("Preferred: ${controller.selectedFavPosition?.id}");
//   //             log("Restricted: ${controller.selectedResPosition?.id}");
//   //           },
//   //           title: 'Add',
//   //           backgroundColor: AppColors.descriptiveTextColor,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
//
// class PlayerFavWidget extends StatefulWidget {
//   final dynamic player;
//   final FavoritePositionedController controller;
//   final List<Position> list;
//
//   const PlayerFavWidget({
//     Key? key,
//     required this.player,
//     required this.controller,
//     required this.list,
//   }) : super(key: key);
//
//   @override
//   _PlayerFavWidgetState createState() => _PlayerFavWidgetState();
// }
//
// class _PlayerFavWidgetState extends State<PlayerFavWidget> {
//   List<String> fav = [];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.indigo[50],
//         border: Border.all(color: AppColors.secondaryColor),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.player.firstName ?? "Player",
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: AppColors.descriptiveTextColor,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             'Player’s Preferred Positions',
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: AppColors.activeGreenColor,
//             ),
//           ),
//           fav.isNotEmpty
//               ? Row(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     height: 50,
//                     width:100,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Text(fav[fav.length - 1]),
//                         // Spacer(),
//                         Icon(Icons.arrow_drop_down),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       fav.removeLast();
//                       setState(() {});
//                     },
//                     // onTap: () => controller.removeDropdown(index),
//                     child: Container(
//
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.circular(5.r),
//                       ),
//                       child: const Icon(
//                         Icons.close,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   )
//                   // InkWell(
//                   //   onTap: () {
//                   //     fav.removeLast();
//                   //     setState(() {});
//                   //   },
//                   //   child: Container(
//                   //     alignment: Alignment.center,
//                   //     height: 30,
//                   //     width: 30,
//                   //     color: Colors.red,
//                   //
//                   //     child: Icon(Icons.clear, color: Colors.white),
//                   //   ),
//                   // ),
//                 ],
//               )
//               : SizedBox(),
//           SizedBox(height: 10),
//           DynamicDropdownList<Position?>(
//             items: widget.list,
//             selectedItem: widget.controller.selectedFavPosition,
//             itemLabelBuilder: (item) => item?.name ?? 'N/A',
//             onChanged: (value) {
//               setState(() {
//                 setState(() {
//                   fav.add(value!.name!);
//                 });
//                 widget.controller.selectedFavPosition = value;
//                 widget.controller.update();
//               });
//             },
//           ),
//           SizedBox(height: 10),
//
//           PrimaryButton(
//             width: double.infinity,
//             onTap: () {
//               log("Player ID: ${widget.player.id}");
//               log("Preferred: ${widget.controller.selectedFavPosition?.id}");
//               log("Restricted: ${widget.controller.selectedResPosition?.id}");
//             },
//             title: 'Add',
//             backgroundColor: AppColors.descriptiveTextColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PlayerResWidget extends StatefulWidget {
//   final dynamic player;
//   final FavoritePositionedController controller;
//   final List<Position> list;
//
//   const PlayerResWidget({
//     Key? key,
//     required this.player,
//     required this.controller,
//     required this.list,
//   }) : super(key: key);
//
//   @override
//   _PlayerResWidgetState createState() => _PlayerResWidgetState();
// }
//
// class _PlayerResWidgetState extends State<PlayerResWidget> {
//   List<String> res = [];
//   Position? selectedResPositio;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.indigo[50],
//         border: Border.all(color: AppColors.secondaryColor),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.player.firstName ?? "Player",
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: AppColors.descriptiveTextColor,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             'Player’s Restricted Positions',
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: Colors.redAccent,
//             ),
//           ),
//           res.isNotEmpty
//               ? Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 0),
//                 height: 50,
//                 // width:100,
//                 // width: 100,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Text(res[res.length - 1]),
//                     Spacer(),
//                     Icon(Icons.arrow_drop_down),
//                   ],
//                 ),
//               ),
//
//
//               InkWell(
//                 onTap: () {
//                   res.removeLast();
//                   setState(() {});
//                 },
//                 // onTap: () => controller.removeDropdown(index),
//                 child: Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor,
//                     borderRadius: BorderRadius.circular(5.r),
//                   ),
//                   child: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               )
//
//               // InkWell(
//               //   onTap: () {
//               //     res.removeLast();
//               //     setState(() {});
//               //   },
//               //   child: Container(
//               //     alignment: Alignment.center,
//               //     height: 30,
//               //     width: 30,
//               //     color: Colors.red,
//               //
//               //     child: Icon(Icons.clear, color: Colors.white),
//               //   ),
//               // ),
//             ],
//           )
//               : SizedBox(),
//           SizedBox(height: 10),
//           DynamicDropdownList<Position?>(
//             items: widget.list,
//             selectedItem: selectedResPositio,
//             itemLabelBuilder: (item) => item?.name ?? 'N/A',
//             onChanged: (value) {
//               if (value != null) {
//                 setState(() {
//                   res.add(value.name!);
//                   selectedResPositio = value;
//                 });
//
//                 widget.controller.update();
//               }
//             },
//           ),
//           SizedBox(height: 20),
//           PrimaryButton(
//             width: double.infinity,
//             onTap: () {
//               log("Player ID: ${widget.player.id}");
//               log("Preferred: ${widget.controller.selectedFavPosition?.id}");
//               log("Restricted: ${widget.controller.selectedResPosition?.id}");
//             },
//             title: 'Add',
//             backgroundColor: AppColors.descriptiveTextColor,
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import 'package:gaming_web_app/Base/model/positioned.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/app_text_styles.dart';
// import 'package:gaming_web_app/constants/widgets/drop_down/dynamic_dropdown_list.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
//
// import '../../Base/controller/teamController/createTeamController.dart';
// import '../../Base/controller/teamController/favoritPositionedConteroller.dart';
// import '../../Base/controller/teamController/teamController.dart';
//
// class SetFavoredPositionDialog extends StatefulWidget {
//   const SetFavoredPositionDialog({super.key});
//
//   @override
//   State<SetFavoredPositionDialog> createState() =>
//       _SetFavoredPositionDialogState();
// }
//
// class _SetFavoredPositionDialogState extends State<SetFavoredPositionDialog> {
//   final NewTeamController controller = Get.find<NewTeamController>();
//   final TeamController teamController = Get.find<TeamController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final players = teamController.getPlayer;
//
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.zero,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.9,
//           maxWidth: MediaQuery.of(context).size.width * 0.95,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: List.generate(players.length, (index) {
//               final player = players[index];
//               // Create a new copy of each Position object with index-specific data if needed
//               final postioned = teamController.teamPositioned
//                   .whereType<Position>()
//                   .map((e) => e.copyWith()) // new instance
//                   .toList();
//               // final postioned = teamController.teamPositioned.whereType<Position>().toList();
//
//               final controllerTag = 'controller_$index';
//
//               final favoriteController = Get.put(
//                 FavoritePositionedController(),
//                 tag: controllerTag,
//               );
//
//               return SizedBox(
//                 width: double.infinity,
//                 child: GetBuilder<FavoritePositionedController>(
//                   tag: controllerTag,
//                   builder: (ctrl) {
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(child: buildPlayerFav(player, ctrl,postioned)),
//                         SizedBox(width: 12),
//                         Expanded(child: buildPlayerRes(player, ctrl,postioned)),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPlayerFav(player, FavoritePositionedController controller,List<Position> li) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.indigo[50],
//         border: Border.all(color: AppColors.secondaryColor),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             player.firstName ?? "Player",
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: AppColors.descriptiveTextColor,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             'Player’s Preferred Positions',
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: AppColors.activeGreenColor,
//             ),
//           ),
//           SizedBox(height: 10),
//
//           DynamicDropdownList<Position?>(
//             items: li,
//             // controller.favPositioned,
//             selectedItem: controller.selectedFavPosition,
//             itemLabelBuilder: (item) => item?.name ?? 'N/A',
//             onChanged: (value) {
//               // setState(() {
//                 controller.selectedFavPosition = value;
//               // });
//             },
//           ),
//           SizedBox(height: 20),
//
//           Text(
//             'Player’s Restricted Positions',
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: Colors.redAccent,
//             ),
//           ),
//           SizedBox(height: 10),
//
//           // DynamicDropdownList<Position?>(
//           //   items: controller.resPositioned,
//           //   selectedItem: controller.selectedResPosition,
//           //   itemLabelBuilder: (item) => item?.name ?? 'N/A',
//           //   onChanged: (value) {
//           //     setState(() {
//           //       controller.selectedResPosition = value;
//           //     });
//           //   },
//           // ),
//           SizedBox(height: 20),
//
//           PrimaryButton(
//             width: double.infinity,
//             onTap: () {
//               log("Player ID: ${player.id}");
//               log("Preferred: ${controller.selectedFavPosition?.id}");
//               log("Restricted: ${controller.selectedResPosition?.id}");
//               // Call controller/teamController methods here if needed
//             },
//             title: 'Add',
//             backgroundColor: AppColors.descriptiveTextColor,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPlayerRes(player, FavoritePositionedController controller,List<Position> li) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.indigo[50],
//         border: Border.all(color: AppColors.secondaryColor),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             player.firstName ?? "Player",
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: AppColors.descriptiveTextColor,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             'Player’s Preferred Positions',
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: AppColors.activeGreenColor,
//             ),
//           ),
//           SizedBox(height: 10),
//
//           // DynamicDropdownList<Position?>(
//           //   items: controller.favPositioned,
//           //   selectedItem: controller.selectedFavPosition,
//           //   itemLabelBuilder: (item) => item?.name ?? 'N/A',
//           //   onChanged: (value) {
//           //     setState(() {
//           //       controller.selectedFavPosition = value;
//           //     });
//           //   },
//           // ),
//           // SizedBox(height: 20),
//
//           Text(
//             'Player’s Restricted Positions',
//             style: descriptionStyle.copyWith(
//               fontSize: 14,
//               color: Colors.redAccent,
//             ),
//           ),
//           SizedBox(height: 10),
//
//           DynamicDropdownList<Position?>(
//             items:li,
//             // controller.resPositioned,
//             selectedItem: controller.selectedResPosition,
//             itemLabelBuilder: (item) => item?.name ?? 'N/A',
//             onChanged: (value) {
//               // setState(() {
//                 controller.selectedResPosition = value;
//               // });
//             },
//           ),
//           SizedBox(height: 20),
//
//           PrimaryButton(
//             width: double.infinity,
//             onTap: () {
//               log("Player ID: ${player.id}");
//               log("Preferred: ${controller.selectedFavPosition?.id}");
//               log("Restricted: ${controller.selectedResPosition?.id}");
//             },
//             title: 'Add',
//             backgroundColor: AppColors.descriptiveTextColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/model/player/getPlayerModel.dart';
import 'package:get/get.dart';

import 'package:gaming_web_app/Base/model/positioned.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
import 'package:gaming_web_app/constants/widgets/drop_down/dynamic_dropdown_list.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';

import '../../Base/controller/teamController/createTeamController.dart';
import '../../Base/controller/teamController/favoritPositionedConteroller.dart';
import '../../Base/controller/teamController/teamController.dart';
import '../../utils/snackbarUtils.dart';

class SetFavoredPositionDialog extends StatefulWidget {
  const SetFavoredPositionDialog({super.key});

  @override
  State<SetFavoredPositionDialog> createState() =>
      _SetFavoredPositionDialogState();
}

class _SetFavoredPositionDialogState extends State<SetFavoredPositionDialog> {
  final NewTeamController controller = Get.find<NewTeamController>();
  final TeamController teamController = Get.find<TeamController>();

  // final int playerId;

  @override
  Widget build(BuildContext context) {
    final players = teamController.getPlayer;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          maxWidth: MediaQuery.of(context).size.width * 0.95,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(players.length, (index) {
              GetPlayer? player = players[index];

              final favoritePositionedController = Get.put(
                FavoritePositionedController(),
                tag: 'controller_$index',
              );

              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   favoritePositionedController.getData();
              // });

              return SizedBox(
                width: double.infinity,
                child: GetBuilder<FavoritePositionedController>(
                  tag: 'controller_$index',
                  builder: (controller) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: PlayerFavWidget(
                                player!,
                                controller.favPositioned,
                                controller,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: PlayerResWidget(
                                player!,
                                controller.resPositioned,
                                controller,
                              ),
                            ),
                          ],
                        ),

                        Divider(),
                      ],
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
    ;
  }

  void keyAddFav() {
    setState(() {
      addFavKeys = GlobalKey();
    });
  }

  var addFavKeys = GlobalKey();
  // Widget buildPlayerFav(player, List<Position?> positined, var controller) {
  //   int isShow=1;
  //   addFavKeys=GlobalKey();
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       // color: Colors.indigo[50],
  //       // border: Border.all(color: AppColors.secondaryColor),
  //       // borderRadius: BorderRadius.circular(12.r),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           player.firstName ?? "Player",
  //           style: descriptionStyle.copyWith(
  //             fontSize: 14,
  //             color: AppColors.descriptiveTextColor,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           'Player’s Preferred Positions',
  //           style: descriptionStyle.copyWith(
  //             fontSize: 14,
  //             color: AppColors.activeGreenColor,
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //         controller.fav.isNotEmpty
  //             ? Column(
  //           children: List.generate(controller.fav.length, (index) {
  //             final item = controller.fav[index];
  //
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 8.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   // Item display container
  //                   Container(
  //                     height: 50,
  //                     width: 200,
  //                     decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.black),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                       child: Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text(
  //                               item.name ?? 'No Name',
  //                               style: TextStyle(fontSize: 16),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ),
  //                           Icon(Icons.arrow_drop_down),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //
  //                   SizedBox(width: 20),
  //
  //                   // Delete button
  //                   InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         controller.resPositioned.add(controller.fav[index]);
  //                         controller.favPositioned.add(controller.fav[index]);
  //                         keyAddRes();
  //                         keyAddFav();
  //                         controller.fav.removeAt(index);
  //
  //                       });
  //
  //                       // You might want to add setState() or update the UI here
  //                       // if controller.res is not an observable list
  //                     },
  //                     borderRadius: BorderRadius.circular(5),
  //                     child: Container(
  //                       height: 50,
  //                       width: 50,
  //                       decoration: BoxDecoration(
  //                         color: AppColors.primaryColor,
  //                         borderRadius: BorderRadius.circular(5),
  //                       ),
  //                       child: Icon(
  //                         Icons.close,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }),
  //         )
  //
  //         // Row(
  //         //       children: [
  //         //         Container(
  //         //           margin: EdgeInsets.symmetric(horizontal: 0),
  //         //           height: 50,
  //         //           width: 150,
  //         //           decoration: BoxDecoration(
  //         //             border: Border.all(color: Colors.black),
  //         //             borderRadius: BorderRadius.circular(8),
  //         //           ),
  //         //           child: Row(
  //         //             children: [
  //         //               Text(
  //         //                "   ${controller!.fav![controller.fav.length - 1].name}"
  //         //                     .toString(),
  //         //               ),
  //         //               Spacer(),
  //         //               Icon(Icons.arrow_drop_down),
  //         //             ],
  //         //           ),
  //         //         ),
  //         //         SizedBox(width: 50,),
  //         //         InkWell(
  //         //           onTap: () {
  //         //             if (controller.fav.isNotEmpty) {
  //         //               // controller.selectedFavPosition.add(controller.fav.last); // Save last
  //         //               controller.fav.removeLast(); // Then remove it
  //         //             }
  //         //             setState(() {});
  //         //           },
  //         //           // onTap: () => controller.removeDropdown(index),
  //         //           child: Container(
  //         //             height: 50,
  //         //             width: 50,
  //         //             padding: const EdgeInsets.all(4),
  //         //             decoration: BoxDecoration(
  //         //               color: AppColors.primaryColor,
  //         //               borderRadius: BorderRadius.circular(5.r),
  //         //             ),
  //         //             child: const Icon(
  //         //               Icons.close,
  //         //               color: Colors.white,
  //         //               size: 20,
  //         //             ),
  //         //           ),
  //         //         ),
  //         //       ],
  //         //     )
  //             : SizedBox(),
  //         SizedBox(height: 10),
  //
  //         /// Restricted Position Dropdown
  //         isShow ==1?
  //         DynamicDropdownList<Position?>(
  //           key:addFavKeys,
  //           items: controller.favPositioned,
  //           selectedItem: controller.selectedFavPosition ?? null,
  //           // must be one of items,
  //           itemLabelBuilder: (item) => item?.name ?? 'N/A',
  //           onChanged: (value) {
  //             setState(() {
  //
  //                 isShow=0;
  //
  //               // controller.fav.add(value);
  //               // int index = controller.favPositioned.indexWhere((position) => position?.id == value!.id);
  //               // if (index != -1) {
  //               //   controller.favPositioned.removeAt(index);
  //               // }
  //
  //               controller.selectedFavPosition = value;
  //             });
  //             // controller.addPositioned(value);
  //             bool exists = controller.fav.any((item) => item.id == value!.id);
  //             bool exist = controller.res.any((item) => item.id == value!.id);
  //             if(exist){
  //               SnackbarUtils.showErrorr("This value Exist in Restrict Positioned");
  //                // print("this value exist in Restrict Positioned");
  //
  //             }else{
  //             if (!exists) {
  //               controller.fav.add(value);
  //               int index = controller.favPositioned.indexWhere((position) => position?.id == value!.id);
  //               if (index != -1) {
  //                 controller.resPositioned.removeAt(index);
  //                 controller.favPositioned.removeAt(index);
  //                 keyAddRes();
  //                 keyAddFav();
  //               }
  //             } else {
  //               SnackbarUtils.showErrorr("This value Already Exist");
  //             }
  //
  //             }
  //
  //
  //             // setState(() {
  //             //   // controller.fav.add(value);
  //             //   // int index = controller.favPositioned.indexWhere((position) => position?.id == value!.id);
  //             //   // if (index != -1) {
  //             //   //   controller.favPositioned.removeAt(index);
  //             //   // }
  //             //
  //             //   controller.selectedFavPosition = value;
  //             // });
  //             // log("Restricted Position: ${value?.id}");
  //             // teamController.updateRestrictedPosition(player.id, value?.id ?? 0);
  //           },
  //         ):SizedBox(),
  //         SizedBox(height: 20),
  //
  //         PrimaryButton(
  //           width: double.infinity,
  //           onTap: () {
  //             setState(() {
  //               isShow=1;
  //             });
  //
  //             // List<int> favIds = controller.fav
  //             //     .where((position) => position?.id != null)  // filter out nulls
  //             //     .map((position) => position!.id!)           // safely extract non-null ids
  //             //     .toList();
  //
  //             List<int> favIds = controller.fav
  //                 .where((position) => position?.id != null)
  //                 .map((position) => position!.id!)
  //                 .toList()
  //                 .cast<int>(); // 👈 Cast here
  //
  //             int index = teamController.playerPreference.indexWhere((element) => element.playerId == player.id);
  //
  //             if (index != -1) {
  //               teamController.playerPreference[index].preferredPositionIds=favIds;
  //               SnackbarUtils.showSuccess("Successfully Added");
  //               print('Found at index: $index');
  //             } else {
  //               SnackbarUtils.showErrorr("Please Select Favorite Position");
  //               // print('Player with ID $targetPlayerId not found');
  //             }
  //             // teamController.submitPreferences(player.id);
  //           },
  //           title: 'Add',
  //           backgroundColor: AppColors.descriptiveTextColor,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  void keyAddRes() {
    setState(() {
      addResKeys = GlobalKey();
    });
  }

  var addResKeys = GlobalKey();

  // Widget buildPlayerRes(player, List<Position?> positined, var controller) {
  //   addResKeys=GlobalKey();
  //   int isShow=1;
  //
  //   final TeamController teamController = Get.find<TeamController>();
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       // color: Colors.indigo[50],
  //       // border: Border.all(color: AppColors.secondaryColor),
  //       // borderRadius: BorderRadius.circular(12.r),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //          "       ",
  //           style: descriptionStyle.copyWith(
  //             fontSize: 14,
  //             color: AppColors.descriptiveTextColor,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //
  //         Text(
  //           'Player’s Restricted Positions',
  //           style: descriptionStyle.copyWith(
  //             fontSize: 14,
  //             color: Colors.redAccent,
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //         controller.res.isNotEmpty
  //             ?  Column(
  //           children: List.generate(controller.res.length, (index) {
  //             final item = controller.res[index];
  //
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 8.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   // Item display container
  //                   Container(
  //                     height: 50,
  //                     width: 200,
  //                     decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.black),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                       child: Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text(
  //                               item.name ?? 'No Name',
  //                               style: TextStyle(fontSize: 16),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ),
  //                           Icon(Icons.arrow_drop_down),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //
  //                   SizedBox(width: 20),
  //
  //                   // Delete button
  //                   InkWell(
  //                     onTap: () {
  //                          setState(() {
  //                            controller.resPositioned.add(controller.res[index]);
  //                            controller.favPositioned.add(controller.res[index]);
  //                            keyAddRes();
  //                            keyAddFav();
  //                            controller.res.removeAt(index);
  //                          });
  //
  //                       // You might want to add setState() or update the UI here
  //                       // if controller.res is not an observable list
  //                     },
  //                     borderRadius: BorderRadius.circular(5),
  //                     child: Container(
  //                       height: 50,
  //                       width: 50,
  //                       decoration: BoxDecoration(
  //                         color: AppColors.primaryColor,
  //                         borderRadius: BorderRadius.circular(5),
  //                       ),
  //                       child: Icon(
  //                         Icons.close,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }),
  //         )
  //
  //
  //       // Row(
  //         //       children: [
  //         //         Container(
  //         //           margin: EdgeInsets.symmetric(horizontal: 0),
  //         //           height: 50,
  //         //           width: 200,
  //         //           decoration: BoxDecoration(
  //         //             border: Border.all(color: Colors.black),
  //         //             borderRadius: BorderRadius.circular(8),
  //         //           ),
  //         //           child: Row(
  //         //             children: [
  //         //               Text(
  //         //                "   ${controller!.res![controller.res.length - 1].name}"
  //         //                     .toString(),
  //         //               ),
  //         //               Spacer(),
  //         //               Icon(Icons.arrow_drop_down),
  //         //             ],
  //         //           ),
  //         //         ),
  //         //         SizedBox(width: 50,),
  //         //         InkWell(
  //         //           onTap: () {
  //         //             if (controller.res.isNotEmpty) {
  //         //               // controller.selectedFavPosition.add(controller.res.last); // Save last
  //         //               controller.res.removeLast(); // Then remove it
  //         //             }
  //         //
  //         //             setState(() {});
  //         //           },
  //         //           // onTap: () => controller.removeDropdown(index),
  //         //           child: Container(
  //         //             height: 50,
  //         //             width: 50,
  //         //             padding: const EdgeInsets.all(4),
  //         //             decoration: BoxDecoration(
  //         //               color: AppColors.primaryColor,
  //         //               borderRadius: BorderRadius.circular(5.r),
  //         //             ),
  //         //             child: const Icon(
  //         //               Icons.close,
  //         //               color: Colors.white,
  //         //               size: 20,
  //         //             ),
  //         //           ),
  //         //         ),
  //         //       ],
  //         //     )
  //             : SizedBox(),
  //         SizedBox(height: 10),
  //
  //         /// Restricted Position Dropdown
  //         isShow ==1?   DynamicDropdownList<Position?>(
  //           key: addResKeys,
  //           items:controller.resPositioned,
  //           selectedItem:
  //               controller.selectedResPosition != null
  //                   ? controller.selectedResPosition
  //                   : positined[0],
  //           // must be one of items,
  //           itemLabelBuilder: (item) => item?.name ?? 'N/A',
  //           onChanged: (value) {
  //             setState(() {
  //               isShow =0;
  //             });
  //             bool exists = controller.fav.any((item) => item.id == value!.id);
  //             if(exists){
  //              SnackbarUtils.showErrorr("This value Exist in Favorite Positioned");
  //               print("this value Exist in Favorite Positioned");
  //
  //             }else {
  //               bool exists = controller.res.any((item) =>
  //               item.id == value!.id);
  //               if (!exists) {
  //                 controller.res.add(value);
  //                 int index = controller.resPositioned.indexWhere((position) => position?.id == value!.id);
  //                 if (index != -1) {
  //                   controller.resPositioned.removeAt(index);
  //                   controller.favPositioned.removeAt(index);
  //                   keyAddRes();
  //                   keyAddFav();
  //                 }
  //               } else {
  //                 SnackbarUtils.showErrorr("This value Already Exist");
  //                 print("Value already exists");
  //               }
  //             }
  //             // int index = controller.resPositioned.indexWhere((position) => position?.id == value!.id);
  //             // controller.res.add(value);
  //             // controller.selectedResPosition = value;
  //
  //             // if (index != -1) {
  //             //   controller.resPositioned.removeAt(index);
  //             // }
  //
  //             // log("Restricted Position: ${value?.id}");
  //             // teamController.updateRestrictedPosition(player.id, value?.id ?? 0);
  //           },
  //         ):SizedBox(),
  //         SizedBox(height: 20),
  //
  //         PrimaryButton(
  //           width: double.infinity,
  //           onTap: () {
  //             setState(() {
  //               isShow =1;
  //             });
  //             List<int> resIds = controller.res
  //                 .where((position) => position?.id != null)
  //                 .map((position) => position!.id!)
  //                 .toList()
  //                 .cast<int>(); // 👈 Cast here
  //             int index = teamController.playerPreference.indexWhere((element) => element.playerId == player.id);
  //
  //             if (index != -1) {
  //               teamController.playerPreference[index].restrictedPositionIds=resIds;
  //               SnackbarUtils.showSuccess("Successfully Added");
  //               print('Found at index: $index');
  //             } else {
  //               SnackbarUtils.showErrorr("Please Select Restrict Positioned");
  //               // print('Player with ID $targetPlayerId not found');
  //             }
  //             // teamController.submitPreferences(player.id);
  //           },
  //           title: 'Add',
  //           backgroundColor: AppColors.descriptiveTextColor,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

void keyAddRes() {
  addResKeys = GlobalKey();
}

var addResKeys = GlobalKey();

void keyAddFav() {
  addFavKeys = GlobalKey();
}

var addFavKeys = GlobalKey();

class PlayerFavWidget extends StatefulWidget {
  final GetPlayer player;
  final List<Position?>? positined;
  final controller;

  PlayerFavWidget(this.player, this.positined, this.controller);

  @override
  _PlayerFavWidgetState createState() => _PlayerFavWidgetState();
}

class _PlayerFavWidgetState extends State<PlayerFavWidget> {
  int isShow = 0;
  final GlobalKey addFavKeys = GlobalKey();
  final TeamController teamController = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    final player = widget.player;
    final controller = widget.controller;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Your decoration here
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            player!.firstName ?? "Player",
            style: descriptionStyle.copyWith(
              fontSize: 14,
              color: AppColors.descriptiveTextColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Player’s Preferred Positions',
            style: descriptionStyle.copyWith(
              fontSize: 14,
              color: AppColors.activeGreenColor,
            ),
          ),
          SizedBox(height: 10),
          // Display favorite items
          controller.fav.isNotEmpty
              ? Column(
                children: List.generate(controller.fav.length, (index) {
                  final item = controller.fav[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Item display container
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.name ?? 'No Name',
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Delete button
                        InkWell(
                          onTap: () {
                            setState(() {
                              controller.resPositioned.add(
                                controller.fav[index],
                              );
                              controller.favPositioned.add(
                                controller.fav[index],
                              );
                              keyAddRes();
                              keyAddFav();
                              controller.fav.removeAt(index);
                            });
                          },
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
              : SizedBox(),
          SizedBox(height: 10),
          // Restricted Position Dropdown
          isShow == 1
              ? DynamicDropdownList<Position?>(
                key: addFavKeys,
                items: controller.favPositioned,
                selectedItem: controller.selectedFavPosition ?? null,
                itemLabelBuilder: (item) => item?.name ?? 'N/A',
                onChanged: (value) {
                  if (value!.name != "OUT") {
                    setState(() {
                      isShow = 0;
                      controller.selectedFavPosition = value;
                    });

                    bool exists = controller.fav.any(
                      (item) => item.id == value!.id,
                    );
                    bool exist = controller.res.any(
                      (item) => item.id == value!.id,
                    );
                    if (exist) {
                      SnackbarUtils.showErrorr(
                        "This value Exist in Restrict Positioned",
                      );
                    } else {
                      if (!exists) {
                        controller.fav.add(value);
                        int index = controller.favPositioned.indexWhere(
                          (position) => position?.id == value!.id,
                        );
                        if (index != -1) {
                          controller.resPositioned.removeAt(index);
                          controller.favPositioned.removeAt(index);
                          // controller.resPositioned.refresh();
                          keyAddRes();
                          keyAddFav();
                        }
                      } else {
                        SnackbarUtils.showErrorr("This value Already Exist");
                      }
                    }
                  } else {
                    SnackbarUtils.showErrorr("Out Position not Add");
                  }
                },
              )
              : SizedBox(),
          SizedBox(height: 20),
          PrimaryButton(
            width: double.infinity,
            onTap: () {
              setState(() {
                isShow = 1;
              });
              List<int> favIds =
                  controller.fav
                      .where((position) => position?.id != null)
                      .map((position) => position!.id!)
                      .toList()
                      .cast<int>();

              int index = teamController.playerPreference.indexWhere(
                (element) => element.playerId == player!.id,
              );

              if (index != -1) {
                teamController.playerPreference[index].preferredPositionIds =
                    favIds;
                SnackbarUtils.showSuccess("Successfully Added");
                print('Found at index: $index');
              } else {
                SnackbarUtils.showErrorr("Please Select Favorite Position");
              }
            },
            title: 'Add',
            backgroundColor: AppColors.descriptiveTextColor,
          ),
        ],
      ),
    );
  }
}

class PlayerResWidget extends StatefulWidget {
  final GetPlayer? player;
  final List<Position?>? positined;
  final dynamic controller; // Replace with your controller's type

  const PlayerResWidget(this.player, this.positined, this.controller);

  @override
  _PlayerResWidgetState createState() => _PlayerResWidgetState();
}

class _PlayerResWidgetState extends State<PlayerResWidget> {
  final GlobalKey addResKeys = GlobalKey();
  int isShow = 0;
  final TeamController teamController = Get.find<TeamController>();
  @override
  void initState() {
    super.initState();
    // Initialize your controller, e.g.,
    // teamController = Get.find<TeamController>();
    // Or pass it as a parameter if needed.
    // For example:
    // this.teamController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;
    final controller = widget.controller;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Your decoration here
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "       ",
            style: descriptionStyle.copyWith(
              fontSize: 14,
              color: AppColors.descriptiveTextColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Player’s Restricted Positions',
            style: descriptionStyle.copyWith(
              fontSize: 14,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(height: 10),
          controller.res.isNotEmpty
              ? Column(
                children: List.generate(controller.res.length, (index) {
                  final item = controller.res[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Item display container
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.name ?? 'No Name',
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Delete button
                        InkWell(
                          onTap: () {
                            setState(() {
                              controller.resPositioned.add(
                                controller.res[index],
                              );
                              controller.favPositioned.add(
                                controller.res[index],
                              );
                              keyAddRes();
                              keyAddFav();
                              controller.res.removeAt(index);
                            });
                          },
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
              : SizedBox(),
          SizedBox(height: 10),

          /// Restricted Position Dropdown
          isShow == 1
              ? DynamicDropdownList<Position?>(
                key: addResKeys,
                items: controller.resPositioned,
                selectedItem:
                    controller.selectedResPosition ??
                    (widget.positined!.isNotEmpty
                        ? widget.positined![0]
                        : null),
                itemLabelBuilder: (item) => item?.name ?? 'N/A',
                onChanged: (value) {
                  if (value!.name != "OUT") {
                    setState(() {
                      isShow = 0;
                    });
                    bool existsInFav = controller.fav.any(
                      (item) => item.id == value!.id,
                    );
                    if (existsInFav) {
                      SnackbarUtils.showErrorr(
                        "This value Exist in Favorite Positioned",
                      );
                    } else {
                      bool existsInRes = controller.res.any(
                        (item) => item.id == value!.id,
                      );
                      if (!existsInRes) {
                        controller.res.add(value);
                        int index = controller.resPositioned.indexWhere(
                          (position) => position?.id == value!.id,
                        );
                        if (index != -1) {
                          controller.resPositioned.removeAt(index);
                          controller.favPositioned.removeAt(index);
                          keyAddRes();
                          keyAddFav();
                        }
                      } else {
                        SnackbarUtils.showErrorr("This value Already Exist");
                      }
                    }
                  } else {
                    SnackbarUtils.showErrorr("Out Position not Add");
                  }
                },
              )
              : SizedBox(),
          SizedBox(height: 20),
          PrimaryButton(
            width: double.infinity,
            onTap: () {
              setState(() {
                isShow = 1;
              });
              List<int> resIds =
                  controller.res
                      .where((position) => position?.id != null)
                      .map((position) => position!.id!)
                      .toList();

              int index = teamController.playerPreference.indexWhere(
                (element) => element.playerId == player!.id,
              );

              if (index != -1) {
                teamController.playerPreference[index].restrictedPositionIds =
                    resIds;
                SnackbarUtils.showSuccess("Successfully Added");
              } else {
                SnackbarUtils.showErrorr("Please Select Restrict Positioned");
              }
            },
            title: 'Add',
            backgroundColor: AppColors.descriptiveTextColor,
          ),
        ],
      ),
    );
  }
}
