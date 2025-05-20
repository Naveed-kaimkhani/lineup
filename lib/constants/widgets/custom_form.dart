import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaming_web_app/constants/app_colors.dart';
import 'package:gaming_web_app/constants/app_text_styles.dart';
class CustomForm extends StatelessWidget {
  final String header;
  final String description;
  final bool isBack;
  final Widget body;

  const CustomForm({
    super.key,
    required this.header,
    this.isBack =false,
    required this.description,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 620), // Desktop max width
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to left
        children: [
          isBack?  Row(children: [
                 Spacer(),
            Text(
              header.toUpperCase(),
              style: formHeaderStyle.copyWith(
                color: AppColors.secondaryColor,
                fontSize: MediaQuery.of(context).size.width < 600 ? 18 : 24,
              ),
              textAlign: TextAlign.start,
              softWrap: true,
            ),
            Spacer(),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child:
              Icon(Icons.cancel,color: Colors.red,)


              ,)
          ],):


          Text(
            header.toUpperCase(),
            style: formHeaderStyle.copyWith(
              color: AppColors.secondaryColor,
              fontSize: MediaQuery.of(context).size.width < 600 ? 18 : 24,
            ),
            textAlign: TextAlign.start,
            softWrap: true,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: descriptionStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width < 600 ? 14 : 16,
            ),
            softWrap: true,
          ),
          const SizedBox(height: 16),
          body,
        ],
      ),
    );
  }
}

// class CustomForm extends StatelessWidget {
//   final String header;
//   final String description;
//   final Widget body;
//   const CustomForm({
//     super.key,
//     required this.header,
//     required this.description,
//     required this.body,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 620.4.w,
//       padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Column(
//         children: [
//           Text(
//             header.toUpperCase(),
//             style: formHeaderStyle.copyWith(color: AppColors.secondaryColor),
//           ),
//           SizedBox(height: 19.75.h),
//           Text(description, style: descriptionStyle),
//           SizedBox(height: 19.75.h),
//           body,
//         ],
//       ),
//     );
//   }
// }
