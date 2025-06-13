import 'dart:developer';

// class PromoCodeResponse {
//   final List<PromoCodeModel> data;
//   final MetaModel meta;
//   final LinksModel links;
//
//   PromoCodeResponse({
//     required this.data,
//     required this.meta,
//     required this.links,
//   });
//
//   factory PromoCodeResponse.fromJson(Map<String, dynamic> json) {
//     debugger();
//     return PromoCodeResponse(
//       data: (json['data'] as List)
//           .map((e) => PromoCodeModel.fromJson(e))
//           .toList(),
//       meta: MetaModel.fromJson(json['meta']),
//       links: LinksModel.fromJson(json['links']),
//     );
//   }
// }

class PromoCodeResponse {
  final int? id;
  final String? code;
  final String? description;
  final String? expiresAt;
  final int? maxUses;
  final int? useCount;
  final int? maxUsesPerUser;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  PromoCodeResponse({
    this.id,
    this.code,
    this.description,
    this.expiresAt,
    this.maxUses,
    this.useCount,
    this.maxUsesPerUser,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PromoCodeResponse.fromJson(Map<String, dynamic> json) {
    return PromoCodeResponse(
      id: json['id'],
      code: json['code'],
      description: json['description'],
      expiresAt: json['expires_at'],
      maxUses: json['max_uses'],
      useCount: json['use_count'],
      maxUsesPerUser: json['max_uses_per_user'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'expires_at': expiresAt,
      'max_uses': maxUses,
      'use_count': useCount,
      'max_uses_per_user': maxUsesPerUser,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class MetaModel {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;

  MetaModel({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class LinksModel {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  LinksModel({this.first, this.last, this.prev, this.next});

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}
