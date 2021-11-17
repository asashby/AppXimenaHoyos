import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/shop/components/product_description.dart';
import 'package:ximena_hoyos_app/app/shop_details/components/add_to_cart.dart';
import 'package:ximena_hoyos_app/app/shop_details/components/cart_counter.dart';
import 'package:ximena_hoyos_app/app/shop_details/components/product_title_with_image.dart';

class DetailsBody extends StatelessWidget {

  final Product product;

  const DetailsBody({ 
    Key? key, 
    required this.product 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.3
                  ),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  //height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: kDefaultPadding,),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: kTextColor),
                          children: [
                            TextSpan(
                              text: "SKU: ",
                            ),
                            TextSpan(
                              text: product.sku,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: kTextColor
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: kDefaultPadding,),
                      Description(product: product),
                      SizedBox(height: kDefaultPadding / 2,),
                      CartCounter(),
                      SizedBox(height: 2,),
                      AddToCart(product: product),
                    ],
                  )
                ),
                ProductTitleWithImage(product: product),
              ]
            ),
          )
        ],
      )
    );
  }
}