import 'dart:convert';
import 'dart:developer';

import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';

import '../../Base/model/adminModel/makeOrginization.dart';
import '../../Base/model/response/base_response.dart';
import '../../Base/model/teamModel/teamModel.dart';
import '../api_end_point.dart';
import '../dio.dart';

import 'package:http/http.dart' as http;

class OrginizationsApi {
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
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<Organizations>>(data: []);
    }
  }

  // static Future<BaseResponse<Object>> createOrginization(
  //   OrginizationCreate orginizationCreate,
  // ) async {
  //   log(orginizationCreate.toString());
  //   try {
  //     final response = await DioUtil.request<OrgnizatioResponse>(
  //       endpoint: APIEndPoints.adminOrganizations,
  //       requestBody: orginizationCreate.toJson(),
  //       fromJsonT: OrgnizatioResponse.fromJson,
  //       httpRequestType: HttpRequestType.post,
  //     );

  //     return response;
  //   } catch (e) {
  //     print('Error: $e');
  //     return BaseResponse<OrgnizatioResponse>(
  //       success: false,
  //       message: 'An error occurred: ${e.toString()}',
  //       data: null,
  //     );
  //   }
  // }

  static Future<BaseResponse<OrgnizatioResponse>> createOrginization(
    OrginizationCreate orginizationCreate,
  ) async {
    log(
      jsonEncode(orginizationCreate.toJson()),
    ); // log("name iss${orginizationCreate.name}");
    final url = Uri.parse("http://18.189.193.38/api/v1/admin/organizations");
    String? token = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );
    log(token ?? "");
    try {
      final response = await http.post(
        url,
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode(orginizationCreate.toJson()),
        body: jsonEncode({
          "name": "sf",
          "email": "shahbazvidicraze@gmail.com",
          "annual_team_allocation": 11,
        }),
      );
      // log(orginizationCreate.toJson().toString());
      // log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true && responseData['data'] != null) {
          final data = OrgnizatioResponse.fromJson(responseData['data']);
          return BaseResponse<OrgnizatioResponse>(
            success: true,
            message: responseData['message'] ?? 'Success',
            data: data,
          );
        } else {
          return BaseResponse<OrgnizatioResponse>(
            success: false,
            message: responseData['message'] ?? 'Failed to create organization',
            data: null,
          );
        }
      } else {
        log(response.body);
        return BaseResponse<OrgnizatioResponse>(
          success: false,
          message: 'HTTP error: ${response.statusCode}',
          data: null,
        );
      }
    } catch (e) {
      return BaseResponse<OrgnizatioResponse>(
        success: false,
        message: 'Exception occurred: $e',
        data: null,
      );
    }
  }

  static Future<BaseResponse<Object>> updateOrginization(
    OrginizationCreate orginizationCreate,
  ) async {
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
