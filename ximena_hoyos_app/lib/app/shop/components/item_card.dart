

import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  
  final Product product;
  final void Function() press;

  const ItemCard({ 
    Key? key, 
    required this.product,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              height: 300,
              //width: 160,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              product.name!,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text(
            "S/" + product.price.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: applicationBlueColor)
          )
        ]
      ),
    );
  }
}