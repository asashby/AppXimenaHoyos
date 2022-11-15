import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/payment/components/payment_body.dart';

enum PaymentOrigin { challenges, shop, consultation }
class PaymentPage extends StatelessWidget {
  final double paymentTotal;
  final PaymentOrigin paymentOrigin;

  const PaymentPage({ 
    Key? key, 
    required this.paymentTotal ,
    required this.paymentOrigin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentBody(
        paymentTotal: this.paymentTotal,
        paymentOrigin: this.paymentOrigin,
        ),
    );
  }
}