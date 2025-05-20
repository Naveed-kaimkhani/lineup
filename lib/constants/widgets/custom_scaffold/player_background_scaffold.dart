// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PlayerBackgroundScaffold extends StatelessWidget {
//   final Widget body;
//   const PlayerBackgroundScaffold({super.key, required this.body});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Align(
//             alignment: Alignment.centerRight,
//             child: Image.asset(
//               'assets/images/player_background.png',
//               fit: BoxFit.contain,
//               width: 1400.w,
//               height: 1300.h,
//             ),
//           ),
//           Positioned.fill(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 117.w, vertical: 52.h),
//               child: SafeArea(child: body),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class PlayerBackgroundScaffold extends StatelessWidget {
  final Widget body;
  const PlayerBackgroundScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double imageWidth = screenWidth * 0.6; // Adjust as needed
          double imageHeight = constraints.maxHeight;

          return Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/player_background.png',
                  fit: BoxFit.contain,
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
              Positioned.fill(
                child: SafeArea(child: body),
              ),
            ],
          );
        },
      ),
    );
  }
}
