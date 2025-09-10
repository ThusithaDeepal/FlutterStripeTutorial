
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiCalls {
  static Future<String> getClientSecret(int amount) async {
    try {
      Response response = await Dio().post(
        // "http://localhost:3000/paymentIntent",
        "http://10.0.2.2:3000/paymentIntent",
        data: {"amount": amount},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      final clientSecret = response.data["clientSecret"];
      return clientSecret;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }
}
