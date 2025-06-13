import 'dart:developer';

//
// class PaginatedUserResponse {
//   final List<User>? data;
//   final Meta? meta;
//   final Links? links;
//
//   PaginatedUserResponse({
//    this.data,
//    this.meta,
//   this.links,
//   });
//
//   factory PaginatedUserResponse.fromJson(Map<String, dynamic> json) {
//     debugger();
//     return PaginatedUserResponse(
//       data: (json['data'] as List).map((e) => User.fromJson(e)).toList(),
//       meta: Meta.fromJson(json['meta']),
//       links: Links.fromJson(json['links']),
//     );
//   }
// }
class UserListResponse {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final DateTime? createdAt;

  UserListResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.createdAt,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) {

    return UserListResponse(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'] ??"- -",
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
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

class Links {
  final String first;
  final String last;
  final String? prev;
  final String? next;

  Links({required this.first, required this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}

// import 'dart:developer';
//
// class PaginatedUserResponse {
//   final List<UserData>? data;
//   final PaginationMeta? meta;
//   final PaginationLinks? links;
//
//   PaginatedUserResponse({
//     this.data,
//     this.meta,
//     this.links,
//   });
//
//   factory PaginatedUserResponse.fromJson(Map<String, dynamic> json) {
//     debugger();
//     return PaginatedUserResponse(
//       data: (json['data'] as List<dynamic>?)
//           ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       meta: json['meta'] != null
//           ? PaginationMeta.fromJson(json['meta'])
//           : null,
//       links: json['links'] != null
//           ? PaginationLinks.fromJson(json['links'])
//           : null,
//     );
//   }
// }
//
// class PaginationMeta {
//   final int? currentPage;
//   final int? from;
//   final int? lastPage;
//   final String? path;
//   final int? perPage;
//   final int? to;
//   final int? total;
//
//   PaginationMeta({
//     this.currentPage,
//     this.from,
//     this.lastPage,
//     this.path,
//     this.perPage,
//     this.to,
//     this.total,
//   });
//
//   factory PaginationMeta.fromJson(Map<String, dynamic> json) {
//     debugger();
//     return PaginationMeta(
//       currentPage: json['current_page'] as int?,
//       from: json['from'] as int?,
//       lastPage: json['last_page'] as int?,
//       path: json['path'] as String?,
//       perPage: json['per_page'] as int?,
//       to: json['to'] as int?,
//       total: json['total'] as int?,
//     );
//   }
// }
//
// class PaginationLinks {
//   final String? first;
//   final String? last;
//   final String? prev;
//   final String? next;
//
//   PaginationLinks({
//     this.first,
//     this.last,
//     this.prev,
//     this.next,
//   });
//
//   factory PaginationLinks.fromJson(Map<String, dynamic> json) {
//     debugger();
//     return PaginationLinks(
//       first: json['first'] as String?,
//       last: json['last'] as String?,
//       prev: json['prev'] as String?,
//       next: json['next'] as String?,
//     );
//   }
// }
//
//
//
//
// class UserData {
//   final int? id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? phone;
//   final DateTime? createdAt;
//
//   UserData({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.createdAt,
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) {
//     debugger();
//     return UserData(
//       id: json['id'] as int?,
//       firstName: json['first_name'] as String?,
//       lastName: json['last_name'] as String?,
//       email: json['email'] as String?,
//       phone: json['phone'] as String?,
//       createdAt: json['created_at'] != null
//           ? DateTime.tryParse(json['created_at'])
//           : null,
//     );
//   }
// }
