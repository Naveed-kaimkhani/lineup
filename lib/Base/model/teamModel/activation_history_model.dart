class ActivationRecord {
  final int recordId;
  final String organizationName;
  final String organizationCode;
  final String promoCode;
  final String activatedAt;

  ActivationRecord({
    required this.recordId,
    required this.organizationName,
    required this.organizationCode,
    required this.promoCode,
    required this.activatedAt,
  });

  factory ActivationRecord.fromJson(Map<String, dynamic> json) {
    return ActivationRecord(
      recordId: json['record_id'],
      organizationName: json['organization']['name'],
      organizationCode: json['organization']['organization_code'],
      promoCode: json['promo_code']['code'],
      activatedAt: json['activated_at'],
    );
  }
}
