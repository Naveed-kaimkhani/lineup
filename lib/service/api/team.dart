import 'dart:convert';
import 'dart:developer';

import 'package:gaming_web_app/Base/model/response/base_response.dart';
import 'package:gaming_web_app/Base/model/teamModel/teamModel.dart';
import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';

import 'package:http/http.dart' as http;
import '../../Base/controller/getTeamData.dart';
import '../../Base/model/game/addNewGame.dart';
import '../../Base/model/game/gameResponse.dart';
import '../../Base/model/lineup/autofillLineup.dart';
import '../../Base/model/lineup/fetchAutoLinup.dart';
import '../../Base/model/lineup/lineupModel.dart';
import '../../Base/model/lineup/pdfModel.dart';
import '../../Base/model/player/addPaler.dart';
import '../../Base/model/player/addPlayerResponse.dart';
import '../../Base/model/player/getPlayerModel.dart';
import '../../Base/model/playerPositioned.dart';
import '../../Base/model/positioned.dart';
import '../../Base/model/teamModel/createModel.dart';
import '../../Base/model/updatePlayer.dart';
import '../api_end_point.dart';
import '../dio.dart';

class TeamsApi {
  static Future<BaseResponse<List<Team?>>> getTeam() async {
    try {
      final response = await DioUtil.request<List<Team>>(
        endpoint: APIEndPoints.getTeams,
        fromJsonT: Team.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<Team>();
          }
          return [];
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<Team>>(data: []);
    }
  }

