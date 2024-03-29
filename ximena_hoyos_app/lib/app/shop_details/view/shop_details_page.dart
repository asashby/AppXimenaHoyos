import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/shop_cart/view/shop_cart_page.dart';
import 'package:ximena_hoyos_app/app/shop_details/components/details_body.dart';

class ShopDetailsPage extends StatelessWidget {

  final Product product;

  const ShopDetailsPage({ 
    Key? key, 
    required this.product 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundMainColor,
      appBar: buildAppBar(context),
      body: DetailsBody(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context){
    return AppBar(
      backgroundColor: backgroundMainColor,
      elevation: 0,
      leading: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.search,
            color: Colors.white
          ),
          onPressed: (){

          }
        ), 
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.shoppingCart,
            color: Colors.white
          ),
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => ShopCartPage(),
            )
          ),
        ),
        SizedBox(
          width: kDefaultPadding / 2
        )
      ],
    );
  }
}
