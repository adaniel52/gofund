import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  PaymentService._();
  static final instance = PaymentService._();

  final _stripe = Stripe.instance;
  final _publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  final _secretKey = dotenv.env['STRIPE_SECRET_KEY']!;

  Future<void> init() async {
    Stripe.publishableKey = _publishableKey;
  }

  Future<Map<String, dynamic>> _createPaymentIntent(double amount) async {
    final url = 'https://api.stripe.com/v1/payment_intents';

    final body = {
      'amount': (amount * 100).toStringAsFixed(0),
      'currency': 'myr',
    };

    final headers = {
      'Authorization': 'Bearer $_secretKey',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return json.decode(response.body);
  }

  Future<PaymentIntent> makePayment(double amount) async {
    final paymentIntent = await _createPaymentIntent(amount);
    final clientSecret = paymentIntent['client_secret'];

    await _stripe.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'GoFund',
      ),
    );

    await _stripe.presentPaymentSheet();

    return await _stripe.retrievePaymentIntent(clientSecret);
  }
}
