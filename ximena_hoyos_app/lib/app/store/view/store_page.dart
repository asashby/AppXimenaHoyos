import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ximena_hoyos_app/app/cart_shop/cart_shop.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/app/product_detail/product_detail.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BaseView(
        title: 'Tienda',
        caption: 'ipsum lorem et agui',
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _StoreSearchView(),
                _StoreCategories(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 30),
                  itemCount: 5,
                  itemBuilder: (context, index) => _ProductSecction(
                    title: 'Las proteinicas',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 60, left: 28, right: 28, top: 60),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    color: Theme.of(context).buttonColor,
                    onPressed: () {
                      Navigator.of(context).push(CartShopPage.route());
                    },
                    child: Text(
                      "Ver carrito",
                      style: Theme.of(context).textTheme.button,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

class _StoreCategories extends StatelessWidget {
  const _StoreCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.only(left: 28, right: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _CategoryItem(
          title: 'Ropa',
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: RawMaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.white,
        child: Container(
            child: Text(
          this.title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.grey),
        )),
      ),
    );
  }
}

class _StoreSearchView extends StatelessWidget {
  const _StoreSearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 28, left: 28, bottom: 10, top: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Buscar',
              icon: Icon(Icons.search_rounded)),
        ),
      ),
    );
  }
}

class _ProductSecction extends StatelessWidget {
  final String title;

  const _ProductSecction({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              this.title,
              style: Theme.of(context).textTheme.headline2,
            ),
            margin: const EdgeInsets.only(left: 28),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 250,
            child: ListView.builder(
              itemCount: 4,
              padding: const EdgeInsets.only(left: 28, right: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: _ProductItem(
                    title: "Ipsum loren",
                    caption: "Ipsum Lorem",
                    imageResource: 'resources/app_background.jpg',
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({
    Key? key,
    this.imageResource,
    this.title,
    this.caption,
    this.width = 200.0,
    this.height = 200.0,
  }) : super(key: key);

  final String? imageResource;
  final String? title;
  final String? caption;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: this.width,
          height: this.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    imageResource!,
                    fit: BoxFit.cover,
                  ),
                ),
                MaterialButton(
                  height: double.infinity,
                  minWidth: double.infinity,
                  onPressed: () {
                    Navigator.of(context).push(ProductDetailPage.route());
                  },
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Ipsum lorem',
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(
          height: 1,
        ),
        Text(
          'S/ 264.64',
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
