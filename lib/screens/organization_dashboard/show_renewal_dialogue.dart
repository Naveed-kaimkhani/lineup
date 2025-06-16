import 'package:flutter/material.dart';
import 'package:gaming_web_app/constants/app_colors.dart' show AppColors;
import 'package:gaming_web_app/constants/widgets/buttons/primary_button.dart';
import 'package:get/get.dart';

void showRenewalPaymentDialog(
    BuildContext context, {
      required VoidCallback PromoCode,
      required VoidCallback OnlinePayment,
    }) {
  final screenWidth = MediaQuery.of(context).size.width;
  final dialogWidth = screenWidth < 700 ? screenWidth : 700.0;

  showDialog(
    context: context,
    builder: (context) =>
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
                width: dialogWidth,
                // margin: EdgeInsets.all(20), // optional: margin around dialog
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      Text(
                        '  Select Payment Type',
                        style: TextStyle(
                          fontSize: 20,
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
                  content:Container(
                    width: dialogWidth,
                    // margin: EdgeInsets.all(20), // optional: margin around dialog
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      // const Text('We want to select a payment type'),
                      SizedBox(height: 20),
                    ],
                  )),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            width: double.infinity,
                            onTap: PromoCode,
                            title: '    Promo Code      ',
                            backgroundColor: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: PrimaryButton(
                            width: double.infinity,
                            onTap: OnlinePayment,
                            title: '    Online Payment    ',
                            backgroundColor: AppColors.descriptiveTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


        ],),
  );
}