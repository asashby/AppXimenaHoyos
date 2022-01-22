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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 90
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding
                  ),
                  child: Column(
                    children: [
                      ProductTitleWithImage(product: product),
                      SizedBox(height: kDefaultPadding,),
                      Description(product: product),
                      Divider(
                        height: 2,
                        color: Colors.white,
                      ),
                      SizedBox(height: kDefaultPadding,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: "SKU: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              )
                            ),
                            TextSpan(
                              text: product.sku,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: "Categoría: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              )
                            ),
                            TextSpan(
                              text: product.categories![0].name!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AddToCart(
            product: product
          ),
        )
      ],
    );
  }
}