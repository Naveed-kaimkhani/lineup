// import 'package:flutter/material.dart';
// import 'package:gaming_web_app/checkout/server_stub.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// void redirectToCheckout(BuildContext context) async {
//   final sessionId = await Server().createCheckout();
//   Navigator.of(context).push(MaterialPageRoute(
//     builder: (_) => CheckoutPage(sessionId: sessionId),
//   ));
// }
//
//
// class CheckoutPage extends StatefulWidget {
//   final String sessionId;
//   const CheckoutPage({super.key, required this.sessionId});
//
//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }
//
// class _CheckoutPageState extends State<CheckoutPage> {
//   late final WebViewController _controller;
//
//   final String apiKey = 'pk_test_...'; // Your Stripe Publishable Key
//   final String initialUrl =
//       'https://marcinusx.github.io/test1/index.html'; // Your hosted page with Stripe.js
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (url) {
//             if (url == initialUrl) {
//               _redirectToStripe(widget.sessionId);
//             }
//           },
//           onNavigationRequest: (request) {
//             if (request.url.contains('#/success')) {
//               Navigator.of(context).pushReplacementNamed('/success');
//               return NavigationDecision.prevent;
//             } else if (request.url.contains('#/cancel')) {
//               Navigator.of(context).pushReplacementNamed('/cancel');
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//           onWebResourceError: (error) {
//             debugPrint('WebView error: ${error.description}');
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(initialUrl));
//   }
//
//   Future<void> _redirectToStripe(String sessionId) async {
//     final js = '''
//       var stripe = Stripe('$apiKey');
//       stripe.redirectToCheckout({ sessionId: '$sessionId' }).then(function(result) {
//         if (result.error) {
//           document.body.innerHTML = "<h3 style='color:red;'>Payment failed: " + result.error.message + "</h3>";
//         }
//       });
//     ''';
//
//     try {
//       await _controller.runJavaScript(js);
//     } catch (e) {
//       debugPrint('JS error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Stripe Checkout')),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
//
// class SuccessPage extends StatelessWidget {
//   const SuccessPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Payment Success')),
//       body: const Center(child: Text('Payment completed successfully!')),
//     );
//   }
// }
//
// class CancelPage extends StatelessWidget {
//   const CancelPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Payment Cancelled')),
//       body: const Center(child: Text('Payment was cancelled.')),
//     );
//   }
// }
//
//
//
//
//
// // class CheckoutPage extends StatefulWidget {
// //   final String sessionId;
// //
// //   const CheckoutPage({Key? key, required this.sessionId}) : super(key: key);
// //
// //   @override
// //   State<CheckoutPage> createState() => _CheckoutPageState();
// // }
// //
// // class _CheckoutPageState extends State<CheckoutPage> {
// //   late final WebViewController _webViewController;
// //
// //   final String apiKey = 'pk_test_51RJ5ROQ7VW5LvG1xARfelRNNUG4uPYklS38PwEuZbH8zi1u8J4jobsmmQpWjPj9mYJ9iU2z2Bo3TfC7IUFDyEYLb00Gi3NvWQA'; // 🔐 Replace with your actual key
// //   final String initialUrl = 'https://marcinusx.github.io/test1/index.html'; // Must load Stripe.js
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _webViewController = WebViewController()
// //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
// //       ..setNavigationDelegate(
// //         NavigationDelegate(
// //           onPageFinished: (url) {
// //             if (url == initialUrl) {
// //               _redirectToStripe(widget.sessionId);
// //             }
// //           },
// //           onNavigationRequest: (NavigationRequest request) {
// //             if (request.url.contains('#/success')) {
// //               Navigator.of(context).pushReplacementNamed('/success');
// //               return NavigationDecision.prevent;
// //             } else if (request.url.contains('#/cancel')) {
// //               Navigator.of(context).pushReplacementNamed('/cancel');
// //               return NavigationDecision.prevent;
// //             }
// //             return NavigationDecision.navigate;
// //           },
// //         ),
// //       )
// //       ..loadRequest(Uri.parse(initialUrl));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: WebViewWidget(controller: _webViewController),
// //     );
// //   }
// //
// //   Future<void> _redirectToStripe(String sessionId) async {
// //     final jsCode = '''
// //       var stripe = Stripe('$apiKey');
// //       stripe.redirectToCheckout({ sessionId: '$sessionId' }).then(function (result) {
// //         if (result.error) {
// //           document.body.innerHTML = "<h3 style='color:red;'>Payment failed: " + result.error.message + "</h3>";
// //         }
// //       });
// //     ''';
// //
// //     try {
// //       await _webViewController.runJavaScript(jsCode);
// //     } catch (e) {
// //       debugPrint("JavaScript error: $e");
// //     }
// //   }
// // }