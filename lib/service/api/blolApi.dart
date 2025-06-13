import '../../Base/model/authModel/loginModel.dart';
import '../../Base/model/response/base_response.dart';
import '../api_end_point.dart';
import '../dio.dart';

class GlobleApi{
  static Future<BaseResponse<void>> deleteTeam(int teamID) async {
    final response = await DioUtil.request<void>(
      endpoint: '${APIEndPoints.deleteTeams}$teamID',
      requestBody: {},
      httpRequestType: HttpRequestType.delete,
      fromJsonT: (_) => null, // still valid because response data might not be needed
    );
    return response;
  }
  static Future<BaseResponse<void>> deleteGame(int gameId) async {
    final response = await DioUtil.request<void>(
      endpoint: '/games/$gameId',
      requestBody: {},
      httpRequestType: HttpRequestType.delete,
      fromJsonT: (_) => null, // still valid because response data might not be needed
    );
    return response;
  }
  static Future<BaseResponse<void>> deletePlayes(int playesId) async {
    final response = await DioUtil.request<void>(
      endpoint: '${APIEndPoints.deletePlayes}$playesId',
      requestBody: {},
      httpRequestType: HttpRequestType.delete,
      fromJsonT: (_) => null, // still valid because response data might not be needed
    );
    return response;
  }

}