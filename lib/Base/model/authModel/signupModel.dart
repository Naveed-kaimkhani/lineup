import 'dart:developer';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  // Convert a JSON map to a UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      confirmPassword: json['password_confirmation'],
    );
  }

  // Ensure toJson is public
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

}
