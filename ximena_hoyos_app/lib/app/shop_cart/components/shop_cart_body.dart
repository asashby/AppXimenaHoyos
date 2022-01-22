import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/checkout_form/view/checkout_form_page.dart';
import 'package:ximena_hoyos_app/app/shop_cart/components/cart_item.dart';
import 'package:ximena_hoyos_app/main.dart';

class ShopCartBody extends StatelessWidget {
  final double totalCheckout;

  const ShopCartBody({ 
    Key? key,
    required this.totalCheckout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 90
                ),
                child: GridView.builder(
                  itemCount: checkoutItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: kDefaultPadding,
                    crossAxisSpacing: kDefaultPadding,
                    childAspectRatio: 3
                  ),
                  itemBuilder: (context, index) => 
                    CartItem(
                      item: checkoutItems[index]
                    ),
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: kDefaultPadding
            ),
            child: SizedBox(
              height: 50,
              width: 250,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
                ),
                color: kButtonGreenColor,
                onPressed: () => Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => CheckoutFormPage()
                  )
                ),
                child: Text(
                  "checkout ".toUpperCase() + "(" + totalCheckout.toString() + ")",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
              )
            )
          )
        )
      ],
    );
  }
}