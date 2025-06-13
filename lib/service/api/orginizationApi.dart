import '../../Base/model/adminModel/makeOrginization.dart';
import '../../Base/model/response/base_response.dart';
import '../../Base/model/teamModel/teamModel.dart';
import '../api_end_point.dart';
import '../dio.dart';

class OrginizationsApi{


  static Future<BaseResponse<List<Organizations?>>> getOrganization() async {
    try {
      final response = await DioUtil.request<List<Organizations>>(
        endpoint: APIEndPoints.adminOrganizations,
        fromJsonT: Organizations.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<Organizations>();
          }
          return [];
        },    );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<Organizations>>(data: [],);
    }
  }


  static Future<BaseResponse<Object>> createOrginization(
      OrginizationCreate orginizationCreate) async {
    try {
      final response = await DioUtil.request<OrgnizatioResponse>(
        endpoint: APIEndPoints.adminOrganizations,
        requestBody: orginizationCreate.toJson(),
        fromJsonT: OrgnizatioResponse.fromJson,
        httpRequestType: HttpRequestType.post,
      );

      return response;
    } catch (e) {
      print('Error: $e');
      return BaseResponse<OrgnizatioResponse>(
        success: false,
        message: 'An error occurred: ${e.toString()}',
        data: null,
      );
    }
  }



  static Future<BaseResponse<Object>> updateOrginization(
      OrginizationCreate orginizationCreate) async {
    try {
      final response = await DioUtil.request<OrgnizatioResponse>(
        endpoint: APIEndPoints.adminOrganizations,
        requestBody: orginizationCreate.toJson(),
        fromJsonT: OrgnizatioResponse.fromJson,
        httpRequestType: HttpRequestType.put,
      );

      return response;
    } catch (e) {
      print('Error: $e');
      return BaseResponse<OrgnizatioResponse>(
        success: false,
        message: 'An error occurred: ${e.toString()}',
        data: null,
      );
    }
  }






}