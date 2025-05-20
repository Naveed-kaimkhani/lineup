import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../paymentView.dart';
import '../../service/api/paymentApi.dart';

class PaymentController extends GetxController {
  RxString paymentStatus = ''.obs;
  Future<void> paymentModel(BuildContext context, int teamId) async {
    final response = await PaymentApi.createPaymentIntentForTeam(teamId);

    // print(response.data!.currency!);
    // print(response.data!.amount!);
    // print(response.data!.clientSecret!);
    int amount = double.tryParse(response.data?.amount?.toString() ?? '0')?.toInt() ?? 0;

    if (response.success!) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentIntentWebViewPage(
            clientSecret: response.data!.clientSecret,
            amount: amount,
            currency: response.data!.currency, publishableKey: 'pk_test_51RJ5ROQ7VW5LvG1xARfelRNNUG4uPYklS38PwEuZbH8zi1u8J4jobsmmQpWjPj9mYJ9iU2z2Bo3TfC7IUFDyEYLb00Gi3NvWQA',
          ),
        ),
      );
    }
  }
}
