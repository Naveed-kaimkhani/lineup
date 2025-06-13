class SubscriptionInfo {
  final String? organizationAccessCode;
  final String? subscriptionExpiresAt;

  SubscriptionInfo({
    required this.organizationAccessCode,
    required this.subscriptionExpiresAt,
  });

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    return SubscriptionInfo(
      organizationAccessCode: json['organization_access_code'] as String,
      subscriptionExpiresAt: json['subscription_expires_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organization_access_code': organizationAccessCode,
      'subscription_expires_at': subscriptionExpiresAt,
    };
  }
}
