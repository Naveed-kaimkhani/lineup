import 'dart:developer';

class PromoCodeRequest {
  final String? code;
  final int? teamId;

  PromoCodeRequest({required this.code, this.teamId});

  // Convert JSON to Dart object
  factory PromoCodeRequest.fromJson(Map<String, dynamic> json) {
    return PromoCodeRequest(
      code: json['code'] as String?,
      teamId: json['team_id'] as int?,
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    // print(teamId ?? "-");
    return {'code': code, 'team_id': teamId};
  }
}
