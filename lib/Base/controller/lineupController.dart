import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/routes_path.dart';
import '../../screens/team_dashboard/add_new_player_screen.dart';
import '../../service/api/team.dart';
import '../../utils/SharedPreferencesUtil.dart';
import '../../utils/snackbarUtils.dart';
import '../model/lineup/autofillLineup.dart';
import '../model/lineup/fetchAutoLinup.dart';
import '../model/lineup/lineupModel.dart';
import '../model/lineup/pdfModel.dart';
import '../model/positioned.dart';

class LineupController extends GetxController {
  RxList<GamePlayer> playersOut = <GamePlayer>[].obs;
  Map<String, Map<String, String>>? fixedAssignments;
  RxBool isPayment = false.obs;
  RxBool isLoading = false.obs;
  RxList<Position?> teamPositioned = <Position?>[].obs;

  Rx<AutoFillLineups> autoFillLineups = AutoFillLineups().obs;

  Rx<GameData> gameData = GameData().obs;
  Rx<PDFMODEL> pDFMODEL = PDFMODEL().obs;

  Rx<FetchAutoFillLineups> fetchAutoFillLineups = FetchAutoFillLineups().obs;

  RxString enerLable = "".obs;
  var autoFillData = Rxn<FetchAutoFillLineups>();
  final Map<String, TextEditingController> textControllers = {};
  final Map<String, RxBool> labelFlags = {};
  RxBool isAuto = false.obs;
  String _generateKey(int index, dynamic inningNumber) =>
      "$index-$inningNumber";
  Future<void> getPDF() async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');
      if (gameId != null) {
      } else {}

