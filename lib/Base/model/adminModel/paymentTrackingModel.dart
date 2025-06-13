class PaymentResponse {
  final List<PaymentModel>? data;
  final MetaModel? meta;
  final LinksModel? links;

  PaymentResponse({
    this.data,
    this.meta,
    this.links,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      data: (json['data'] as List?)
          ?.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null,
      links: json['links'] != null ? LinksModel.fromJson(json['links']) : null,
    );
  }
}

class PaymentModel {
  final int? id;
  final int? userId;
  final int? teamId;
  final String? stripePaymentIntentId;
  final double? amount;
  final String? currency;
  final String? status;
  final String? paidAt;
  final String? createdAt;
  final String? updatedAt;
  final UserModel? user;
  final TeamModel? team;

  PaymentModel({
    this.id,
    this.userId,
    this.teamId,
    this.stripePaymentIntentId,
    this.amount,
    this.currency,
    this.status,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.team,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      teamId: json['team_id'] as int?,
      stripePaymentIntentId: json['stripe_payment_intent_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      paidAt: json['paid_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      team: json['team'] != null ? TeamModel.fromJson(json['team']) : null,
    );
  }
}

class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
    );
  }
}

class TeamModel {
  final int? id;
  final String? name;

  TeamModel({
    this.id,
    this.name,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class MetaModel {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  MetaModel({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'] as int?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }
}

class LinksModel {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  LinksModel({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }
}
