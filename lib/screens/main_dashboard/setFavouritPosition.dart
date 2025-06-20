import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/Base/model/player/getPlayerModel.dart';
import 'package:gaming_web_app/screens/main_dashboard/custom_editable_dropdown.dart';
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
                                player,
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
  void keyAddRes() {
    setState(() {
      addResKeys = GlobalKey();
    });
  }

  var addResKeys = GlobalKey();
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

  // final GlobalKey addFavKeys = GlobalKey();

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
            player.firstName ?? "Player",
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
                        GestureDetector(
                          onTap: () {},
                          child: Container(
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
              : SizedBox(height: 10),
          // controller.fav.isNotEmpty
          //     ? Column(
          //       children: List.generate(controller.fav.length, (index) {
          //         final item = controller.fav[index];

          //         return Padding(
          //           padding: const EdgeInsets.symmetric(vertical: 8.0),
          //           child: Row(
          //             children: [
          //               // Editable Custom Dropdown - NOW WITH UNIQUE SELECTION
          //               ConflictFreeDropdown<Position>(
          //                 key: ValueKey(
          //                   'fav_dropdown_$index',
          //                 ), // Unique key for each
          //                 items:
          //                     controller.favPositioned
          //                         .where(
          //                           (p) =>
          //                               // Show all available + currently selected item
          //                               !controller.fav.any(
          //                                 (f) => f.id == p?.id,
          //                               ) ||
          //                               p?.id == item.id,
          //                         )
          //                         .toList(),
          //                 selectedItem: item, // Use the item from fav list
          //                 itemLabelBuilder: (item) => item?.name ?? "na",
          //                 onChanged: (newValue) {
          //                   if (newValue == null) return;

          //                   setState(() {
          //                     // 1. Add old item back to available pool
          //                     controller.favPositioned.add(item);

          //                     // 2. Update the fav list with new selection
          //                     controller.fav[index] = newValue;

          //                     // 3. Remove new selection from available pool
          //                     controller.favPositioned.removeWhere(
          //                       (p) => p?.id == newValue.id,
          //                     );
          //                   });
          //                 },
          //                 width: 200,
          //               ),

          //               SizedBox(width: 20),
          //               // Delete Button remains same
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     controller.resPositioned.add(item);
          //                     controller.favPositioned.add(item);

          //                     controller.fav.removeAt(index);

          //                     controller.resPositioned.removeAt(index);
          //                   });
          //                 },
          //                 child: Container(
          //                   height: 50,
          //                   width: 50,
          //                   decoration: BoxDecoration(
          //                     color: AppColors.primaryColor,
          //                     borderRadius: BorderRadius.circular(5),
          //                   ),
          //                   child: Icon(Icons.close, color: Colors.white),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          //     )
          //     : SizedBox(height: 10),
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
                      (item) => item.id == value.id,
                    );
                    bool exist = controller.res.any(
                      (item) => item.id == value.id,
                    );
                    if (exist) {
                      SnackbarUtils.showErrorr(
                        "This value Exist in Restrict Positioned",
                      );
                    } else {
                      if (!exists) {
                        controller.fav.add(value);
                        int index = controller.favPositioned.indexWhere(
                          (position) => position?.id == value.id,
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
                (element) => element.playerId == player.id,
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
  // final GlobalKey addResKeys = GlobalKey();
  int isShow = 0;
  final TeamController teamController = Get.find<TeamController>();
  @override
  void initState() {
    super.initState();
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
          // controller.res.isNotEmpty
          //     ? Column(
          //       children: List.generate(controller.res.length, (index) {
          //         final item = controller.res[index];
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(vertical: 8.0),
          //           child: Row(
          //             children: [
          //               // Editable Dropdown for restricted position
          //               ConflictFreeDropdown<Position>(
          //                 key: ValueKey('res_dropdown_$index'),
          //                 items:
          //                     controller.resPositioned
          //                         .where(
          //                           (p) =>
          //                               !controller.res.any(
          //                                 (r) => r.id == p?.id,
          //                               ) ||
          //                               p?.id == item.id,
          //                         )
          //                         .toList(),
          //                 selectedItem: item,
          //                 itemLabelBuilder: (item) => item?.name ?? 'N/A',
          //                 onChanged: (newValue) {
          //                   if (newValue == null) return;

          //                   setState(() {
          //                     // Add old item back to available list
          //                     controller.resPositioned.add(item);

          //                     // Update with new selection
          //                     controller.res[index] = newValue;

          //                     // Remove new selection from available list
          //                     controller.resPositioned.removeWhere(
          //                       (p) => p?.id == newValue.id,
          //                     );
          //                   });
          //                 },
          //                 width: 200,
          //               ),
          //               SizedBox(width: 20),
          //               // Delete button
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     controller.resPositioned.add(item);
          //                     controller.favPositioned.add(item);
          //                     controller.res.removeAt(index);
          //                   });
          //                 },
          //                 child: Container(
          //                   height: 50,
          //                   width: 50,
          //                   decoration: BoxDecoration(
          //                     color: AppColors.primaryColor,
          //                     borderRadius: BorderRadius.circular(5),
          //                   ),
          //                   child: Icon(Icons.close, color: Colors.white),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          //     )
          //     : SizedBox(),
          SizedBox(height: 10),

          /// Restricted Position Dropdown
          isShow == 1
              ? DynamicDropdownList<Position?>(
                key: addResKeys,

                // key: GlobalKey(), // 👈 Yeh har bar rebuild ko force karega
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
                      (item) => item.id == value.id,
                    );
                    if (existsInFav) {
                      SnackbarUtils.showErrorr(
                        "This value Exist in Favorite Positioned",
                      );
                    } else {
                      bool existsInRes = controller.res.any(
                        (item) => item.id == value.id,
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
