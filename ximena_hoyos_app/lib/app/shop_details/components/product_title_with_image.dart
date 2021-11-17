
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.title,
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: kTextColor,
            ),
          ),
          SizedBox(
            height: kDefaultPadding
          ),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Precio: ",
                      style: TextStyle(
                        color: kTextColor
                      )),
                    TextSpan(
                      text: "S/" + product.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blueGrey,
                      ),
                    )
                  ]
                )
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Hero(
                  tag: product.id,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.fill
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}