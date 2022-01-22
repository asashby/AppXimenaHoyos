import 'package:data/models/product_model.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/app/shop/components/categories.dart' as CategoriesView;
import 'package:ximena_hoyos_app/app/shop/components/item_card.dart';
import 'package:ximena_hoyos_app/app/shop_details/view/shop_details_page.dart';

class ShopBody extends StatelessWidget {

  final List<Product>? productsData;

  const ShopBody({ 
    Key? key, 
    required this.productsData
  }) : super(key: key);

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
                color: Colors.white
            )
          )
        ),
        CategoriesView.Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GridView.builder(
              itemCount: productsData!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: kDefaultPadding,
                crossAxisSpacing: kDefaultPadding,
                childAspectRatio: 1
              ),
              itemBuilder: (context, index) => 
                ItemCard(
                  product: productsData![index], 
                  press: () => Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => ShopDetailsPage(
                        product: productsData![index],
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