class SettingsModel {
  double unlockPriceAmount;
  // int accessDurationDays;
  bool notifyAdminOnPayment;
  String? adminNotificationEmail;

  SettingsModel({
    required this.unlockPriceAmount,
    // required this.accessDurationDays,
    required this.notifyAdminOnPayment,
    this.adminNotificationEmail,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      unlockPriceAmount: double.tryParse(json['unlock_price_amount'].toString()) ?? 0.0,
      // accessDurationDays: json['access_duration_days'] ?? 0,
      notifyAdminOnPayment: json['notify_admin_on_payment'] ?? false,
      adminNotificationEmail: json['admin_notification_email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unlock_price_amount': unlockPriceAmount,
      'access_duration_days': 365,
      'notify_admin_on_payment': notifyAdminOnPayment,
      'admin_notification_email': adminNotificationEmail,
    };
  }
}
