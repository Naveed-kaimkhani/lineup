class PaymentIntents {
  final String clientSecret;
  final String amount; // amount in cents
  final String currency;

  PaymentIntents({
    required this.clientSecret,
    required this.amount,
    required this.currency,
  });

  factory PaymentIntents.fromJson(Map<String, dynamic> json) {
    return PaymentIntents(
      clientSecret: json['clientSecret'] as String,
      amount: json['amount'].toString(),
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientSecret': clientSecret,
      'amount': amount,
      'currency': currency,
    };
  }
}
