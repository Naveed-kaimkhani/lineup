import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Base/controller/teamController/createTeamController.dart';
import '../../constants/app_colors.dart';
import '../../service/api/adminApi.dart';
import '../../utils/snackbarUtils.dart';
import '../admin/adminController/orginatizationDialog.dart';
import 'create_a_new_team_dialog.dart';

void showFullWidthDialogPay(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final dialogWidth =
      screenWidth < 600
          ? screenWidth
          : 600.0; // if screen width < 600, use full width; else fixed at 600
  final controlle = Get.find<NewTeamController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: dialogWidth,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Spacer(),
                  Text(
                    'CREATE NEW TEAM',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.cancel, size: 50, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 200),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => CreateTeamDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Organization',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // optional spacing between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showPaymentDialog(
                          context,
                          PromoCode: () {
                            // Navigator.pop(context);
                            controlle.promoCodeDialog(context);
                            // optional: close dialog after selection
                          },
                          OnlinePayment: () async {
                            final response = await AdminApi.getPaymentLink();
                            print(response);

                            if (response.success!) {
                              // Navigator.pop(context);
                              SnackbarUtils.showSuccess(
                                response.message.toString(),

                              );
                              controlle.launchPayUrl(response.data!.paymentUrl!);
                            } else {
                              SnackbarUtils.showErrorr(
                                response.message.toString(),
                              );
                              // Handle the case where no teams are returned
                              // teams.value = [];
                            }
                            // Handle Online Payment selection
                            print('Online Payment selected');
                            // Navigator.pop(
                            //   context,
                            // ); // optional: close dialog after selection
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003478),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

class PaymentResponsee {
  final String paymentUrl;

  PaymentResponsee({required this.paymentUrl});

  factory PaymentResponsee.fromJson(Map<String, dynamic> json) {
    return PaymentResponsee(paymentUrl: json['payment_url'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'payment_url': paymentUrl};
  }
}
