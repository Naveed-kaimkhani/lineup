import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'constants.dart'; // contains secretKey and nikesPriceId

class Server {
  Future<String> createCheckout() async {
    final auth = 'Basic ${base64Encode(utf8.encode('$secretKey:'))}';

    final body = {
      'payment_method_types[0]': 'card',
      'line_items[0][price]': nikesPriceId,
      'line_items[0][quantity]': '1',
      'mode': 'payment',
      'success_url': 'http://localhost:8080/#/success',
      'cancel_url': 'http://localhost:8080/#/cancel',
    };

    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: auth,
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );
      return result.data['id'];
    } on DioError catch (e, s) {
      rethrow;
    }
  }
}


