import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final Product product;

  const Description({ 
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
      ),
      child: Text(
        product.description,
        style: TextStyle(
          height: 1,
          fontSize: 15
        )
      )
    );
  }
}