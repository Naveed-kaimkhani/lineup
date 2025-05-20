import 'dart:developer';

import 'package:gaming_web_app/Base/model/authModel/signupModel.dart';

class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class UserResponse {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final UserResponseModel? user;

  UserResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  // Factory constructor to create a TokenResponse from JSON
  factory UserResponse.fromJson(Map<String, dynamic> json) {

    return UserResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      user: UserResponseModel.fromJson(json['user']),
    );
  }

  // Method to convert TokenResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user!.toJson(),
    };
  }
}



class UserResponseModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String? emailVerifiedAt;
  String createdAt;
  String updatedAt;
  int? role_id;

  UserResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
     this.role_id,
  });

  // Convert a UserModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role_id': role_id,
    };
  }

  // Convert a JSON map to a UserModel object
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      role_id: json['role_id'] ?? '',
    );
  }
}
