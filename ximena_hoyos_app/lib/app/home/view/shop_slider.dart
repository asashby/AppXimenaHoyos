import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ShopSlider extends StatelessWidget {
  const ShopSlider({ 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          children: [
            Image.network(
              'https://xoh-media-bucket.s3.amazonaws.com/tienda/1.png',
              fit: BoxFit.cover
            ),
            Image.network(
              'https://xoh-media-bucket.s3.amazonaws.com/tienda/6.png',
              fit: BoxFit.cover
            ),
            Image.network(
              'https://xoh-media-bucket.s3.amazonaws.com/tienda/2.png',
              fit: BoxFit.cover
            ),
            Image.network(
              'https://xoh-media-bucket.s3.amazonaws.com/tienda/5.png',
              fit: BoxFit.cover
            ),
            Image.network(
              'https://xoh-media-bucket.s3.amazonaws.com/tienda/3.png',
              fit: BoxFit.cover
            ),
            Image.network(
              'https://xoh-media-bucket.s3.amazonaws.com/tienda/4.png',
              fit: BoxFit.cover
            )
          ],
          autoPlayInterval: 3000,
          isLoop: true,
        ),
      ],
    );
  }
}