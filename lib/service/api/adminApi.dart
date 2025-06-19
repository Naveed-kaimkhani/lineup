import 'dart:convert';
import 'dart:developer';
import 'package:gaming_web_app/Base/model/teamModel/activation_history_model.dart';
import 'package:gaming_web_app/constants/SharedPreferencesKeysConstants.dart';
import 'package:gaming_web_app/utils/SharedPreferencesUtil.dart';
import 'package:gaming_web_app/utils/snackbarUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Base/model/adminModel/adminOrgnization.dart';
import '../../Base/model/adminModel/paymentTrackingModel.dart';
import '../../Base/model/adminModel/promoCodeModel.dart';
import '../../Base/model/getAllUser.dart';
import '../../Base/model/positioned.dart';
import '../../Base/model/promoCodeReq.dart';
import '../../Base/model/promocodeResponse.dart';
import '../../Base/model/response/base_response.dart';
import '../../Base/model/teamModel/teamModel.dart';
import '../../screens/main_dashboard/slectorgPay.dart';
import '../api_end_point.dart';
import '../dio.dart';
import 'package:http/http.dart' as http;

class AdminApi {
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

  static Future<BaseResponse<List<Position?>>> adminPosition() async {
    try {
      final response = await DioUtil.request<List<Position>>(
        endpoint: APIEndPoints.admin_positions,
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

  static Future<BaseResponse<Position>> createPosition(Position request) async {
    try {
      final response = await DioUtil.request<Position>(
        endpoint: APIEndPoints.admin_positions,
        // fromJsonT: BaseResponse.fromJson, // Adjust if necessary
        requestBody: request.toJson(), // ✅ Send the request body
        httpRequestType: HttpRequestType.post,
        fromJsonT: Position.fromJson, // ✅ Use POST instead of GET
      );

      return response;
    } catch (e) {
      print('Error: $e');
      return BaseResponse(data: null);
    }
  }

  static Future<List<ActivationRecord>> fetchHistory() async {
    String? token = await SharedPreferencesUtil.read(
      SharedPreferencesKeysConstants.bearerToken,
    );

    final response = await http.get(
      Uri.parse(APIEndPoints.activationHistory),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((e) => ActivationRecord.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load activation history');
    }
  }

  static Future<BaseResponse<Position>> updatePosition(Position request) async {
    try {
      final response = await DioUtil.request<Position>(
        endpoint:
            '${APIEndPoints.admin_positions}/${request.id}', // Ensure this is the correct PUT endpoint
        requestBody: request.toJson(), // JSON body of the updated position
        httpRequestType: HttpRequestType.put, // ✅ Use PUT method
        fromJsonT: Position.fromJson, // Response deserialization
      );

      return response;
    } catch (e) {
      return BaseResponse(data: null);
    }
  }

  static Future<BaseResponse<List<PaymentModel?>>> adminPayment() async {
    try {
      final response = await DioUtil.request<List<PaymentModel>>(
        endpoint: APIEndPoints.admin_payments,
        fromJsonT: PaymentModel.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<PaymentModel>();
          }
          return [];
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<PaymentModel>>(data: []);
    }
  }

  static Future<BaseResponse<List<PromoCodeResponse?>>> getPromoCode() async {
    try {
      final response = await DioUtil.request<List<PromoCodeResponse>>(
        endpoint: APIEndPoints.getPromoCode,
        fromJsonT: PromoCodeResponse.fromJson,
        httpRequestType: HttpRequestType.get,
        cast: (object) {
          if (object is List) {
            return object.cast<PromoCodeResponse>();
          }
          return [];
        },
      );

      return response;
    } catch (e) {
      // Optionally, handle or log errors here
      print('Error: $e');
      return BaseResponse<List<PromoCodeResponse>>(data: []);
    }
  }

  static Future<BaseResponse<PaymentResponsee?>> getPaymentLink() async {
    try {
      final response = await DioUtil.request<PaymentResponsee>(
        endpoint: APIEndPoints.getPaymentLink,
        fromJsonT: PaymentResponsee.fromJson,
        httpRequestType: HttpRequestType.get,
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return BaseResponse(data: null);
    }
  }

  static Future<void> getRenewalPaymentLink() async {
    String? token = await SharedPreferencesUtil.read("org_access_token"); //
    try {
      final uri = Uri.parse(APIEndPoints.getRenewalPaymentLink);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // optional, based on API
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final paymentUrl = jsonData['data']?['payment_url'];
     
        launchPayUrl(paymentUrl);
      } else {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'] ?? 'Unknown error occurred';

        SnackbarUtils.showSuccess(message);
      }
    } catch (e) {
      print('Error: $e');
      // return BaseResponse(data: null);
    }
  }

  static Future<void> launchPayUrl(String link) async {
    final Uri url = Uri.parse(link);
    // final Uri url = Uri.parse('http://18.189.193.38/teams/${createTeamResponse.value?.id}/pay');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // launches in browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<BaseResponse<PromoCodeResponse>> createPromotoCode({
    PromoCodeResponse? request,
    bool? isBody,
  }) async {
    try {
      final response = await DioUtil.request<PromoCodeResponse>(
        endpoint: APIEndPoints.getPromoCode,
        // fromJsonT: BaseResponse.fromJson, // Adjust if necessary
        requestBody:
            isBody! ? request!.toJson() : null, // ✅ Send the request body
        httpRequestType: HttpRequestType.post,
        fromJsonT: PromoCodeResponse.fromJson, // ✅ Use POST instead of GET
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return BaseResponse(data: null);
    }
  }

  static Future<BaseResponse<PromoCodeResponse>> updatePromotoCode({
    PromoCodeResponse? request,
  }) async {
    try {
      final response = await DioUtil.request<PromoCodeResponse>(
        endpoint: "${APIEndPoints.getPromoCode}/${request!.id}",
        // fromJsonT: BaseResponse.fromJson, // Adjust if necessary
        requestBody: request!.toJson(), // ✅ Send the request body
        httpRequestType: HttpRequestType.put,
        fromJsonT: PromoCodeResponse.fromJson, // ✅ Use POST instead of GET
      );

      return response;
    } catch (e) {
      print('Error: $e');
      return BaseResponse(data: null);
    }
  }

  static Future<BaseResponse<List<UserListResponse>>?> getUser() async {
    try {
      final response = await DioUtil.request<List<UserListResponse>>(
        endpoint: "/admin/users",
        httpRequestType: HttpRequestType.get,
        fromJsonT: (json) => UserListResponse.fromJson(json),
        cast: (object) {
          if (object is List) {
            return object.cast<UserListResponse>();
          }
          return <UserListResponse>[];
        },
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<BaseResponse<SubscriptionInfo>> promocodeReq(
    PromoCodeRequest request,
  ) async {
    final response = await DioUtil.request<SubscriptionInfo>(
      loadingText: 'login',
      endpoint: APIEndPoints.reqPromoCode,
      requestBody: request.toJson(),
      fromJsonT: (json) => SubscriptionInfo.fromJson(json),
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }

  static Future<void> promocodeRenewalReq(PromoCodeRequest request) async {
    String? token = await SharedPreferencesUtil.read("org_access_token");

    try {
      final uri = Uri.parse(APIEndPoints.promoRenewal);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          SnackbarUtils.showSuccess(responseData['message'] ?? 'Success');
        } else {
          // Show failure message from API
          SnackbarUtils.showErrorr(
            responseData['message'] ?? 'Something went wrong',
          );
        }
      } else {
        // Unexpected status code (non-200)
        SnackbarUtils.showErrorr('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      SnackbarUtils.showErrorr('Something went wrong. Please try again.');
    }
  }

  static Future<BaseResponse<OrganizationCodes>> orgCodeReq(String org) async {
    var data = {"organization_access_code": org.toString()};
    final response = await DioUtil.request<OrganizationCodes>(
      loadingText: 'login',
      endpoint: APIEndPoints.orgCode,
      requestBody: data,
      fromJsonT: (json) => OrganizationCodes.fromJson(json),
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }
}
