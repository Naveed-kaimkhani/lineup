

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
    

      if (response.success! && response.data != null) {
        final pay = response.data!;
       

        return 'Client secret and amount sent to JS. Awaiting payment...';
      } else {
        return 'Failed to create payment intent';
      }
    } catch (e) {
      return 'Payment failed: $e';
    }
  }




}
