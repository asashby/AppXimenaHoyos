import 'package:data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:ximena_hoyos_app/app/shop/view/shop_page.dart';
import 'package:ximena_hoyos_app/app/shop_details/view/shop_details_page.dart';
import 'package:ximena_hoyos_app/main.dart';

class ShopSlider extends StatelessWidget {
  const ShopSlider({ 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageSlideshow(
          width: MediaQuery.of(context).size.width * 0.9,
          initialPage: 0,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          children: [
            InkWell(
              onTap: () async{
                Product product = Product(
                  id: 185,
                  name: 'PACK ISOXIPRO Whey protein 500g + Entrenamiento básico (1 mes)',
                  price: '199.00',
                  shortDescription:  'Oferta proteína 500 gramos más entrenamiento básico por un mes',
                  images: <Images>[
                    Images(
                      src: 'https://firebasestorage.googleapis.com/v0/b/ximenahoyosapp.appspot.com/o/isoxipro-500g.jpg?alt=media&token=78b601fa-71bf-4e91-9ed4-073fc17382f2'
                    )
                  ],
                  sku: 'PIPT-1-1',
                  categories: <Categories>[
                    Categories(name: 'PROMOCIONES'),
                    Categories(name: 'PROTEINA')
                  ],
                  hasChallengePromo: 1,
                  challengeId: 17
                );
                orderHasPromo = true;
                await openShop(context, product);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/1.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                Product product = Product(
                  id: 175,
                  name: 'PACK ISOXIPRO Whey protein isolate + Entrenamiento básico (1 mes)',
                  price: '238.00',
                  shortDescription:  'Oferta proteína 1 kilogramo más entrenamiento básico por un mes',
                  images: <Images>[
                    Images(
                      src: 'https://firebasestorage.googleapis.com/v0/b/ximenahoyosapp.appspot.com/o/isoxipro-chocolate.jpg?alt=media&token=c866be97-1b48-4232-8849-6a44a5dd0a74'
                    )
                  ],
                  sku: 'PIPT-1-1',
                  categories: <Categories>[
                    Categories(name: 'PROMOCIONES'),
                    Categories(name: 'PROTEINA')
                  ],
                  hasChallengePromo: 1,
                  challengeId: 17
                );
                orderHasPromo = true;
                await openShop(context, product);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/6.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                Product product = Product(
                  id: 186,
                  name: 'PACK ISOXIPRO Whey protein 500g + Entrenamiento intermedio (1 mes)',
                  price: '199.00',
                  shortDescription:  'Oferta proteína 500 gramos más entrenamiento intermedio por un mes',
                  images: <Images>[
                    Images(
                      src: 'https://firebasestorage.googleapis.com/v0/b/ximenahoyosapp.appspot.com/o/isoxipro-500g.jpg?alt=media&token=78b601fa-71bf-4e91-9ed4-073fc17382f2'
                    )
                  ],
                  sku: 'PIPT-1-1',
                  categories: <Categories>[
                    Categories(name: 'PROMOCIONES'),
                    Categories(name: 'PROTEINA')
                  ],
                  hasChallengePromo: 1,
                  challengeId: 18
                );
                orderHasPromo = true;
                await openShop(context, product);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/2.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                Product product = Product(
                  id: 178,
                  name: 'PACK ISOXIPRO Whey protein isolate + Entrenamiento intermedio (1 mes)',
                  price: '238.00',
                  shortDescription:  'Oferta proteína 1 kilogramo más entrenamiento intermedio por un mes',
                  images: <Images>[
                    Images(
                      src: 'https://firebasestorage.googleapis.com/v0/b/ximenahoyosapp.appspot.com/o/isoxipro-chocolate.jpg?alt=media&token=c866be97-1b48-4232-8849-6a44a5dd0a74'
                    )
                  ],
                  sku: 'PIPT-1-1',
                  categories: <Categories>[
                    Categories(name: 'PROMOCIONES'),
                    Categories(name: 'PROTEINA')
                  ],
                  hasChallengePromo: 1,
                  challengeId: 18
                );
                orderHasPromo = true;
                await openShop(context, product);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/5.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                Product product = Product(
                  id: 187,
                  name: 'PACK ISOXIPRO Whey protein 500g + Entrenamiento avanzado (1 mes)',
                  price: '199.00',
                  shortDescription:  'Oferta proteína 500 gramos más entrenamiento avanzado por un mes',
                  images: <Images>[
                    Images(
                      src: 'https://firebasestorage.googleapis.com/v0/b/ximenahoyosapp.appspot.com/o/isoxipro-500g.jpg?alt=media&token=78b601fa-71bf-4e91-9ed4-073fc17382f2'
                    )
                  ],
                  sku: 'PIPT-1-1',
                  categories: <Categories>[
                    Categories(name: 'PROMOCIONES'),
                    Categories(name: 'PROTEINA')
                  ],
                  hasChallengePromo: 1,
                  challengeId: 19
                );
                orderHasPromo = true;
                await openShop(context, product);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/3.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                Product product = Product(
                  id: 180,
                  name: 'PACK ISOXIPRO Whey protein isolate + Entrenamiento avanzado (1 mes)',
                  price: '238.00',
                  shortDescription:  'Oferta proteína 1 kilogramo más entrenamiento avanzado por un mes',
                  images: <Images>[
                    Images(
                      src: 'https://firebasestorage.googleapis.com/v0/b/ximenahoyosapp.appspot.com/o/isoxipro-chocolate.jpg?alt=media&token=c866be97-1b48-4232-8849-6a44a5dd0a74'
                    )
                  ],
                  sku: 'PIPT-1-1',
                  categories: <Categories>[
                    Categories(name: 'PROMOCIONES'),
                    Categories(name: 'PROTEINA')
                  ],
                  hasChallengePromo: 1,
                  challengeId: 19
                );
                orderHasPromo = true;
                await openShop(context, product);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/4.png',
                fit: BoxFit.fitWidth
              )
            ),
          ],
          autoPlayInterval: 3000,
          isLoop: true,
        ),
      ],
    );
  }

  Future openShop(BuildContext context, Product promoInfo) async{
    await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => ShopDetailsPage(
          product: promoInfo
        )
      )
    );
  }
}