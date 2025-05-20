import 'dart:developer';

import 'package:gaming_web_app/Base/model/authModel/signupModel.dart';

class RegisterResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final UserModel user;

  RegisterResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {

    return RegisterResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user.toJson(),
    };
  }
}
