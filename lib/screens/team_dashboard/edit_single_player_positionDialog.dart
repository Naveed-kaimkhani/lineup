// import 'package:flutter/material.dart';
// import 'package:gaming_web_app/Base/controller/teamController/favoritPositionedConteroller.dart';
// import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
// import 'package:gaming_web_app/Base/model/player/getPlayerModel.dart';
// import 'package:gaming_web_app/Base/model/playerPositioned.dart';
// import 'package:gaming_web_app/Base/model/positioned.dart';
// import 'package:gaming_web_app/constants/app_colors.dart';
// import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
// import 'package:gaming_web_app/screens/main_dashboard/setFavouritPosition.dart';
// import 'package:gaming_web_app/utils/snackbarUtils.dart';
// import 'package:get/get.dart';

// class EditSinglePlayerPositionDialog extends StatefulWidget {
//   final GetPlayer player;

//   const EditSinglePlayerPositionDialog({super.key, required this.player});

//   @override
//   State<EditSinglePlayerPositionDialog> createState() =>
//       _EditSinglePlayerPositionDialogState();
// }

// class _EditSinglePlayerPositionDialogState
//     extends State<EditSinglePlayerPositionDialog> {
//   final TeamController teamController = Get.find<TeamController>();

//   late FavoritePositionedController controller;
// final List<Position> dummyPositions = [
//   Position(id: 1, name: 'P'),
//   Position(id: 2, name: 'C'),
//   Position(id: 3, name: '1B'),
//   Position(id: 4, name: '2B'),
//   Position(id: 5, name: '3B'),
//   Position(id: 6, name: 'SS'),
//   Position(id: 7, name: 'LF'),
//   Position(id: 8, name: 'RF'),
//   Position(id: 9, name: 'CF'),
//   Position(id: 10, name: 'OUT'),
// ];

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(FavoritePositionedController(), tag: 'single_player');

//     // Initialize with existing preferences
//     final index = teamController.playerPreference.indexWhere(
//       (e) => e.playerId == widget.player.id,
//     );

//     if(index != -1) {
//       final pref = teamController.playerPreference[index];
//       controller.fav = teamController.getPositionsByIds(pref.preferredPositionIds);
//       controller.res = teamController.getPositionsByIds(pref.restrictedPositionIds);

//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(16),
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.9,
//           maxWidth: MediaQuery.of(context).size.width * 0.8,
//         ),
//         child: GetBuilder<FavoritePositionedController>(
//           tag: 'single_player',
//           builder: (controller) {
//             return SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "${widget.player.firstName}'s Positions",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Divider(),
//                   PlayerFavWidget(
//                     widget.player,
//                     controller.favPositioned,
//                     controller,
//                   ),
//                   SizedBox(height: 20),
//                   PlayerResWidget(
//                     widget.player,
//                     controller.resPositioned,
//                     controller,
//                   ),
//                   SizedBox(height: 20),
//                   PrimaryButton(
//                     title: "Save",
//                     width: double.infinity,
//                     onTap: () {
//                       List<int> favIds =
//                           controller.fav
//                               .where((p) => p?.id != null)
//                               .map((p) => p!.id!)
//                               .toList();

//                       List<int> resIds =
//                           controller.res
//                               .where((p) => p?.id != null)
//                               .map((p) => p!.id!)
//                               .toList();

//                       final index = teamController.playerPreference.indexWhere(
//                         (e) => e.playerId == widget.player.id,
//                       );

//                       if (index != -1) {
//                         teamController
//                             .playerPreference[index]
//                             .preferredPositionIds = favIds;
//                         teamController
//                             .playerPreference[index]
//                             .restrictedPositionIds = resIds;
//                       } else {
//                         teamController.playerPreference.add(
//                           PlayerPreference(
//                             playerId: widget.player.id,
//                             preferredPositionIds: favIds,
//                             restrictedPositionIds: resIds,
//                           ),
//                         );
//                       }

//                       SnackbarUtils.showSuccess("Player position updated");
//                       Navigator.pop(context);
//                     },
//                     backgroundColor: AppColors.primaryColor,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/controller/getTeamData.dart';
import 'package:gaming_web_app/Base/controller/teamController/favoritPositionedConteroller.dart';
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/Base/model/player/getPlayerModel.dart';
import 'package:gaming_web_app/Base/model/playerPositioned.dart';
import 'package:gaming_web_app/Base/model/positioned.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/screens/main_dashboard/setFavouritPosition.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:get/get.dart';

class EditSinglePlayerPositionDialog extends StatefulWidget {
  final GetPlayer player;
  // final int playerId;
  const EditSinglePlayerPositionDialog({super.key, required this.player});

  @override
  State<EditSinglePlayerPositionDialog> createState() =>
      _EditSinglePlayerPositionDialogState();
}

class _EditSinglePlayerPositionDialogState
    extends State<EditSinglePlayerPositionDialog> {
  final TeamController teamController = Get.find<TeamController>();

  late FavoritePositionedController controller;

  final List<Position> dummyPositions = [
    Position(id: 1, name: 'P'),
    Position(id: 2, name: 'C'),
    Position(id: 3, name: '1B'),
    Position(id: 4, name: '2B'),
    Position(id: 5, name: '3B'),
    Position(id: 6, name: 'SS'),
    Position(id: 7, name: 'LF'),
    Position(id: 8, name: 'RF'),
    Position(id: 9, name: 'CF'),
    Position(id: 10, name: 'OUT'),
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.put(FavoritePositionedController(), tag: 'single_player');

    // Just initialize empty lists (we're no longer loading previous ones)
    controller.fav.clear();
    controller.res.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: GetBuilder<FavoritePositionedController>(
          tag: 'single_player',
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.player.firstName}'s Positions",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  PlayerFavWidget(widget.player, dummyPositions, controller),
                  const SizedBox(height: 20),
                  PlayerResWidget(widget.player, dummyPositions, controller),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    title: "Save",
                    width: double.infinity,
                    onTap: () {
                      List<int> favIds =
                          controller.fav
                              .where((p) => p?.id != null)
                              .map((p) => p!.id!)
                              .toList();

                      List<int> resIds =
                          controller.res
                              .where((p) => p?.id != null)
                              .map((p) => p!.id!)
                              .toList();

                      final index = teamController.playerPreference.indexWhere(
                        (e) => e.playerId == widget.player.id,
                      );

                      if (index != -1) {
                        teamController
                            .playerPreference[index]
                            .preferredPositionIds = favIds;
                        teamController
                            .playerPreference[index]
                            .restrictedPositionIds = resIds;
                      } else {
                        teamController.playerPreference.add(
                          PlayerPreference(
                            playerId: widget.player.id,
                            preferredPositionIds: favIds,
                            restrictedPositionIds: resIds,
                          ),
                        );
                      }

                      SnackbarUtils.showSuccess("Player position updated");
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.primaryColor,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
