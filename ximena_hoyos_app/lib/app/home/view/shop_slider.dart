import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:ximena_hoyos_app/app/shop/view/shop_page.dart';

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
                await openShop(context);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/1.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                await openShop(context);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/6.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                await openShop(context);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/2.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                await openShop(context);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/5.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                await openShop(context);
              },
              child: Image.network(
                'https://xoh-media-bucket.s3.amazonaws.com/tienda/3.png',
                fit: BoxFit.fitWidth
              ),
            ),
            InkWell(
              onTap: () async{
                await openShop(context);
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

  Future openShop(BuildContext context) async{
    await Navigator.of(context)
        .push(ShopPage.route());
  }
}