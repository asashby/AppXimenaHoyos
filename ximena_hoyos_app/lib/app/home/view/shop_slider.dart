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
            Image.asset(
              'resources/promo.jpg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'resources/promo2.jpg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'resources/promo3.jpg',
              fit: BoxFit.cover,
            ),
          ],
          autoPlayInterval: 3000,
          isLoop: true,
        ),
      ],
    );
  }
}