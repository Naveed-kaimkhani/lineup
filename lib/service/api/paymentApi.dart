

// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'dart:js' as js;
// import 'package:flutter_stripe_web/flutter_stripe_web.dart';
import '../../Base/model/paymantModel.dart';
import '../../Base/model/response/base_response.dart';
import '../api_end_point.dart';
import '../dio.dart';

class PaymentApi {
  // Create Payment Intent on backend
  static Future<BaseResponse<PaymentIntents>> createPaymentIntentForTeam(int teamId) async {
    final response = await DioUtil.request<PaymentIntents>(
      loadingText: 'Creating Payment Intent',
      endpoint: "${APIEndPoints.paymentModle}$teamId/create-payment-intent",
      requestBody: {}, // or pass data as needed by your API
      fromJsonT: PaymentIntents.fromJson,
      httpRequestType: HttpRequestType.post,
    );

    return response;
  }

 Future<String> startPayment({required int teamId}) async {
    try {
      final response = await createPaymentIntentForTeam(teamId);
      print("Payment Intent Response: $response");

      if (response.success! && response.data != null) {
        final pay = response.data!;
        print("Client Secret: ${pay.clientSecret}");
        print("Amount: ${pay.amount}");


        return 'Client secret and amount sent to JS. Awaiting payment...';
      } else {
        return 'Failed to create payment intent';
      }
    } catch (e) {
      print("General error: $e");
      return 'Payment failed: $e';
    }
  }

  // static Future<String> startPayment({required int teamId}) async {
  //   try {
  //     final response = await createPaymentIntentForTeam(teamId);
  //     print("Payment Intent Response: $response");
  //
  //     if (response.success! && response.data != null) {
  //       final pay = response.data!;
  //       print("Client Secret: ${pay.clientSecret}");
  //
  //       try {
  //         await Stripe.instance.confirmPayment(
  //           paymentIntentClientSecret: pay.clientSecret,
  //           data: PaymentMethodParams.card(
  //             paymentMethodData: PaymentMethodData(
  //               billingDetails: BillingDetails(
  //                 name: 'Test User',
  //                 email: 'test@example.com',
  //               ),
  //             ),
  //           ),
  //         );
  //         print("Payment confirmed successfully.");
  //         return 'Payment successful!';
  //       } catch (e) {
  //         print("Stripe confirmPayment error: $e");
  //         return 'Payment failed: $e';
  //       }
  //     } else {
  //       return 'Failed to create payment intent';
  //     }
  //   } catch (e) {
  //     print("General error: $e");
  //     return 'Payment failed: $e';
  //   }
  // }
  // Start payment process
  // static Future<String> startPayment({required int teamId}) async {
  //   try {
  //     final response = await createPaymentIntentForTeam(teamId);
  //     print("Payment Intent Response: $response");
  //
  //     if (response.success!) {
  //       final pay = response.data!;
  //       print("Client Secret: ${response.data!.clientSecret}");
  //       print("Amount: ${response.data!.amount}");
  //       print("Currency: ${response.data!.currency}");
  //
  //       try {
  //         await Stripe.instance.confirmPayment(
  //           data: PaymentMethodParams.card(
  //             paymentMethodData: PaymentMethodData(),
  //           ),
  //           paymentIntentClientSecret: response.data!.clientSecret,
  //         );
  //         print("Payment confirmed successfully.");
  //         return 'Payment successful!';
  //       } catch (e) {
  //         print("Stripe confirmPayment error: $e");
  //         return 'Payment failed: $e';
  //       }
  //     } else {
  //       print("Failed to create payment intent.");
  //       return 'Failed to create payment intent';
  //     }
  //   } on StripeException catch (e) {
  //     print("StripeException caught: ${e.error.localizedMessage}");
  //     return 'Payment failed: ${e.error.localizedMessage}';
  //   } catch (e) {
  //     print("Unknown error: $e");
  //     return 'Payment failed: $e';
  //   }
  // }



}
