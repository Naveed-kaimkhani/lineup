import 'package:get/get.dart';

import '../../routes/routes_path.dart';
import '../../service/api/team.dart';
import '../../utils/SharedPreferencesUtil.dart';
import '../model/lineup/autofillLineup.dart';
import '../model/lineup/fetchAutoLinup.dart';
import '../model/lineup/lineupModel.dart';
import '../model/lineup/pdfModel.dart';
import '../model/positioned.dart';

class LineupController extends GetxController {

  RxList<Position?> teamPositioned = <Position?>[].obs;
  Rx<AutoFillLineups> autoFillLineups = AutoFillLineups().obs;
  // Rx<FetchAutoFillLineups> fetchAutoFillLineups = FetchAutoFillLineups().obs;
  Rx<GameData> gameData = GameData().obs;
  Rx<PDFMODEL> pDFMODEL = PDFMODEL().obs;
  Rx<FetchAutoFillLineups> fetchAutoFillLineups = FetchAutoFillLineups().obs;


  Future<void> getPDF() async {
    try {
    String? gameId = await SharedPreferencesUtil.read('gameID');
    if (gameId != null) {
      print('Saved Game ID: $gameId');
    } else {
      print('Game ID not found');
    }

      // Call the API to get the list of teams
      final response = await TeamsApi.getPDF(int.parse(gameId!));

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        pDFMODEL.value = response.data!;



      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }


  }
  Future<void> getGamePlayer() async {
    try {
    String? gameId = await SharedPreferencesUtil.read('gameID');
    if (gameId != null) {
      print('Saved Game ID: $gameId');
    } else {
      print('Game ID not found');
    }

      // Call the API to get the list of teams
      final response = await TeamsApi.getGameData(int.parse(gameId!));

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        gameData.value = response.data!;

        List<int> playersIds = [];

        for (int i = 0; i < gameData.value.players!.length; i++) {
          final player = gameData.value.players![i];
          if (player.id != null) {
            playersIds.add(player.id!);
          }
        }

       autoFillLineups.value = AutoFillLineups(
          playersInGame: playersIds,
          fixedAssignments: {}, // or null or your data here
        );

      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }


  }

  Future<void> fetchTeamsPositioned() async {
    try {
      // Call the API to get the list of teams
      final response = await TeamsApi.getTeamPosition();

      // Check if the response contains data and update the teams list
      if (response.data != null && response.data!.isNotEmpty) {
        teamPositioned.value = response.data!;


      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }




  Future<void> autoFillLinupUsingPlayesId() async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');
      if (gameId != null) {
        print('Saved Game ID: $gameId');
      } else {
        print('Game ID not found');
      }
      // Call the API to get the list of teams
      final response = await TeamsApi.autolinupSubmitPlayesId(autoFillLineups.value,int.parse(gameId!));
       print("response.data");
       print(response.data?.toJson());
       print(response.data);
      // Check if the response contains data and update the teams list
      if (response.data != null) {
        // teamPositioned.value = response.data!;
        fetchAutoFillLineups.value=response.data!;
        fetchAutoFillLineups.refresh();
      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }



  Future<void> submmitLineupDataPlayesId() async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');
      if (gameId != null) {
        print('Saved Game ID: $gameId');
      } else {
        print('Game ID not found');
      }
      // Call the API to get the list of teams
      final response = await TeamsApi.submmitLineupData(fetchAutoFillLineups.value,int.parse(gameId!));

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        // teamPositioned.value = response.data!;
        Get.toNamed(RoutesPath.savePdfScreen);


      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }


}
