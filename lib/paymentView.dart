import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;

class PaymentIntentWebViewPage extends StatelessWidget {
  final String clientSecret;
  final int amount; // in cents
  final String currency;
  final String publishableKey;

  PaymentIntentWebViewPage({
    required this.clientSecret,
    required this.amount,
    required this.currency,
    required this.publishableKey,
    Key? key,
  }) : super(key: key) {
    // Register the view factory only once
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) {
        final html.IFrameElement iframe = html.IFrameElement();

        // Generate the HTML content for the iframe
        final htmlContent = '''
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Stripe Payment</title>
<script src="https://js.stripe.com/v3/"></script>
<style>
  body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
  #payment-element { margin: 20px; }
  #submit { 
    display: block; 
    width: 90%; 
    background-color: #4CAF50; 
    color: white; 
    border: none; 
    padding: 10px; 
    font-size: 16px; 
    margin: 20px auto; 
    cursor: pointer; 
    border-radius: 4px;
  }
  #error-message { color: red; margin-top: 10px; text-align:center; }
</style>
</head>
<body>
<h3 style="text-align:center;">Stripe Payment Form</h3>
<form id="payment-form">
  <div id="payment-element"></div>
  <button id="submit" type="submit">
    Pay \$${(amount / 100).toStringAsFixed(2)} $currency
  </button>
  <div id="error-message"></div>
</form>
<script>
  let stripe, elements;

  window.onload = function() {
    startStripePayment();
  };

  async function startStripePayment() {
    stripe = Stripe("$publishableKey");
    elements = stripe.elements({ clientSecret: "$clientSecret" });

    const appearance = { theme: 'stripe' };
    const paymentElement = elements.create("payment", { appearance });
    paymentElement.mount("#payment-element");

    document.getElementById('payment-form').addEventListener('submit', async (event) => {
      event.preventDefault();

      const { error, paymentIntent } = await stripe.confirmPayment({
        elements,
        redirect: 'if_required' // <-- prevent automatic redirect
      });

      if (error) {
        const errorMessage = document.getElementById("error-message");
        errorMessage.style.color = "red";
        errorMessage.textContent = error.message;
      } else if (paymentIntent && paymentIntent.status === "succeeded") {
        const errorMessage = document.getElementById("error-message");
        errorMessage.style.color = "green";
        errorMessage.textContent = "Payment succeeded! Thank you.";
        document.getElementById("submit").disabled = true;
      } else {
        const errorMessage = document.getElementById("error-message");
        errorMessage.style.color = "blue";
        errorMessage.textContent = "Processing payment, please wait...";
      }
    });
  }
</script>
</body>
</html>
        ''';

        iframe.srcdoc = htmlContent;
        iframe.setAttribute('sandbox', 'allow-scripts allow-same-origin');
        iframe.style.border = 'none';
        iframe.style.width = '100%';
        iframe.style.height = '100%';

        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Payment')),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: HtmlElementView(viewType: 'iframeElement'),
      ),
    );
  }
}





// import 'dart:html' as html;
// import 'package:flutter/material.dart';
// import 'dart:ui_web' as ui;
//
// class PaymentIntentWebViewPage extends StatelessWidget {
//   final String clientSecret;
//   final int amount; // in cents
//   final String currency;
//   final String publishableKey;
//
//   PaymentIntentWebViewPage({
//     required this.clientSecret,
//     required this.amount,
//     required this.currency,
//     required this.publishableKey,
//     Key? key,
//   }) : super(key: key) {
//     // Register the view factory only once
//     ui.platformViewRegistry.registerViewFactory(
//       'iframeElement',
//           (int viewId) {
//         final html.IFrameElement iframe = html.IFrameElement();
//
//         // Generate the HTML content for the iframe
//         final htmlContent = '''
// <!DOCTYPE html>
// <html>
// <head>
// <meta charset="UTF-8" />
// <title>Stripe Payment</title>
// <script src="https://js.stripe.com/v3/"></script>
// <style>
//   body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
//   #payment-element { margin: 20px; }
//   #submit { margin: 20px; padding: 10px 20px; font-size: 16px; }
//   #error-message { color: red; margin-top: 10px; }
// </style>
// </head>
// <body>
// <h3 style="text-align:center;">Stripe Payment Form</h3>
// <form id="payment-form">
//   <div id="payment-element"></div>
//  <button
//   id="submit"
//   type="submit"
//   style="
//     display: block;
//     width: 90%;
//     background-color: #4CAF50; /* green */
//     color: white;
//     border: none;
//     padding: 10px;
//     font-size: 16px;
//     margin: 20px auto; /* centers horizontally */
//     cursor: pointer;
//     border-radius: 4px;
//   "
// >
//   Pay \$${(amount / 100).toStringAsFixed(2)} $currency
// </button>
//   <div id="error-message"></div>
// </form>
// <script>
//   let stripe, elements;
//
//   window.onload = function() {
//     startStripePayment();
//   };
//
//   async function startStripePayment() {
//     stripe = Stripe("$publishableKey");
//     // Initialize elements with clientSecret
//     elements = stripe.elements({ clientSecret: "$clientSecret" });
//     const appearance = { theme: 'stripe' };
//     const paymentElement = elements.create("payment", { appearance });
//     paymentElement.mount("#payment-element");
//
//     document.getElementById('payment-form').addEventListener('submit', async (event) => {
//       event.preventDefault();
//       const { error } = await stripe.confirmPayment({
//         elements,
//         confirmParams: {
//           return_url: "https://yourdomain.com/success.html"
//         },
//       });
//       if (error) {
//         document.getElementById("error-message").textContent = error.message;
//       }
//     });
//   }
// </script>
// </body>
// </html>
//         ''';
//
//         // Set the iframe content using srcdoc
//         iframe.srcdoc = htmlContent;
//
//         // Set sandbox attributes to allow scripts and same-origin
//         iframe.setAttribute('sandbox', 'allow-scripts allow-same-origin');
//
//         // Style the iframe
//         iframe.style.border = 'none';
//         iframe.style.width = '100%';
//         iframe.style.height = '100%';
//
//         return iframe;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Stripe Payment')),
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: HtmlElementView(viewType: 'iframeElement'),
//       ),
//     );
//   }
// }
//
// // // ignore: avoid_web_libraries_in_flutter
// // import 'dart:html' as html;
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:flutter/material.dart';
// // import 'dart:ui' as ui;
// //
// // class PaymentIntentWebViewPage extends StatelessWidget {
// //   final String clientSecret;
// //   final int amount;
// //   final String currency;
// //
// //   const PaymentIntentWebViewPage({
// //     super.key,
// //     required this.clientSecret,
// //     required this.amount,
// //     required this.currency,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final url = Uri.parse(
// //       'https://yourdomain.com/stripe_elements_form.html'
// //           '?clientSecret=$clientSecret'
// //           '&amount=$amount'
// //           '&currency=$currency',
// //     );
// //
// //     if (kIsWeb) {
// //       // ignore: undefined_prefixed_name
// //       ui.platformViewRegistry.registerViewFactory(
// //         'stripe-webview',
// //             (int viewId) => html.IFrameElement()
// //           ..src = url.toString()
// //           ..style.border = 'none'
// //           ..width = '100%'
// //           ..height = '100%'
// //           ..allow = 'payment',
// //       );
// //     }
// //
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Stripe Payment')),
// //       body: kIsWeb
// //           ? const HtmlElementView(viewType: 'stripe-webview')
// //           : const Center(child: Text("Web only")),
// //     );
// //   }
// // }
