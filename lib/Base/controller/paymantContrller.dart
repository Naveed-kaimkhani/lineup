import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/api/paymentApi.dart';

class PaymentController extends GetxController {
  RxString paymentStatus = ''.obs;
  Future<void> paymentModel(BuildContext context, int teamId) async {
    final response = await PaymentApi.createPaymentIntentForTeam(teamId);

    
    if (response.success!) {
   
    }
  }
}
