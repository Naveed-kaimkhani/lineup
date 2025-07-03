import '../../Base/model/authModel/forggotPasswordRequest.dart';
import '../../Base/model/response/base_response.dart';
import '../api_end_point.dart';
import '../dio.dart';

class PasswordApi{



  static Future<BaseResponse> forgotPassword(ForgotPasswordRequest request) async {
    final response = await DioUtil.request<ForgotPasswordRequest>(
      loadingText: 'login',
      endpoint: APIEndPoints.forgotPassword,
      requestBody: request.toJson(),
      fromJsonT: ForgotPasswordRequest.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }


  static Future<BaseResponse> orgForgotPassword(ForgotPasswordRequest request) async {
    final response = await DioUtil.request<ForgotPasswordRequest>(
      loadingText: 'login',
      endpoint: APIEndPoints.orgforgotPassword,
      requestBody: request.toJson(),
      fromJsonT: ForgotPasswordRequest.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }


  static Future<BaseResponse> resetPassword(ResetPasswordRequest request) async {
    final response = await DioUtil.request<ResetPasswordRequest>(
      loadingText: 'login',
      endpoint: APIEndPoints.resetPassword,
      requestBody: request.toJson(),
      fromJsonT: ResetPasswordRequest.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }



  static Future<BaseResponse> orgresetPassword(ResetPasswordRequest request) async {
    final response = await DioUtil.request<ResetPasswordRequest>(
      loadingText: 'login',
      endpoint: APIEndPoints.orgResetPassword,
      requestBody: request.toJson(),
      fromJsonT: ResetPasswordRequest.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }



}