  static Future<bool> validatePromoCode(String promoCode) async {
    try {
      final token = await SharedPreferencesUtil.read(
        SharedPreferencesKeysConstants.bearerToken,
      );
      final uri = Uri.parse("${APIEndPoints.validatePromo}/$promoCode");

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        if (jsonMap['success'] == true) {
          return true;
        } else {
          SnackbarUtils.showErrorr(jsonMap['message'] ?? 'Invalid promo code.');
          return false;
        }
      } else {
        final jsonMap = jsonDecode(response.body);
        SnackbarUtils.showErrorr(jsonMap['message'] ?? 'Promo code is valid.');
        // SnackbarUtils.showErrorr('Something went wrong.');
        return false;
      }
    } catch (e) {
      SnackbarUtils.showErrorr('Error checking promo code.');
      return false;
    }
  }

  static Future<BaseResponse<List<GetPlayer?>>> getPlayer(int id) async {
    try {
      final response = await DioUtil.request<List<GetPlayer>>(
        endpoint: "${APIEndPoints.addPlayers}/$id/players",
        fromJsonT: GetPlayer.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<GetPlayer>();
          }
          return [];
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<GetPlayer>>(data: []);
    }
  }

  static Future<BaseResponse<TeamData?>> getTeamDataFromOrg(int id) async {
    String? token = await SharedPreferencesUtil.read("org_access_token");
    try {
      final url = Uri.parse("${APIEndPoints.addPlayers}/$id");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);

        if (jsonMap['data'] != null) {
          final teamData = TeamData.fromJson(jsonMap['data']);
          return BaseResponse<TeamData>(data: teamData);
        } else {
          return BaseResponse<TeamData>(data: null);
        }
      } else {
        return BaseResponse<TeamData>(data: null);
      }
    } catch (e) {
      return BaseResponse<TeamData>(data: null);
    }
  }

  static Future<BaseResponse<TeamData?>> getTeamData(int id) async {
    try {
      final response = await DioUtil.request<TeamData>(
        endpoint: "${APIEndPoints.addPlayers}/$id",
        fromJsonT: TeamData.fromJson,
        httpRequestType: HttpRequestType.get,
        // cast: (object) {
        //   if (object is List) {
        //     return object.cast<TeamData>();
        //   }
        //   return [];
        // },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<TeamData>(data: null);
    }
  }

  static Future<BaseResponse<GameData?>> getGameData(int gameId) async {
    try {
      final response = await DioUtil.request<GameData>(
        endpoint: "/games/$gameId/lineup",
        fromJsonT: GameData.fromJson,
        httpRequestType: HttpRequestType.get,
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<GameData>(data: null);
    }
  }

  static Future<BaseResponse<PDFMODEL?>> getPDF(int gameId) async {
    try {
      final response = await DioUtil.request<PDFMODEL>(
        endpoint: "/games/$gameId/pdf-data",
        fromJsonT: PDFMODEL.fromJson,
        httpRequestType: HttpRequestType.get,
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<PDFMODEL>(data: null);
    }
  }

  // /games/{gameId}/autocomplete-lineup
  static Future<BaseResponse<FetchAutoFillLineups>> autolinupSubmitPlayesId(
    AutoFillLineups autoFillLineups,
    int gameId,
  ) async {
    final response = await DioUtil.request<FetchAutoFillLineups>(
      loadingText: 'Submitting players...',
      endpoint: "/games/$gameId/autocomplete-lineup",
      requestBody: autoFillLineups.toJson(), // ✅ send request body
      fromJsonT: FetchAutoFillLineups.fromJson, // ✅ parse response
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }

  static Future<BaseResponse<void>> playerPositionedAdd(
    List<PlayerPreference> playerPreference,
    int? teamId,
  ) async {
    PlayerPreferencesResponse data = PlayerPreferencesResponse(
      playerPreferences: playerPreference,
    );
    var jsonString = playerPreference.map((e) => e.toJson()).toList();
    log(data.toJson().toString());
    final response = await DioUtil.request<void>(
      loadingText: 'Submitting players...',
      endpoint: "/teams/$teamId/bulk-player-preferences",
      requestBody: data.toJson(),
      fromJsonT: (_) => {},
      httpRequestType: HttpRequestType.put,
    );

    return response;
  }

  static Future<BaseResponse<FetchAutoFillLineups>> submmitLineupData(
    FetchAutoFillLineups autoFillLineups,
    int gameId,
  ) async {
    final response = await DioUtil.request<FetchAutoFillLineups>(
      loadingText: 'Submitting players...',
      endpoint: "/games/$gameId/lineup",
      requestBody: autoFillLineups.toJson(), // ✅ send request body
      fromJsonT: FetchAutoFillLineups.fromJson, // ✅ parse response
      httpRequestType: HttpRequestType.put,
    );

    return response;
  }

  static Future<BaseResponse<UpdatePlayerModel>> updatePlayer(
    UpdatePlayerModel updatePlayerModel,
    int playerId,
  ) async {
    final response = await DioUtil.request<UpdatePlayerModel>(
      loadingText: 'Submitting players...',
      endpoint: "/players/$playerId",
      requestBody: updatePlayerModel.toJson(), // ✅ send request body
      // fromJsonT: (_) => {},
      fromJsonT: UpdatePlayerModel.fromJson, // ✅ parse response
      httpRequestType: HttpRequestType.put,
    );

    return response;
  }

  static Future<BaseResponse<List<Position?>>> getTeamPosition() async {
    try {
      final response = await DioUtil.request<List<Position>>(
        endpoint: APIEndPoints.teamPositions,
        fromJsonT: Position.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<Position>();
          }
          return [];
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<Position>>(data: []);
    }
  }

  static Future<BaseResponse<List<Organizations?>>> getOrganization() async {
    try {
      final response = await DioUtil.request<List<Organizations>>(
        endpoint: APIEndPoints.organizations,
        fromJsonT: Organizations.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<Organizations>();
          }
          return [];
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<Organizations>>(data: []);
    }
  }

  static Future<BaseResponse<List<TeamData?>>> getOrganizationTeam(
    int orgnizationID,
  ) async {
    try {
      final response = await DioUtil.request<List<TeamData>>(
        endpoint: "${APIEndPoints.organizations}/$orgnizationID",
        fromJsonT: TeamData.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<TeamData>();
          }
          return [];
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<TeamData>>(data: []);
    }
  }

  static Future<BaseResponse<CreateTeamResponse>> createTeam(
    CreateTeam request,
  ) async {
    final response = await DioUtil.request<CreateTeamResponse>(
      loadingText: 'Creating team...',
      endpoint: APIEndPoints.getTeams,
      requestBody: request.toJson(),
      fromJsonT: CreateTeamResponse.fromJson,
      httpRequestType: HttpRequestType.post,
    );
    return response;
  }

  static Future<BaseResponse<AddPlayerResponse>> addPlayer(
    PlayerInputModel request,
  ) async {
    final response = await DioUtil.request<AddPlayerResponse>(
      loadingText: 'Creating team...',
      endpoint: "${APIEndPoints.addPlayers}/${request.id}/players",
      requestBody: request.toJson(),
      fromJsonT: AddPlayerResponse.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }

  static Future<BaseResponse<GameResponse>> CreateNewGame(
    AddGame request,
    int teamId,
  ) async {
    final response = await DioUtil.request<GameResponse>(
      loadingText: 'Creating team...',
      endpoint: '${APIEndPoints.addNewGame}$teamId/games',
      requestBody: request.toJson(),
      fromJsonT: GameResponse.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }
}
