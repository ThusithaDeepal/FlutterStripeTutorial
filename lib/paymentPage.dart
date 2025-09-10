import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment_tutorial/api_calls.dart';

class Paymentpage extends StatefulWidget {
  const Paymentpage({super.key});

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  initCustomerSheet() async {
    String paymentIntentClientSecret = await ApiCalls.getClientSecret(
      int.tryParse(_textEditingController.text.toString())!,
    );

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "thusitha",
        // paymentMethodOrder: ["Card"],
      ),
    );
    try {
      await Stripe.instance.presentPaymentSheet();

      // ✅ Payment succeeded
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment completed successfully!")),
      );
      debugPrint("Payment completed successfully!");
    } on StripeException catch (e) {
      // ⚠️ Payment failed or cancelled
      if (e.error.code == FailureCode.Canceled) {
        debugPrint("Payment was cancelled by user.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment was cancelled by user.")),
        );
      } else {
        debugPrint("Payment failed: ${e.error.localizedMessage}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Payment failed: ${e.error.localizedMessage}"),
          ),
        );
      }
    } catch (e) {
      // Any other unexpected error
      debugPrint("Unexpected error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: "Enter amount to pay",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    initCustomerSheet();
                  }
                },
                child: Text("Pay"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
