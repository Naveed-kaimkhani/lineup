import 'package:flutter/material.dart';
import 'package:gaming_web_app/routes/routes_path.dart';
import 'package:gaming_web_app/screens/authentication/forgot_password_screen.dart';
import 'package:gaming_web_app/screens/authentication/sign_in_screen.dart';
import 'package:gaming_web_app/screens/authentication/sign_up_screen.dart';
import 'package:gaming_web_app/screens/authentication/welcome_screen.dart';
import 'package:gaming_web_app/screens/main_dashboard/main_dashboard_screen.dart';
import 'package:gaming_web_app/screens/main_dashboard/purchase_team_screen.dart';
import 'package:gaming_web_app/screens/organization_dashboard/organization_dashboard_screen.dart';
import 'package:gaming_web_app/screens/organization_dashboard/organization_signin.dart';
import 'package:gaming_web_app/screens/organization_dashboard/payment_history_screen.dart';
import 'package:gaming_web_app/screens/organization_dashboard/team_details_screen.dart';
import 'package:gaming_web_app/screens/team_dashboard/add_new_player_screen.dart';
import 'package:gaming_web_app/screens/team_dashboard/save_pdf_screen.dart';
import 'package:gaming_web_app/screens/team_dashboard/team_dashboard_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/admin/adminDashboard.dart';

class AppPages {
  static final routes = [
    GetPage(name: RoutesPath.welcome, page: () => WelcomeScreen()),
    GetPage(name: RoutesPath.signIn, page: () => SignInScreen()),
    GetPage(name: RoutesPath.signUp, page: () => SignUpScreen()),
    GetPage(
      name: RoutesPath.forgotPassword,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: RoutesPath.mainDashboardScreen,
      page: () => MainDashboardScreen(),
    ),
    GetPage(
      name: RoutesPath.organizationDashboardScreen,
      page: () => OrganizationDashboardScreen(),
    ),
    GetPage(
      name: RoutesPath.teamDashboardScreen,
      page: () => TeamDashboardScreen(),
    ),
    GetPage(
      name: RoutesPath.addNewPlayerScreen,
      page: () => AddNewPlayerScreen(),
    ),
    GetPage(name: RoutesPath.savePdfScreen, page: () => SavePdfScreen()),
    GetPage(
      name: RoutesPath.purchaseTeamScreen,
      page: () => PurchaseTeamScreen(),
    ),
    GetPage(
      name: RoutesPath.adminDashboardScreen,
      page: () => AdminDashboardScreen(),
    ),

    GetPage(
      name: RoutesPath.OrganizationSignin,
      page: () => OrganizationSignin(),
    ),

    GetPage(
      name: RoutesPath.paymentHistoryScreen,
      page: () => PaymentHistoryScreen(),
    ),

 GetPage(
      name: RoutesPath.signUpScreen,
      page: () => SignUpScreen(),
    ),

    // GetPage(
    //   name: RoutesPath.teamDetailsScreen,
    //   page: () => TeamDetailsScreen(),
    // ),
  ];
}

// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RoutesPath.welcome:
//         return MaterialPageRoute(
//           builder: (_) => WelcomeScreen(),
//           settings: const RouteSettings(name: 'WelcomeScreen'),
//         );
//       case RoutesPath.signIn:
//         return MaterialPageRoute(
//           builder: (_) => SignInScreen(),
//           settings: const RouteSettings(name: 'SignInScreen'),
//         );
//       case RoutesPath.signUp:
//         return MaterialPageRoute(
//           builder: (_) => SignUpScreen(),
//           settings: const RouteSettings(name: 'SignUpScreen'),
//         );
//       case RoutesPath.forgotPassword:
//         return MaterialPageRoute(
//           builder: (_) => ForgotPasswordScreen(),
//           settings: const RouteSettings(name: 'ForgotPasswordScreen'),
//         );
//       case RoutesPath.mainDashboardScreen:
//         return MaterialPageRoute(
//           builder: (_) => MainDashboardScreen(),
//           settings: const RouteSettings(name: 'MainDashboardScreen'),
//         );
//       case RoutesPath.organizationDashboardScreen:
//         return MaterialPageRoute(
//           builder: (_) => OrganizationDashboardScreen(),
//           settings: const RouteSettings(name: 'OrganizationDashboardScreen'),
//         );
//       case RoutesPath.teamDashboardScreen:
//         return MaterialPageRoute(
//           builder: (_) => TeamDashboardScreen(),
//           settings: const RouteSettings(name: 'TeamDashboardScreen'),
//         );
//       case RoutesPath.addNewPlayerScreen:
//         return MaterialPageRoute(
//           builder: (_) => AddNewPlayerScreen(),
//           settings: const RouteSettings(name: 'AddNewPlayerScreen'),
//         );
//       case RoutesPath.savePdfScreen:
//         return MaterialPageRoute(
//           builder: (_) => SavePdfScreen(),
//           settings: const RouteSettings(name: 'SavePdfScreen'),
//         );
//       case RoutesPath.purchaseTeamScreen:
//         return MaterialPageRoute(
//           builder: (_) => PurchaseTeamScreen(),
//           settings: const RouteSettings(name: 'PurchaseTeamScreen'),
//         );
//       default:
//         return MaterialPageRoute(builder: (_) => WelcomeScreen());
//     }
//   }
// }
