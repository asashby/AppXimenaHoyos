import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/payment/components/payment_info_body.dart';
import 'package:data/models/payment_type.dart';

class PaymentInfoPage extends StatelessWidget {
  final PaymentType paymentType;
  const PaymentInfoPage({ 
    Key? key,
    required this.paymentType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentInfoBody(
        paymentType: this.paymentType,
      )
    );
  }
}