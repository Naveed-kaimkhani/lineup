import 'dart:developer';

import '../../Base/model/adminModel/adminOrgnization.dart';
import '../../Base/model/adminModel/paymentTrackingModel.dart';
import '../../Base/model/adminModel/promoCodeModel.dart';
import '../../Base/model/getAllUser.dart';
import '../../Base/model/orgnization.dart';
import '../../Base/model/positioned.dart';
import '../../Base/model/promoCodeReq.dart';
import '../../Base/model/promocodeResponse.dart';
import '../../Base/model/response/base_response.dart';
import '../../Base/model/teamModel/teamModel.dart';
import '../../screens/main_dashboard/slectorgPay.dart';
import '../api_end_point.dart';
import '../dio.dart';

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
  // static Future<BaseResponse<List<UserListResponse?>>> getOrganizations() async {
  //   try {
  //     final response = await DioUtil.request<BaseResponse<List<UserListResponse?>>>(
  //       endpoint: "/admin/organizations",
  //       httpRequestType: HttpRequestType.get,
  //       fromJsonT: (json) => UserListResponse.fromJson(json),
  //       cast: (object) {
  //
  //         // if (object is List) {
  //         //   // Cast the inner object (List<dynamic>) to List<UserListResponse?>
  //         //   return object.map<UserListResponse?>((e) {
  //         //     if (e is Map<String, dynamic>) {
  //         //       return UserListResponse.fromJson(e);
  //         //     }
  //         //     return null; // if item is not a map, return null to keep nullable list
  //         //   }).toList();
  //         // }
  //         return <UserListResponse?>[];
  //       },
  //     );
  //     return response;
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

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

  //
  // static Future<BaseResponse> createPosition(Position request) async {
  //   try {
  //     final response = await DioUtil.request<BaseResponse>(
  //       endpoint: APIEndPoints.admin_positions,
  //       fromJsonT: Position.fromJson,
  //       httpRequestType: HttpRequestType.get,
  //       // cast: (object) {
  //       //   if (object is List) {
  //       //     return object.cast<Position>();
  //       //   }
  //       //   return [];
  //       // },
  //     );
  //
  //     return response;
  //   } catch (e) {
  //     // Optionally, handle or log errors here
  //     print('Error: $e');
  //     return BaseResponse<List<Position>>(data: [],);
  //   }
  // }

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
      print('Error: $e');
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
        endpoint:"${APIEndPoints.getPromoCode}/${request!.id}",
        // fromJsonT: BaseResponse.fromJson, // Adjust if necessary
        requestBody:
            request!.toJson() , // ✅ Send the request body
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
      fromJsonT:  (json) => SubscriptionInfo.fromJson(json),
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }


  static Future<BaseResponse<OrganizationCodes>> orgCodeReq(
      String org,
      ) async {
    var data={
      "organization_access_code":org.toString()
    };
    final response = await DioUtil.request<OrganizationCodes>(
      loadingText: 'login',
      endpoint: APIEndPoints.orgCode,
       requestBody: data,
      fromJsonT:(json) => OrganizationCodes.fromJson(json),
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }
}
