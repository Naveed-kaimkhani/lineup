// class ActivationRecord {
//   final int recordId;
//   final String organizationName;
//   final String organizationCode;
//   final String? promoCode;
//   final String activatedAt;

//   ActivationRecord({
//     required this.recordId,
//     required this.organizationName,
//     required this.organizationCode,
//     this.promoCode,
//     required this.activatedAt,
//   });

//   // factory ActivationRecord.fromJson(Map<String, dynamic> json) {
//   //   return ActivationRecord(
//   //     recordId: json['record_id'],
//   //     organizationName: json['organization']['name'],
//   //     organizationCode: json['organization']['organization_code'],
//   //     promoCode: json['promo_code'] != null ? json['promo_code']['code'] : '-', // fallback if null
//   //     activatedAt: json['activated_at'],
//   //   );
//   // }
//   factory ActivationRecord.fromJson(Map<String, dynamic> json) {
//     return ActivationRecord(
//       recordId: json['record_id'],
//       organizationName: json['organization']?['name'] ?? '-', // null safety
//       organizationCode: json['organization']?['organization_code'] ?? '-',
//       promoCode: json['promo_code'] ?? '-', // it's a plain string now
//       activatedAt: json['date'], // assuming you want to use the 'date' field
//     );
//   }
// }



class ActivationRecord {
  final int recordId;
  final String organizationName;
  final String organizationCode;
  final String? promoCode;
  final String activatedAt;
  final String type;
  final int slotId;

  ActivationRecord({
    required this.recordId,
    required this.organizationName,
    required this.organizationCode,
    this.promoCode,
    required this.activatedAt,
    required this.type,
    required this.slotId,
  });

  factory ActivationRecord.fromJson(Map<String, dynamic> json) {
    // Extract slotId from the description string
    final String description = json['description'] ?? '';
    final RegExp slotIdRegex = RegExp(r'Slot ID:\s*(\d+)');
    final Match? match = slotIdRegex.firstMatch(description);
    final int extractedSlotId = match != null ? int.parse(match.group(1)!) : 0;

    return ActivationRecord(
      recordId: json['record_id'],
      organizationName: json['organization']?['name'] ?? '-',
      organizationCode: json['organization']?['organization_code'] ?? '-',
      promoCode: json['promo_code'] ?? '-',
      activatedAt: json['date'],
      type: json['type'] ?? '-',
      slotId: extractedSlotId,
    );
  }
}
