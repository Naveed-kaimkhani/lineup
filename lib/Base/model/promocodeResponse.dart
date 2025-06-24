import 'dart:developer';

class SubscriptionInfo {
  final int? organizationAccessCode;
  final int? subscriptionExpiresAt;

  SubscriptionInfo({
    required this.organizationAccessCode,
    required this.subscriptionExpiresAt,
  });

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    // log("on wron valuse");
    // log(json.toString());
    return SubscriptionInfo(
      // organizationAccessCode: json['organization_code'] as String,
      // subscriptionExpiresAt: json['subscription_expires_at'] as String,
      organizationAccessCode: json['slot_id'],
      subscriptionExpiresAt: json['available_team_slots_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organization_access_code': organizationAccessCode,
      'subscription_expires_at': subscriptionExpiresAt,
    };
  }
}
