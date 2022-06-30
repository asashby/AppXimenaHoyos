
import 'package:data/models/products_payload_model.dart';
import 'package:flutter/material.dart';

class CheckoutItem extends ChangeNotifier{

  final Product product;
  final int quantity;
  final double total;

  CheckoutItem({
    required this.product,
    required this.quantity,
    required this.total
  });
}
