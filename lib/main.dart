import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment_tutorial/paymentPage.dart';
import 'package:stripe_payment_tutorial/webview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51RyrKjQ9jf01yJkVx33FLn5LI1K4Xlva7IDlE0k4tAaiv2n6G8PUmJ0OXSdFr1E91KuA3MBvlmIwWaxt51UZdvPc00ywDlde04";
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: WebViewPage(),
      home: Paymentpage(),
    );
  }
}
