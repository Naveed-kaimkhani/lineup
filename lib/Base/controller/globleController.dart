import 'package:gaming_web_app/Base/controller/teamController/createTeamController.dart';
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/service/api/blolApi.dart';
import 'package:get/get.dart';

import '../../utils/snackbarUtils.dart';

class GlobleController extends GetxController {
  Future<void> teamDelete(int teamId) async {
    final respone = await GlobleApi.deleteTeam(teamId);

    if (respone.success!) {
      final TeamController controller = Get.find<TeamController>();
      controller.fetchTeams();
      SnackbarUtils.showSuccess(respone.message.toString());

    }else{
      SnackbarUtils.showErrorr("Something wrong please try again");
    }
  }
  Future<void> gameDelete(int gameId) async {
    final respone = await GlobleApi.deleteGame(gameId);


    if (respone.success!) {
      final TeamController controller = Get.find<TeamController>();
      controller.fetchTeams();
      SnackbarUtils.showSuccess(respone.message.toString());

    }else{
      SnackbarUtils.showErrorr("Something wrong please try again");
    }
  }

  Future<void> playesDelete(int playerId) async {
    final respone = await GlobleApi.deletePlayes(playerId);


    if (respone.success!) {
      final controller = Get.find<TeamController>();
      final controlle = Get.find<NewTeamController>();
        try {
          controller.fetchGetTeamData();
          controlle.getPlayer();
        }catch(e){

        }
      SnackbarUtils.showSuccess(respone.message.toString());
    }else{
      SnackbarUtils.showErrorr("Something wrong please try again");
    }
  }


}
