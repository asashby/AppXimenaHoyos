import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/shop_cart/components/shop_cart_body.dart';
import 'package:ximena_hoyos_app/main.dart';

class ShopCartPage extends StatelessWidget {
  ShopCartPage
  ({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ShopCartBody(
        totalCheckout: calculateTotalCheckout(),
      ),
      backgroundColor: backgroundMainColor,
    );
  }

  AppBar buildAppBar(BuildContext context){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundMainColor,
      elevation: 0,
      leading: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Tu carrito".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  double calculateTotalCheckout(){

    double totalCheckout = 0;

    checkoutItems.forEach((element) { 
      totalCheckout = totalCheckout + element.total;
    });

    totalPrice = totalCheckout;

    return totalCheckout;
  }
}

