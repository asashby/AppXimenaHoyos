import 'package:data/models/products_payload_model.dart';
import 'package:data/models/checkout_item.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/shop_details/components/cart_counter.dart';
import 'package:ximena_hoyos_app/main.dart';

class AddToCart extends StatelessWidget {
  final Product product;

  const AddToCart({ 
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding
      ),
      child: Row(
        children: <Widget>[
          CartCounter(),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xff92e600))
                ),
                onPressed: () {

                  addItemToCartList(
                    CheckoutItem(
                      product: product,
                      quantity: numOfCardItems,
                      total: (product.price! * numOfCardItems).toDouble()
                    )
                  );

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Artículo añadido al carrito"),
                  ));
                },
                child: Text(
                  "Añadir al carrito".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  void addItemToCartList(CheckoutItem checkoutItem){
    
    bool isNewitem = true;
    
    checkoutItems.forEach((element) {
      if(element.product.id == checkoutItem.product.id){
        element.quantity == element.quantity + checkoutItem.quantity;
        isNewitem = false;
      }
    });

    if(isNewitem == true){
      checkoutItems.add(checkoutItem);
    }
  }
}