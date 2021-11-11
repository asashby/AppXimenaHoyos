import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ximena_hoyos_app/common/base_page.dart';
import 'package:ximena_hoyos_app/common/string_common.dart';

class ProductDetailPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ProductDetailPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Color(0xFF221b1c),
      onClosePressed: () {
        Navigator.of(context).pop();
      },
      slivers: [
        SliverToBoxAdapter(
          child: _ChallengeBody(),
        ),
      ],
      imageAsset: 'resources/app_background.jpg',
    );
  }
}

class _ChallengeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF221b1c),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            "Ipsum lorem",
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            "Ipsum lorem",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'S/ 239.654',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              MaterialButton(
                minWidth: 60,
                height: 60,
                color: Theme.of(context).buttonColor,
                onPressed: () {},
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              Expanded(
                  child: Text(
                '3',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.w400),
              )),
              MaterialButton(
                minWidth: 60,
                height: 60,
                color: Theme.of(context).buttonColor,
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _ProductAttributesView(),
          SizedBox(
            height: 20,
          ),
          Text(
            LOREM_IPSUM,
          ),
          SizedBox(
            height: 60,
          ),
          MaterialButton(
            minWidth: double.infinity,
            height: 60,
            color: Theme.of(context).buttonColor,
            onPressed: () {},
            child: Text(
              "Agregar al carrito",
              style: Theme.of(context).textTheme.button,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }
}

class _ProductAttributesView extends StatelessWidget {
  const _ProductAttributesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {},
          height: 60,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: [
                Expanded(child: Text(('Color'))),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        )
      ],
    );
  }
}
