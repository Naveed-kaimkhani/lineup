import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaming_web_app/Base/controller/getTeamData.dart';
import 'package:gaming_web_app/Base/controller/teamController/teamController.dart';
import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/routes_path.dart';
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

  RxList<GamePlayer> updatedOutListAfterReorder = <GamePlayer>[].obs;

  RxList<GamePlayer> updatedPlayerListAfterReorder = <GamePlayer>[].obs;
  final fixedBattingOrder = <int, int>{}.obs;

  bool get hasFixedSlots => fixedBattingOrder.isNotEmpty;

  RxList<TeamPlayer> playersOut1 = <TeamPlayer>[].obs;
  RxList<TeamPlayer> firstNinePlayers1 = <TeamPlayer>[].obs;
  var textColors = <String, Color>{}.obs;
  final Map<String, TextEditingController> cellControllers = {};

  final previewText = 'PREVIEW       '.obs;
  List<List<FocusNode>> fieldFocusNodes = [];
  final focusNodesGrid = <int, Map<String, FocusNode>>{};
  final textControllersGrid = <int, Map<String, TextEditingController>>{};
  Map<String, Map<String, String>>? fixedAssignments;
  RxBool isPayment = false.obs;
  final isBackspacePressed = false.obs;

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

  FetchAutoFillLineups getDummyAutoFillData() {
    return FetchAutoFillLineups(
      lineupp: [],
      playersInGame: [],
      fixedAssignments: {},
    );
  }

  /// Update the fixed batting order map for the two swapped players.
  /// Example before: {115:1, 109:2}
  /// After swap & reassign: {115:2, 109:1}
  void updateFixedAfterSwap({
    required Lineupp a,
    required Lineupp b,
    required Map<String, int> fixedBattingOrder,
  }) {
    final pidA = a.playerId;
    final pidB = b.playerId;
    if (pidA == null && pidB == null) return;

    // Agar map mein in players ke entries pehle se nahi, to bhi set kar do.
    if (pidA != null) {
      fixedBattingOrder[pidA] = int.parse(a.battingOrder!);
    }
    if (pidB != null) {
      fixedBattingOrder[pidB] = int.parse(b.battingOrder!);
    }

    // NOTE: Agar ye RxMap hai: (comment out if not)
    (fixedBattingOrder as RxMap<int, int>).refresh();
  }

  TextEditingController getCellController({
    required int rowIndex,
    required int inningNumber,
    required String initialText,
  }) {
    final key = "${rowIndex}_$inningNumber";
    if (!cellControllers.containsKey(key)) {
      final c = TextEditingController(text: initialText);
      // Ensure caret at end after initial build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (c.text.isNotEmpty) {
          c.selection = TextSelection.collapsed(offset: c.text.length);
        }
      });
      cellControllers[key] = c;
    } else {
      final c = cellControllers[key]!;
      // Keep controller text in sync with model (avoid endless loops)
      if (c.text != initialText) {
        c.text = initialText;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          c.selection = TextSelection.collapsed(offset: c.text.length);
        });
      }
    }
    return cellControllers[key]!;
  }

  void disposeCellControllers() {
    for (final c in cellControllers.values) {
      c.dispose();
    }
    cellControllers.clear();
  }

  void splitPlayers() {
    final TeamController controller = Get.find<TeamController>();
    final allPlayers = controller.teamData.value!.players ?? [];
    // log("list of all players");
    // log(allPlayers.length.toString());
    firstNinePlayers1.value = allPlayers.take(9).toList();
    // log("list of nine players");
    // log(firstNinePlayers1.length.toString());
    playersOut1.value = allPlayers.skip(9).toList();

    // log("list of remaing players");
    // log(playersOut1.length.toString());
  }

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
    final formatter = DateFormat('MM-dd-yyyy');
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
      } else {}

      // Call the API to get the list of teams
      final response = await TeamsApi.getGameData(int.parse(gameId!));

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        isLoading.value = true;
        gameData.value = response.data!;
        // firstNinePlayers.value = gameData.value.players!.sublist(9);

        final allPlayers = gameData.value.players!;
        final lineups = gameData.value.lineupp ?? [];
        // playersOut.value = allPlayers.length > 9 ? allPlayers.sublist(9) : [];

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

  Map<String, Map<String, String>> calculateFixedAssignments(
    List<Lineupp> lineups,
    List<int> playerIds,
  ) {
    final fixedAssignments = <String, Map<String, String>>{};

    for (int i = 0; i < lineups.length; i++) {
      final player = lineups[i];

      // ✅ Use player ID from playerIds list
      final playerId = playerIds[i].toString();

      final playerAssignments = <String, String>{};

      // Collect non-empty positions
      player.innings.forEach((inningNumber, position) {
        if (position.isNotEmpty) {
          playerAssignments[inningNumber.toString()] = position;
        }
      });

      if (playerAssignments.isNotEmpty) {
        fixedAssignments[playerId] = playerAssignments;
      }
    }

    return fixedAssignments;
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
      // log(gameId.toString());

      autoFillLineups.value.fixedAssignments = calculateFixedAssignments(
        autoFillData.value?.lineupp ?? [],
        autoFillLineups.value.playersInGame ?? [],
      );

      final response = await TeamsApi.autolinupSubmitPlayesId(
        autoFillLineups.value,
        int.parse(gameId!),
      );

      if (response.data != null) {
        fetchAutoFillLineups.value = response.data!;
        autoFillData.value = response.data!;

        fetchAutoFillLineups.refresh();
        lineupp.value = response.data!.lineupp!;

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
    }
  }

  Future<void> setAutoFillWithEmptyData() async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');

      autoFillLineups.value.fixedAssignments = calculateFixedAssignments(
        autoFillData.value?.lineupp ?? [],
        autoFillLineups.value.playersInGame ?? [],
      );

      final response = await TeamsApi.setEmptyautolinupSubmitPlayesId(
        autoFillLineups.value,
        int.parse(gameId!),
      );

      if (response.data != null) {
        fetchAutoFillLineups.value = response.data!;
        autoFillData.value = response.data!;
        if (autoFillData.value!.lineupp != null) {
          for (var lineup in autoFillData.value!.lineupp!) {
            lineup.innings.updateAll(
              (key, value) => '',
            ); // Set every inning value to ""
          }
        }
        fetchAutoFillLineups.refresh();
        lineupp.value = response.data!.lineupp!;

        // for (
        //   int inning = 0;
        //   inning < gameData.value.players!.length;
        //   inning++
        // ) {
        //   calculateTopPositionAndPlayingTime(inning, lineupp[0].innings.length);
        // }
        initializeStatsFromApi(lineupp);
        initializePlayingTimePercentForAll();
      } else {
        SnackbarUtils.showErrorr(response.message.toString());
        // Handle the case where no teams are returned
        // teams.value = [];
      }
    } catch (e) {
      // Handle any errors that occur
    }
  }

  //get lineup
  Future<void> getLineup(bool isShow) async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');
      String? token = await SharedPreferencesUtil.read(
        SharedPreferencesKeysConstants.bearerToken,
      );

      if (gameId != null) {
      } else {}
      if (fixedAssignments != null) {
        autoFillLineups.value.fixedAssignments = fixedAssignments;
      }

      final response = await TeamsApi.getLineupData(
        autoFillLineups.value,
        int.parse(gameId!),
      );

      if (response.data!.lineupp != null &&
          response.data!.lineupp!.isNotEmpty) {
        fetchAutoFillLineups.value = response.data!;
        autoFillData.value = response.data!;
        fetchAutoFillLineups.refresh();

        // Safely assign lineup if it exists
        if (response.data!.lineupp!.isNotEmpty) {
          lineupp.value = response.data!.lineupp!;

          for (
            int inning = 0;
            inning < gameData.value.players!.length;
            inning++
          ) {
            if (isShow) {
              calculateTopPositionAndPlayingTime(
                inning,
                lineupp[0].innings.length,
              );
            }
          }

          // calculateDynamicGameStats();
        } else {}
        // lineupp.value = response.data!.lineupp!;
      } else {
        // SnackbarUtils.showErrorr(response.message.toString());
      }
    } catch (e) {
      // Handle any errors that occur
    }
  }

  // void recalculatePlayerStats(int index) {
  //   Map<String, int> updatedCounts = {};
  //   final stats = lineupp[index].stats;

  //   // Count current innings (excluding OUT and BENCH)
  //   lineupp[index].innings.forEach((inning, position) {
  //     final pos = position.trim().toUpperCase();
  //     if (pos.isNotEmpty && pos != 'OUT' && pos != 'BENCH') {
  //       updatedCounts[pos] = (updatedCounts[pos] ?? 0) + 1;
  //     }
  //   });

  //   // Start with original API positionCounts
  //   Map<String, int> mergedCounts = Map<String, int>.from(
  //     stats?.positionCounts ?? {},
  //   );

  //   // Merge: override only the positions that exist in updated innings
  //   for (var pos in updatedCounts.keys) {
  //     mergedCounts[pos] = updatedCounts[pos]!;
  //   }

  //   // Determine top position
  //   String topPosition = "OUT";
  //   int maxCount = 0;
  //   List<String> topPositions = [];

  //   mergedCounts.forEach((pos, count) {
  //     if (count > maxCount) {
  //       maxCount = count;
  //       topPositions = [pos];
  //     } else if (count == maxCount) {
  //       topPositions.add(pos);
  //     }
  //   });

  //   topPosition = topPositions.join(' / ');

  //   // ✅ Retain the old playingTimePercent, do not recalculate
  //   final existing = statsList[index];

  //   final updatedStats = PlayerPositionStats(
  //     topPosition: topPosition,
  //     playingTimePercent: existing.playingTimePercent,
  //     positionCounts: mergedCounts,
  //   );

  //   statsList[index] = updatedStats;
  //   statsList.refresh();
  // }

  void recalculatePlayerStats(int index) {
    Map<String, int> updatedCounts = {};
    final stats = lineupp[index].stats;

    // Count current innings (including OUT)
    lineupp[index].innings.forEach((inning, position) {
      final pos = position.trim().toUpperCase();
      if (pos.isNotEmpty) {
        updatedCounts[pos] = (updatedCounts[pos] ?? 0) + 1;
      }
    });

    // Merge with original counts from API
    Map<String, int> mergedCounts = Map<String, int>.from(
      stats?.positionCounts ?? {},
    );

    // Override positions from updated innings
    for (var pos in updatedCounts.keys) {
      mergedCounts[pos] = updatedCounts[pos]!;
    }

    // ✅ Compute topPosition (IGNORE 'OUT')
    String topPosition = "OUT";
    int maxCount = 0;
    List<String> topPositions = [];

    mergedCounts.forEach((pos, count) {
      if (pos != 'OUT' && count > 0) {
        if (count > maxCount) {
          maxCount = count;
          topPositions = [pos];
        } else if (count == maxCount) {
          topPositions.add(pos);
        }
      }
    });

    // If no valid position found, keep 'OUT' as fallback
    if (topPositions.isNotEmpty) {
      topPosition = topPositions.join(' / ');
    }

    // Retain previous playing time percent
    final existing = statsList[index];

    final updatedStats = PlayerPositionStats(
      topPosition: topPosition,
      playingTimePercent: existing.playingTimePercent,
      positionCounts: mergedCounts,
    );

    statsList[index] = updatedStats;
    statsList.refresh();
  }


  void updatePlayingTimePercentUsingNewFormula(int index) {
    final stats = lineupp[index].stats;

    int outFromSaved =
        stats?.positionCounts['OUT'] ??
        0; // first we are getting out values from saved lineup
    int outInCurrent = 0;
    int currentValidInnings = 0;

    lineupp[index].innings.forEach((inning, position) {
      final pos = position.trim().toUpperCase();

      if (pos.isEmpty) return;

      if (pos == 'OUT') {
        outInCurrent++; // calculating out position in current lineup
      } else if (pos != 'BENCH') {
        currentValidInnings++;
      }
    });

    // Calculate total saved innings (excluding OUT)
    int savedValidInnings = 0;
    stats?.positionCounts.forEach((pos, count) {
      if (pos != 'OUT' && pos != 'BENCH') {
        savedValidInnings += count;
      }
    });

    int totalOut = outFromSaved + outInCurrent;
    int totalInnings = savedValidInnings + currentValidInnings;

    // Original percentage was OUT%, now we want PLAYING%
    double rawOutPercentage =
        totalInnings > 0 ? (totalOut / totalInnings) * 100 : 0;
    double playingPercentage = 100 - rawOutPercentage;

    String playingTimePercent = "${playingPercentage.toStringAsFixed(0)}%";

    final existing = statsList[index];

    statsList[index] = PlayerPositionStats(
      topPosition: existing.topPosition,
      playingTimePercent: playingTimePercent,
      positionCounts: existing.positionCounts,
    );

    statsList.refresh();
  }


  void initializePlayingTimePercentForAll() {
    for (int i = 0; i < lineupp.length; i++) {
      final stats = lineupp[i].stats;

      // ✅ Get the percent innings played directly from stats
      double pctPlayed = stats?.pctInningsPlayed ?? 0;
      String playingTimePercent = "${pctPlayed.toStringAsFixed(0)}%";

      final existingTopPosition = stats?.topPosition ?? 'OUT';
      final existingPositionCounts = stats?.positionCounts ?? {};

      final newStats = PlayerPositionStats(
        topPosition: existingTopPosition,
        playingTimePercent: playingTimePercent,
        positionCounts: existingPositionCounts,
      );

      if (i < statsList.length) {
        statsList[i] = newStats;
      } else {
        statsList.add(newStats);
      }
    }

    statsList.refresh();
  }

  void initializePlayingTimePercentForIndex(int index) {
    if (index < 0 || index >= lineupp.length) return;

    final stats = lineupp[index].stats;

    // ✅ Get the percent innings played directly from stats
    double pctPlayed = stats?.pctInningsPlayed ?? 0;
    String playingTimePercent = "${pctPlayed.toStringAsFixed(0)}%";

    final existingTopPosition = stats?.topPosition ?? 'OUT';
    final existingPositionCounts = stats?.positionCounts ?? {};

    final newStats = PlayerPositionStats(
      topPosition: existingTopPosition,
      playingTimePercent: playingTimePercent,
      positionCounts: existingPositionCounts,
    );

    if (index < statsList.length) {
      statsList[index] = newStats;
    } else {
      statsList.add(newStats);
    }

    statsList.refresh();
  }

  Future<void> submmitLineupDataPlayesId() async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');
      if (gameId != null) {
      } else {}
      // Call the API to get the list of teams
      final response = await TeamsApi.submmitLineupData(
        fetchAutoFillLineups.value,

        int.parse(gameId!),
      );

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        Get.toNamed(RoutesPath.savePdfScreen);
      } else {
        SnackbarUtils.showErrorr(response.message.toString());
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> submmitLineupDataPlayesIdFromBuildLineupScreen() async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');
      if (gameId != null) {
      } else {}
      // Call the API to get the list of teams
      final response = await TeamsApi.submmitLineupData(
        fetchAutoFillLineups.value,
        int.parse(gameId!),
      );

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        updatedPlayerListAfterReorder.value = gameData.value.players!;
        updatedOutListAfterReorder.value = playersOut;

        Get.toNamed(RoutesPath.savePdfScreenForBuildLineup);
      } else {
        SnackbarUtils.showErrorr(response.message.toString());
      }
    } catch (e) {
      // Handle any errors that occur
      print('Error fetching teams: $e');
    }
  }

  Future<void> fetchSubmmittedLineupData() async {
    try {
      String? gameId = await SharedPreferencesUtil.read('gameID');
      if (gameId != null) {
      } else {}
      // Call the API to get the list of teams
      final response = await TeamsApi.fetchSubmmittedLineupData(
        fetchAutoFillLineups.value,

        int.parse(gameId!),
      );

      // Check if the response contains data and update the teams list
      if (response.data != null) {
        // Get.toNamed(RoutesPath.savePdfScreen);
      } else {
        SnackbarUtils.showErrorr(response.message.toString());
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

  void updateTextColor({
    required int index,
    required int inningNumber,
    required String val,
  }) {
    val = val.trim().toUpperCase();

    // ✅ Check if position exists in team positions
    bool isValidPosition = filterPositionsByNameMatch(teamPositioned, val);

    // ✅ Exempt values
    const exemptPositions = ['CC', 'OUT'];

    // ✅ Get inning values from other rows
    final allLineups = autoFillData.value?.lineupp ?? [];
    final inningValues =
        allLineups
            .asMap()
            .entries
            .where((e) => e.key != index)
            .map((e) => e.value.innings[inningNumber]?.trim().toUpperCase())
            .where((v) => v != null)
            .cast<String>()
            .toList();

    // ✅ Determine color
    Color newColor;
    if (val.isEmpty) {
      newColor = Colors.black;
    } else if (exemptPositions.contains(val)) {
      newColor = Colors.black; // Don't mark exempt values as invalid
    } else if (!isValidPosition || inningValues.contains(val)) {
      newColor = const Color.fromARGB(255, 164, 60, 60); // Invalid OR duplicate
    } else {
      newColor = Colors.black; // Valid
    }

    // ✅ Update observable color
    textColors["${index}_$inningNumber"] = newColor;
  }

  void updateColorsAfterReorder() {
    final allLineups = autoFillData.value?.lineupp ?? [];

    for (int i = 0; i < allLineups.length; i++) {
      final inningsMap = allLineups[i].innings;

      inningsMap.forEach((inningNumber, val) {
        updateTextColor(
          index: i,
          inningNumber: int.parse(inningNumber.toString()),
          val: val,
        );
      });
    }
  }

  // void initializeStatsFromApi(List<Lineupp> lineupp) {
  //   statsList.clear(); // optional: clear existing data

  //   for (int i = 0; i < lineupp.length; i++) {
  //     final stats = lineupp[i].stats;

  //     final data = PlayerPositionStats(
  //       topPosition: stats?.topPosition ?? 'OUT',
  //       playingTimePercent: '${stats?.pctInningsPlayed ?? 0}%',
  //     );

  //     if (i < statsList.length) {
  //       statsList[i] = data;
  //     } else {
  //       statsList.add(data);
  //     }
  //   }

  //   statsList.refresh();
  // }

  // void initializeStatsFromApi(List<Lineupp> lineupp) {
  //   statsList.clear();

  //   for (int i = 0; i < lineupp.length; i++) {
  //     final stats = lineupp[i].stats;
  //     final Map<String, int> combinedCounts = {};

  //     // 1. Add API-provided position_counts
  //     if (stats?.positionCounts != null) {
  //       stats!.positionCounts.forEach((pos, count) {
  //         combinedCounts[pos] = count;
  //       });
  //     }

  //     // 2. Merge current innings (ignore blank)
  //     lineupp[i].innings.forEach((_, pos) {
  //       if (pos.trim().isNotEmpty) {
  //         combinedCounts[pos] = (combinedCounts[pos] ?? 0) + 1;
  //       }
  //     });

  //     // 3. Determine top position from combinedCounts
  //     String topPosition = 'OUT';
  //     int maxCount = 0;
  //     combinedCounts.forEach((pos, count) {
  //       if (count > maxCount) {
  //         topPosition = pos;
  //         maxCount = count;
  //       }
  //     });

  //     final data = PlayerPositionStats(
  //       topPosition: topPosition,
  //       playingTimePercent: '${stats?.pctInningsPlayed ?? 0}%',
  //       positionCounts: combinedCounts,
  //     );

  //     if (i < statsList.length) {
  //       statsList[i] = data;
  //     } else {
  //       statsList.add(data);
  //     }
  //   }

  //   statsList.refresh();
  // }

  // void initializeStatsFromApi(List<Lineupp> lineupp) {
  //   statsList.clear();

  //   for (int i = 0; i < lineupp.length; i++) {
  //     final stats = lineupp[i].stats;

  //     // 1. Start with API-provided position_counts
  //     final Map<String, int> finalPositionCounts = Map<String, int>.from(
  //       stats?.positionCounts ?? {},
  //     );

  //     // 2. Count innings from UI edits
  //     final Map<String, int> editedCounts = {};
  //     lineupp[i].innings.forEach((_, pos) {
  //       final cleanPos = pos.trim().toUpperCase();
  //       if (cleanPos.isNotEmpty) {
  //         editedCounts[cleanPos] = (editedCounts[cleanPos] ?? 0) + 1;
  //       }
  //     });

  //     // 3. Use editedCounts if available (overrides API data)
  //     if (editedCounts.isNotEmpty) {
  //       finalPositionCounts
  //         ..clear()
  //         ..addAll(editedCounts);
  //     }

  //     // 4. Use top position directly from API
  //     final String topPosition = stats?.topPosition ?? 'OUT';

  //     final data = PlayerPositionStats(
  //       topPosition: topPosition,
  //       playingTimePercent: '${stats?.pctInningsPlayed ?? 0}%',
  //       positionCounts: finalPositionCounts,
  //     );

  //     if (i < statsList.length) {
  //       statsList[i] = data;
  //     } else {
  //       statsList.add(data);
  //     }
  //   }

  //   statsList.refresh();
  // }

  void initializeStatsFromApi(List<Lineupp> lineupp) {
    statsList.clear();

    for (int i = 0; i < lineupp.length; i++) {
      final stats = lineupp[i].stats;

      final data = PlayerPositionStats(
        topPosition: stats?.topPosition ?? 'OUT',
        playingTimePercent: '', // Skip setting playing time
        positionCounts: const {}, // You can leave this empty if not needed here
      );

      if (i < statsList.length) {
        statsList[i] = data;
      } else {
        statsList.add(data);
      }
    }

    statsList.refresh();
  }

  PlayerPositionStats calculateTopPositionAndPlayingTime(
    int index,
    int totalInnings,
  ) {
    int playedInnings = 0;
    Map<String, int> positionCount = {};

    lineupp[index].innings.forEach((inning, position) {
      final pos = position.toUpperCase();
      if (pos != 'OUT' && pos != 'BENCH') {
        playedInnings++;
        positionCount[pos] = (positionCount[pos] ?? 0) + 1;
      }
    });

    double percentage =
        totalInnings > 0 ? (playedInnings / totalInnings) * 100 : 0;
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

    final data = PlayerPositionStats(
      topPosition: topPosition,
      playingTimePercent: playingTimePercent,
    );

    if (index < statsList.length) {
      statsList[index] = data;
    } else {
      statsList.add(data);
    }

    statsList.refresh();
    return data;
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
  final Map<String, int> positionCounts;

  PlayerPositionStats({
    required this.topPosition,
    required this.playingTimePercent,
    this.positionCounts = const {},
  });

  @override
  String toString() =>
      'Top Position: $topPosition, Playing Time: $playingTimePercent';
}
