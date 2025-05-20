import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gaming_web_app/routes/router_generator.dart';
import 'package:gaming_web_app/routes/routes_path.dart';
import 'package:gaming_web_app/utils/globleLoader.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesPath.welcome,
          getPages: AppPages.routes,
          defaultTransition: Transition.fadeIn,
          navigatorKey: navigatorKey,

          // 👇 Key change here — use builder to wrap with Stack
          builder: (context, child) {
            return Stack(
              children: [
                child!,             // <- this is the routed screen
                const GlobalLoader(), // <- always visible on top
              ],
            );
          },
        );
      },
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gaming_web_app/routes/router_generator.dart';
// import 'package:gaming_web_app/routes/routes_path.dart';
// import 'package:gaming_web_app/screens/authentication/welcome_screen.dart';
// import 'package:gaming_web_app/screens/main_dashboard/main_dashboard_screen.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:get/get_navigation/src/routes/transitions_type.dart';
//
// import '../../utils/globleLoader.dart';
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// class BaseWidget extends StatelessWidget {
//   const BaseWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//     return ScreenUtilInit(
//       designSize: const Size(1440, 1024),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           initialRoute: RoutesPath.welcome,
//           home:
//             Stack(
//             children:  [
//
//           WelcomeScreen(),
//               GlobalLoader(),    // Always on top
//           ]),
//           getPages: AppPages.routes,
//           defaultTransition: Transition.fadeIn,
//           navigatorKey: navigatorKey,  // Ensure this is the only place the key is used
//         );
//       },
//     );
//   }
// }

// Widget build(BuildContext context) {
  //   return ScreenUtilInit(
  //     // Keep your existing ScreenUtilInit configuration
  //     designSize: const Size(1440, 1024),
  //     minTextAdapt: true,
  //     splitScreenMode: true,
  //     builder: (_, child) {
  //       // Replace MaterialApp with GetMaterialApp
  //       return GetMaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         // You can keep using your existing Routes class
  //         // onGenerateRoute: Routes.generateRoute,
  //         initialRoute: RoutesPath.welcome,
  //         // Default home page
  //         home: WelcomeScreen(),
  //         getPages: AppPages.routes,
  //         // Optional: Add GetX transitions for smoother navigation
  //         defaultTransition: Transition.fadeIn,
  //
  //         // Optional: Initialize bindings for app-wide controllers
  //         // initialBinding: AppBinding(),
  //       );
  //     },
  //   );
  // }
// }
