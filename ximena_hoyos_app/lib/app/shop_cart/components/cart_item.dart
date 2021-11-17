import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:data/models/checkout_item.dart';
import 'package:provider/provider.dart';
import 'package:ximena_hoyos_app/main.dart';

class CartItem extends StatelessWidget {
  final CheckoutItem item;

  const CartItem({ 
    Key? key,
    required this.item
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.product.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey
                    ),
                  ),
                  Text(
                    "Cantidad: ".toUpperCase() + item.quantity.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kTextColor
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(
                          text: "Total: ",
                        ),
                        TextSpan(
                          text: "S/" + item.total.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff92e600)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5
                    ),
                    child: ElevatedButton(
                      child: Text(
                        "Remover",
                        style: TextStyle(
                          fontSize: 14
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff20d0fc),
                      ),
                      onPressed: (){
                        checkoutItems.remove(item);
                      }
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  height: 75,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        item.product.image,
                      ),
                      fit: BoxFit.fitHeight
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            )
          ]
        ),
      ],
    );
  }
}