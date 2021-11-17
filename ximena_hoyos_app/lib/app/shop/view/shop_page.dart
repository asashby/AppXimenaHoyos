
import 'package:data/models/checkout_item.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ximena_hoyos_app/app/shop/components/shop_body.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/shop_cart/view/shop_cart_page.dart';

class ShopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ShopBody(),
    );
  }

  AppBar buildAppBar(BuildContext context){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft,
            color: kTextColor,),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget> [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.search,
            color: kTextColor,), 
          onPressed: (){
          },
        ),
      IconButton(
        icon: FaIcon(FontAwesomeIcons.shoppingCart,
          color: kTextColor,),
        onPressed: () => Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => ShopCartPage()
          )
        ),
      ),
      SizedBox(width:kDefaultPadding / 2)
      ]
    );
  }
}