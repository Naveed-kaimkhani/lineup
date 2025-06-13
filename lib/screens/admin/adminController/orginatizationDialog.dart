import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/widgets/buttons/primary_button.dart';

class NameEmailDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController orgCodeController;
  final VoidCallback onSubmit;

  const NameEmailDialog({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.orgCodeController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(
            "Enter Organizations Details   ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          SizedBox(width: 20),
          // Spacer(),
          InkWell(
            onTap: () {
              Get.back();
            },

            child: Icon(Icons.cancel, size: 30, color: Colors.red),
          ),
        ],
      ),

      // Padding(padding:EdgeInsets.all(20) ,child: Text("Enter Organizations Details",style: descriptionHeader.copyWith(
      //   fontSize:  20 ,
      //   color: AppColors.secondaryColor,
      // ),),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ), const SizedBox(height: 16),

          TextField(
            controller: orgCodeController,
            decoration: const InputDecoration(
              labelText: 'Organization Code',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        PrimaryButton(
          width: double.infinity,
          onTap: onSubmit,
          title: 'Submit',
          backgroundColor: AppColors.descriptiveTextColor,
        ),
      ],
    );
  }
}

class FCreatePromoCodeDialog extends StatelessWidget {
  final TextEditingController code;
  final TextEditingController description;
  final TextEditingController expires_at;
  final TextEditingController max_uses;
  final TextEditingController use_count;
  final TextEditingController max_uses_per_user;
  final VoidCallback onSubmit;

  const FCreatePromoCodeDialog({
    super.key,
    required this.code,
    required this.description,
    required this.expires_at,
    required this.max_uses,
    required this.use_count,
    required this.max_uses_per_user,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(
            "Promo Code Detail   ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          SizedBox(width: 20),
          // Spacer(),
          InkWell(
            onTap: () {
              Get.back();
            },

            child: Icon(Icons.cancel, size: 30, color: Colors.red),
          ),
        ],
      ),

      // Padding(padding:EdgeInsets.all(20) ,child: Text("Enter Organizations Details",style: descriptionHeader.copyWith(
      //   fontSize:  20 ,
      //   color: AppColors.secondaryColor,
      // ),),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: code,
            decoration: const InputDecoration(
              labelText: 'Code',
              labelStyle: TextStyle(color: Colors.grey), // Change this color
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: description,
            decoration: const InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.grey), // Change this color
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: expires_at,
            decoration: const InputDecoration(
              labelText: 'Expires At', labelStyle: TextStyle(color: Colors.grey), // Change this color

              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),
          TextField(
            controller: max_uses,
            decoration: const InputDecoration(
              labelText: 'max_uses',
              labelStyle: TextStyle(color: Colors.grey), // Change this color
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 16),
          // TextField(
          //   controller: use_count,
          //   decoration: const InputDecoration(
          //     labelText: 'use_count',
          //     border: OutlineInputBorder(),
          //   ),
          //   keyboardType: TextInputType.number,
          // ),
          const SizedBox(height: 16),
          TextField(
            controller: use_count,
            decoration: const InputDecoration(
              labelText: 'max_uses_per_user',
              labelStyle: TextStyle(color: Colors.grey), // Change this color
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        PrimaryButton(
          width: double.infinity,
          onTap: onSubmit,
          title: 'Submit',
          backgroundColor: AppColors.descriptiveTextColor,
        ),
      ],
    );
  }
}

class PosisionedDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController labelController;
  final TextEditingController categoryController;
  final VoidCallback onSubmit;

  const PosisionedDialog({
    super.key,
    required this.nameController,
    required this.labelController,
    required this.categoryController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(
            "Positioned Detail   ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          SizedBox(width: 20),
          // Spacer(),
          InkWell(
            onTap: () {
              Get.back();
            },

            child: Icon(Icons.cancel, size: 30, color: Colors.red),
          ),
        ],
      ),

      // Padding(padding:EdgeInsets.all(20) ,child: Text("Enter Organizations Details",style: descriptionHeader.copyWith(
      //   fontSize:  20 ,
      //   color: AppColors.secondaryColor,
      // ),),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: labelController,
            decoration: const InputDecoration(
              labelText: 'Label',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        PrimaryButton(
          width: double.infinity,
          onTap: onSubmit,
          title: 'Submit',
          backgroundColor: AppColors.descriptiveTextColor,
        ),
      ],
    );
  }
}

class PromoCodeDialog extends StatelessWidget {
  final TextEditingController nameController;

  final VoidCallback onSubmit;

  const PromoCodeDialog({
    super.key,
    required this.nameController,

    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Text(
            '  Apply Promo Code',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          Spacer(),
          // Spacer(),
          InkWell(
            onTap: () {
              Get.back();
            },

            child: Icon(Icons.cancel, size: 50, color: Colors.red),
          ),
        ],
      ),

      content: SizedBox(
        width: 700,
        height: 300,
        child:

      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Enter a Promo Code',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      )
        ,),
      actions: [
        PrimaryButton(
          width: double.infinity,
          onTap: onSubmit,
          title: 'Submit',
          backgroundColor: AppColors.descriptiveTextColor,
        ),
      ],
    );
  }
}
void showPaymentDialog(
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
// void showPaymentDialog(
//   BuildContext context, {
//   required VoidCallback PromoCode,
//   required VoidCallback OnlinePayment,
// }) {
//   showDialog(
//     context: context,
//     // barrierColor: Colors.white,
//     builder:
//         (context) => AlertDialog(
//           backgroundColor: Colors.white,
//           title: Row(
//             children: [
//               Text(
//                 '  Select Payment Type',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.secondaryColor,
//                 ),
//               ),
//               Spacer(),
//               // Spacer(),
//               InkWell(
//                 onTap: () {
//                   Get.back();
//                 },
//
//                 child: Icon(Icons.cancel, size: 50, color: Colors.red),
//               ),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text('We want to select a payment type'),
//               SizedBox(height: 20),
//             ],
//           ),
//
//           actions: [
//             Row(
//               children: [
//                 Expanded(
//                   child: PrimaryButton(
//                     width: double.infinity,
//                     onTap: PromoCode,
//                     title: '  Promo Code   ',
//                     backgroundColor: AppColors.primaryColor,
//                   ),
//                 ),
//                 const SizedBox(width: 30),
//                 Expanded(
//                   child: PrimaryButton(
//                     width: double.infinity,
//                     onTap: OnlinePayment,
//                     title: '  Online Payment  ',
//                     backgroundColor: AppColors.descriptiveTextColor,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//   );
// }
