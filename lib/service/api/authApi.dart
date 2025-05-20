import 'dart:convert';

import 'package:gaming_web_app/Base/model/authModel/loginModel.dart';
import 'package:gaming_web_app/Base/model/response/base_response.dart';

import '../../Base/model/authModel/redisterResponse.dart';
import '../../Base/model/authModel/signupModel.dart';
import '../../constants/SharedPreferencesKeysConstants.dart';
import '../../utils/SharedPreferencesUtil.dart';
import '../api_end_point.dart';
import '../dio.dart';

class AuthAPI {
  // static Future<LoginResponse> logIn(UserLoginRequest request) async {
  //   final response = await DioUtil.request<UserModel>(
  //     loadingText: 'Logging in',
  //     endpoint: APIEndPoints.login,
  //     requestBody: request.toJson(),
  //     fromJsonT: UserModel.fromJson,
  //     httpRequestType: HttpRequestType.post,
  //   );
  //
  //   if (response.data != null) {
  //     await SharedPreferencesUtil.save(
  //       SharedPreferencesKeysConstants.bearerToken,
  //       response.data!.bearerToken!,
  //     );
  //   }
  //   return response;
  // }
  static Future<BaseResponse<UserResponse>> loginAdmin(LoginModel request) async {
    final response = await DioUtil.request<UserResponse>(
      loadingText: 'login',
      endpoint: APIEndPoints.admin,
      requestBody: request.toJson(),
      fromJsonT: UserResponse.fromJson,
      httpRequestType: HttpRequestType.post,
    );
      if (response.data != null) {
        await SharedPreferencesUtil.save(
          SharedPreferencesKeysConstants.bearerToken,
          response.data!.accessToken!,
        );
      }
    return response;
  }
  static Future<BaseResponse<UserResponse>> loginUser(LoginModel request) async {
    final response = await DioUtil.request<UserResponse>(
      loadingText: 'login',
      endpoint: APIEndPoints.login,
      requestBody: request.toJson(),
      fromJsonT: UserResponse.fromJson,
      httpRequestType: HttpRequestType.post,
    );
      if (response.data != null) {
        await SharedPreferencesUtil.save(
          SharedPreferencesKeysConstants.bearerToken,
          response.data!.accessToken!,
        );

        await SharedPreferencesUtil.save(
          SharedPreferencesKeysConstants.user_response,
          jsonEncode(response.data!.toJson()), // ✅ Save JSON string
        );
      }
    return response;
  }

  static Future<BaseResponse<RegisterResponse>> registerUser(UserModel request) async {
    final response = await DioUtil.request<RegisterResponse>(
      loadingText: 'Register',
      endpoint: APIEndPoints.register,
      requestBody: request.toJson(),
      fromJsonT: RegisterResponse.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }





}