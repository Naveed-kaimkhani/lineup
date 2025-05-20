class PlayerInputModel {
  final String? playerCountry;
  final String? playerLastName;
  final String? playerJerseyNumber;
  final String? playerEmail;
  final String? playerPhone;
  final int? id;

  PlayerInputModel({
    this.playerCountry,
     this.playerLastName,
     this.playerJerseyNumber,
     this.playerEmail,
   this.playerPhone,
   this.id,
  });

  factory PlayerInputModel.fromJson(Map<String, dynamic> json) {
    return PlayerInputModel(
      playerCountry: json['first_name'] ?? '',
      playerLastName: json['last_name'] ?? '',
      playerJerseyNumber: json['jersey_number'] ?? '',
      playerEmail: json['email'] ?? '',
      playerPhone: json['playerPhone'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': playerCountry,
      'last_name': playerLastName,
      'jersey_number': playerJerseyNumber,
      'email': playerEmail,
      'playerPhone': playerPhone,
      'id': id,
    };
  }
}
