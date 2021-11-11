import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/shop/components/categories.dart';
import 'package:ximena_hoyos_app/app/shop/components/item_card.dart';
import 'package:ximena_hoyos_app/app/shop_details/view/shop_details_page.dart';

class ShopBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            "PRODUCTOS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kTextColor
            )
          )
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: kDefaultPadding,
                crossAxisSpacing: kDefaultPadding,
                childAspectRatio: 1
              ),
              itemBuilder: (context, index) => 
                ItemCard(
                  product: products[index], 
                  press: () => Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => ShopDetailsPage(
                        product: products[index],
                      )
                    )
                  )
                ),
            ),
          )
        )
      ],
    );
  }
}