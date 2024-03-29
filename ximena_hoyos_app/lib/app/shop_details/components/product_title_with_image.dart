
import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductTitleWithImage extends StatelessWidget {
  final Product product;

  const ProductTitleWithImage({ 
    Key? key, 
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.name!,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
          ),
        ),
        Text(
          "S/" + product.price!,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: applicationBlueColor,
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            height: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  product.images![0].src!,
                ),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}