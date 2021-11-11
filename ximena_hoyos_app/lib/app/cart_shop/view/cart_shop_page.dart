import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/common/rounded_image.dart';

class CartShopPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => CartShopPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: Column(
      children: [
        Expanded(
          child: BaseView(
              withTopMargin: false,
              title: 'Carrito',
              showBackButton: true,
              sliver: SliverToBoxAdapter(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30),
                        topRight: const Radius.circular(30))),
                padding: const EdgeInsets.only(top: 50),
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 100),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _ProductCartItemView(),
                    );
                  },
                ),
              ))),
        ),
        _CartShopFooterView()
      ],
    ));
  }
}

class _CartShopFooterView extends StatelessWidget {
  const _CartShopFooterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total'),
                  Text(
                    'S/ 1000.00',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {},
              child: Text(
                'Siguiente',
                style: Theme.of(context).textTheme.button,
              ),
              height: 50,
              color: Theme.of(context).buttonColor,
              padding: const EdgeInsets.only(right: 50, left: 50),
            )
          ],
        ),
      ),
    );
  }
}

class _ProductCartItemView extends StatelessWidget {
  const _ProductCartItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16),
      width: double.infinity,
      height: 130,
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: RoundedImage(
              imageAsset: 'resources/sample_1.jpg',
            ),
          ),
          SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Product X',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'S/ 13.66',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).buttonColor),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5)),
                      onPressed: () {},
                      fillColor: Colors.white,
                      elevation: 2,
                      child: Icon(
                        Icons.remove,
                        size: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Text('1'),
                  ),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5)),
                      onPressed: () {},
                      fillColor: Colors.white,
                      elevation: 2,
                      child: Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
