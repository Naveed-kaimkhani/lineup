import 'dart:developer';

class OrginizationCreate {
  final String? name;
  final String? email;
  final String? organization_code;
  final String? id;

  OrginizationCreate({this.name, this.email, this.organization_code, this.id});

  // Optional: fromJson and toJson methods if needed for APIs
  factory OrginizationCreate.fromJson(Map<String, dynamic> json) {
    return OrginizationCreate(
      name: json['name'] as String?,
      organization_code: json['organization_code'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'annual_team_allocation': organization_code,
      
      // 'id': id,
    };
  }
}

class OrgnizatioResponse {
  final int? id;
  final String? name;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrgnizatioResponse({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory OrgnizatioResponse.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return OrgnizatioResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