      // Call the API to get the list of teams
      final response = await TeamsApi.getPDF(int.parse(gameId!));

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        isPayment.value = true;
        pDFMODEL.value = response.data!;
        pDFMODEL.value.lineupAssignments;
        pDFMODEL.refresh();
      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
    }
  }

  String getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM d yyyy'); // Example: April 4 2025
    return formatter.format(now);
  }

  File getFileFromPath(String filePath) {
    final file = File(filePath);
    return file;
  }

  bool filterPositionsByNameMatch(List<Position?> positions, String query) {
    return positions.any((position) {
      final name = position?.name?.toLowerCase() ?? '';
      return name == query.toLowerCase(); // Exact match
    });
  }

  Future<void> getGamePlayer() async {
    try {
      isAuto.value = false;
      isLoading.value = false;
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
        isLoading.value = true;
        gameData.value = response.data!;

        List<int> playersIds = [];
        statsList.clear();
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
        autoFillData.value = generateAutoFillLineups(
          playerCount: gameData.value.players!.length,
          inningsCount: gameData.value.innings!,
        );
      } else {
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
    }
  }

  void addFixedAssignment(String playerId, String inning, String position) {
    fixedAssignments ??= {};
    fixedAssignments!.putIfAbsent(playerId, () => {});
    fixedAssignments![playerId]![inning] = position;
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
      if (fixedAssignments != null) {
        autoFillLineups.value.fixedAssignments = fixedAssignments;
      }
      // Call the API to get the list of teams
      final response = await TeamsApi.autolinupSubmitPlayesId(
        autoFillLineups.value,
        int.parse(gameId!),
      );

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        // lineupp.value.clear();
        // teamPositioned.value = response.data!;

        log("lineup data settt");
        fetchAutoFillLineups.value = response.data!;
        autoFillData.value = response.data!;

        fetchAutoFillLineups.refresh();
        lineupp.value = response.data!.lineupp!;

        // print(fetchAutoFillLineups.value.playersInGame!.length);

        for (
          int inning = 0;
          inning < gameData.value.players!.length;
          inning++
        ) {
          calculateTopPositionAndPlayingTime(inning, lineupp[0].innings.length);
        }

        // calculateDynamicGameStats();
      } else {
        SnackbarUtils.showErrorr(response.message.toString());
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }
  // void againCalculateStatsandTopPositions(){
  //   //  for (
  //   //         int inning = 0;
  //   //         inning < gameData.value.players!.length;
  //   //         inning++
  //   //       ) {
  //   //         calculateTopPositionAndPlayingTime(inning, lineupp[0].innings.length);
  //   //       }
  //     calculateTopPositionAndPlayingTime(inning, lineupp[0].innings.length);
  // }

  void recalculatePlayerStats(int index) {
    int playedInnings = 0;
    Map<String, int> positionCount = {};

    lineupp![index].innings!.forEach((inning, position) {
      final pos = position.toUpperCase();
      if (pos != 'OUT' && pos != 'BENCH') {
        playedInnings++;
        positionCount[pos] = (positionCount[pos] ?? 0) + 1;
      }
    });

    double percentage =
        lineupp![index].innings!.length > 0
            ? (playedInnings / lineupp![index].innings!.length) * 100
            : 0;
    String playingTimePercent = "${percentage.toStringAsFixed(0)}%";

    String topPosition = "OUT";
    if (positionCount.isNotEmpty) {
      int maxCount = 0;
      List<String> topPositions = [];

      positionCount.forEach((pos, count) {
        if (count > maxCount) {
          maxCount = count;
          topPositions = [pos];
        } else if (count == maxCount) {
          topPositions.add(pos);
        }
      });

      topPosition = topPositions.join(' / ');
    }

    final updatedStats = PlayerPositionStats(
      topPosition: topPosition,
      playingTimePercent: playingTimePercent,
    );

    // Replace stats at the correct index
    if (index < statsList.length) {
      statsList[index] = updatedStats;
    } else {
      statsList.add(updatedStats);
    }

    statsList.refresh();
    log("stats recalculateddd");
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
      final response = await TeamsApi.submmitLineupData(
        fetchAutoFillLineups.value,
        int.parse(gameId!),
      );

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        // teamPositioned.value = response.data!;
        Get.toNamed(RoutesPath.savePdfScreen);
      } else {
        SnackbarUtils.showErrorr(response.message.toString());
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  // controller.autoFillData.value = controller.generateAutoFillLineups(
  // playerCount: controller.gameData.value.players!.length!,
  // inningsCount: controller.gameData.value.innings!,
  // )
  List<Lineupp>? lineup;
  RxList<Lineupp> lineupp = <Lineupp>[].obs;

  FetchAutoFillLineups generateAutoFillLineups({
    int? playerCount,
    required int inningsCount,
    int startingPlayerId = 13,
  }) {
    _validateInputs(playerCount!, inningsCount, startingPlayerId);

    final generatedLineup = <Lineupp>[];
    final playersInGame = <int>[];

    for (int i = 0; i < playerCount!; i++) {
      final playerId = (startingPlayerId + i).toString();
      final innings = _generateEmptyInnings(inningsCount);

      generatedLineup.add(Lineupp(playerId: playerId, innings: innings));

      playersInGame.add(int.parse(playerId));
    }

    lineup = List.unmodifiable(generatedLineup);

    return FetchAutoFillLineups(
      lineupp: List.unmodifiable(generatedLineup),
      playersInGame: List.unmodifiable(playersInGame),
      fixedAssignments: const {},
    );
  }

  Map<int, String> _generateEmptyInnings(int inningsCount) {
    return {for (int inning = 1; inning <= inningsCount; inning++) inning: ""};
  }

  void _validateInputs(
    int playerCount,
    int inningsCount,
    int startingPlayerId,
  ) {
    if (playerCount <= 0) throw ArgumentError('Player count must be positive');
    if (inningsCount <= 0)
      throw ArgumentError('Innings count must be positive');
    if (startingPlayerId <= 0) {
      throw ArgumentError('Starting player ID must be positive');
    }
  }

  PlayerPositionStats calculateTopPositionAndPlayingTime(
    int index,
    int totalInnings,
  ) {
    print("1");
    int playedInnings = 0;
    Map<String, int> positionCount = {};

    lineupp![index].innings!.forEach((inning, position) {
      final pos = position.toUpperCase();
      if (pos != 'OUT' && pos != 'BENCH') {
        playedInnings++;
        positionCount[pos] = (positionCount[pos] ?? 0) + 1;
      }
    });
    // Calculate percentage
    double percentage =
        totalInnings > 0 ? (playedInnings / totalInnings) * 100 : 0;
    String playingTimePercent = "${percentage.toStringAsFixed(0)}%";

    // Determine top position
    String topPosition = "OUT";
    if (positionCount.isNotEmpty) {
      int maxCount = 0;
      List<String> topPositions = [];

      positionCount.forEach((pos, count) {
        if (count > maxCount) {
          maxCount = count;
          topPositions = [pos];
        } else if (count == maxCount) {
          topPositions.add(pos);
        }
      });

      topPosition = topPositions.join(' / ');
    }
    final data = PlayerPositionStats(
      topPosition: topPosition,
      playingTimePercent: playingTimePercent,
    );
    statsList.value.add(data);

    refresh();
    statsList[0].topPosition;
    statsList.refresh();
    // print(statsList.length);
    return PlayerPositionStats(
      topPosition: topPosition,
      playingTimePercent: playingTimePercent,
    );
  }

  void refresh() {
    Future.delayed(Duration(seconds: 4));
    statsList.refresh();
  }

  RxList<PlayerPositionStats> statsList = <PlayerPositionStats>[].obs;
}

class PlayerPositionStats {
  final String topPosition;
  final String playingTimePercent;

  PlayerPositionStats({
    required this.topPosition,
    required this.playingTimePercent,
  });

  @override
  String toString() =>
      'Top Position: $topPosition, Playing Time: $playingTimePercent';
}
