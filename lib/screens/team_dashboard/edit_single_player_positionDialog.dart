import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/controller/globlLoaderController.dart';
import 'package:gaming_web_app/Base/controller/teamController/fav_position_controller_single_user.dart';
import 'package:gaming_web_app/Base/controller/teamController/favoritPositionedConteroller.dart';
import 'package:gaming_web_app/Base/controller/teamController/player_position_controller.dart';
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/Base/model/player/getPlayerModel.dart';
import 'package:gaming_web_app/Base/model/playerPositioned.dart';
import 'package:gaming_web_app/Base/model/positioned.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:gaming_web_app/screens/main_dashboard/setFavouritPosition.dart';
import 'package:gaming_web_app/service/api/player_service_api.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:get/get.dart';

class EditSinglePlayerPositionDialog extends StatefulWidget {
  final GetPlayer player;

  const EditSinglePlayerPositionDialog({super.key, required this.player});

  @override
  State<EditSinglePlayerPositionDialog> createState() =>
      _EditSinglePlayerPositionDialogState();
}

class _EditSinglePlayerPositionDialogState
    extends State<EditSinglePlayerPositionDialog> {
  final TeamController teamController = Get.find<TeamController>();
  final PlayerPositionController positionController = Get.put(
    PlayerPositionController(),
  );

  late FavPositionControllerSingleUser controller; //yahn

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
  void _loadPlayerPositions() async {
    try {
      final preference = await PlayerService.fetchPlayerPreferences(
        widget.player.id,
      );

      controller.setInitialPositions(
        allPositions: dummyPositions,
        preferredIds: preference.preferredPositionIds,
        restrictedIds: preference.restrictedPositionIds,
      );
    } catch (e) {
      SnackbarUtils.showErrorr("Failed to load player positions.");
    }
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      FavPositionControllerSingleUser(),
      tag: 'single_player',
    ); //yahn
    controller.fav.clear();
    controller.res.clear();

    _loadPlayerPositions();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: GetBuilder<FavPositionControllerSingleUser>(
          tag: 'single_player',
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.player.firstName}'s Positions",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 24),
                  PlayerFavWidget(widget.player, dummyPositions, controller),
                  const SizedBox(height: 24),
                  PlayerResWidget(widget.player, dummyPositions, controller),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    title: "Save",
                    width: double.infinity,
                    onTap: () async {
                      final controllerLoading = Get.find<LoaderController>();
                      controllerLoading.isLoading.value = true;
              
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

                      final preference = PlayerPreference(
                        playerId: widget.player.id,
                        preferredPositionIds: favIds,
                        restrictedPositionIds: resIds,
                      );

                      try {
                        await positionController.savePreference(preference);
                        SnackbarUtils.showSuccess("Player position updated");
                        Navigator.pop(context);
                        // Navigator.pop(context);
                        controllerLoading.isLoading.value = false;
                      } catch (e) {
                        Navigator.pop(context);
                        SnackbarUtils.showErrorr("Error: ${e.toString()}");
                      }
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
