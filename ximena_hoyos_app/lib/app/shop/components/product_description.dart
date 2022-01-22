import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
      child: Html(
        data: product.shortDescription!,
        style: {
          "p": Style(
            color: Colors.white
          )
        }
      )
    );
  }
}