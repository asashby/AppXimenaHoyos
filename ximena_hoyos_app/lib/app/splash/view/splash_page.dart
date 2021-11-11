import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage('resources/ximena.webp'),
            fit: BoxFit.fitHeight,
            alignment: Alignment.topCenter,
          ),
        ),
      ]
    );
  }
}
