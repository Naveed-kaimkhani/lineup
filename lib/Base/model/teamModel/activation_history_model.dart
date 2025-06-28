
class ActivationRecord {
  final int recordId;
  final String type;
  final String activatedAt;
  final int slotId;

  final String? promoCode;
  final String? amountDisplay;
  final String? currency;
  final String? status;
  final String? organizationName;
  final String? organizationCode;
  final String? description;

  ActivationRecord({
    required this.recordId,
    required this.type,
    required this.activatedAt,
    required this.slotId,
    this.promoCode,
    this.amountDisplay,
    this.currency,
    this.status,
    this.organizationName,
    this.organizationCode,
    this.description,
  });

  factory ActivationRecord.fromJson(Map<String, dynamic> json) {
    final String description = json['description'] ?? '';
    final RegExp slotIdRegex = RegExp(r'Slot ID:\s*(\d+)');
    final Match? match = slotIdRegex.firstMatch(description);
    final int extractedSlotId = match != null ? int.parse(match.group(1)!) : 0;

    return ActivationRecord(
      recordId: json['record_id'],
      type: json['type'] ?? '-',
      activatedAt: json['date'] ?? '',
      slotId: extractedSlotId,
      promoCode: json['promo_code'], // Only for type: Promo
      amountDisplay: json['amount_display'], // Only for type: Paid
      currency: json['currency'],
      status: json['status'],
      organizationName: json['organization']?['name'],
      organizationCode: json['organization']?['organization_code'],
      description: description,
    );
  }
}

