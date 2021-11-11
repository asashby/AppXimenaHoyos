import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/rounded_image.dart';

class ItemView extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? urlImage;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const ItemView({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.urlImage,
    required this.onPressed,
    this.width = 200,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              child: RoundedImage(
                imageNetwork: urlImage,
                fit: BoxFit.fitHeight,
                radius: 12,
              ),
              height: double.infinity,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent])),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    subTitle,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 11, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            MaterialButton(
                height: double.infinity,
                minWidth: double.infinity,
                onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}
