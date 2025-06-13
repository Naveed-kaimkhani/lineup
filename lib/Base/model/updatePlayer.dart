class UpdatePlayerModel {
  final String? firstName;
  final String ? lastName;
  final String? jerseyNumber;
  final String? email;
  final String? phone;

  UpdatePlayerModel({
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.email,
    required this.phone,
  });

  factory UpdatePlayerModel.fromJson(Map<String, dynamic> json) {
    return UpdatePlayerModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      jerseyNumber: json['jersey_number'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'jersey_number': jerseyNumber,
      'email': email,
      'phone': phone,
    };
  }
}
