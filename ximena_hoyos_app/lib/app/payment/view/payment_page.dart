import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/payment/components/payment_body.dart';

class PaymentPage extends StatelessWidget {
  final double paymentTotal;
  const PaymentPage({ 
    Key? key, 
    required this.paymentTotal 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentBody(paymentTotal: this.paymentTotal,),
    );
  }
}