class ActivationRecord {
  final int recordId;
  final String organizationName;
  final String organizationCode;
  final String? promoCode;
  final String activatedAt;

  ActivationRecord({
    required this.recordId,
    required this.organizationName,
    required this.organizationCode,
     this.promoCode,
    required this.activatedAt,
  });

factory ActivationRecord.fromJson(Map<String, dynamic> json) {
  return ActivationRecord(
    recordId: json['record_id'],
    organizationName: json['organization']['name'],
    organizationCode: json['organization']['organization_code'],
    promoCode: json['promo_code'] != null ? json['promo_code']['code'] : '-', // fallback if null
    activatedAt: json['activated_at'],
  );
}
}
