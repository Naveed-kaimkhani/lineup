import '../../Base/model/adminModel/adminOrgnization.dart';
import '../../Base/model/orgnization.dart';
import '../../Base/model/response/base_response.dart';
import '../api_end_point.dart';
import '../dio.dart';

class AdminApi{
  static Future<BaseResponse<OrganizationResponse>?> getOrganization() async {
    try {
      final response = await DioUtil.request<OrganizationResponse>(
        endpoint: APIEndPoints.adminOrgnization,
        fromJsonT: OrganizationResponse.fromJson,
        httpRequestType: HttpRequestType.get,
        // cast: (object) {
        //   if (object is List) {
        //     return object.cast<OrganizationResponse>();
        //   }
        //   return [];
        // },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return null;
    }
  }


}