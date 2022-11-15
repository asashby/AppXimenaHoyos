import 'package:data/models/products_payload_model.dart';
import 'package:data/models/slider_item_model.dart' as SliderModel;
import 'package:data/repositories/slider_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:ximena_hoyos_app/app/home/bloc/bloc.dart';
import 'package:ximena_hoyos_app/app/home/bloc/slider_bloc.dart';
import 'package:ximena_hoyos_app/app/shop/view/shop_page.dart';
import 'package:ximena_hoyos_app/app/shop_details/view/shop_details_page.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/main.dart';

class ShopSlider extends StatelessWidget {
  const ShopSlider({ 
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SliderBloc(RepositoryProvider.of<SliderRepository>(ctx)),
      child: BlocBuilder<SliderBloc, SliderState>(
        builder: (context, state) {
          switch (state.status) {
            case SliderStatus.initial:
              _fetchDetail(context);
              return SizedBox.shrink();
            case SliderStatus.error:
              print(state.error!);
              return Scaffold(
                backgroundColor: Colors.black,
                body: AppErrorView(
                  onPressed: () {
                    _fetchDetail(context);
                  },
                  onClose: () {
                    Navigator.of(context).pop();
                  },
                ),
              );
            case SliderStatus.loading:
              return SizedBox(
                height: 400,
                child: Center(child: Center(child: CircularProgressIndicator())),
              );
            case SliderStatus.success:
              return Stack(
                children: <Widget>[
                  ImageSlideshow(
                    width: MediaQuery.of(context).size.width * 0.9,
                    initialPage: 0,
                    indicatorColor: Colors.blue,
                    indicatorBackgroundColor: Colors.grey,
                    children: createSliderChildren(context, state.sliderItems),
                    autoPlayInterval: 3000,
                    isLoop: true,
                  ),
                ],
              );
          }
        }
      ),
    );
  }

  _fetchDetail(BuildContext context) {
    context.read<SliderBloc>().add(SliderFetchEvent());
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

  List<Widget> createSliderChildren(BuildContext context, List<SliderModel.SliderItem>? sliderItems){
    List<Widget> children = [];

    sliderItems!.forEach((element) {
      Widget widget = InkWell(
        onTap: () async{
          Product product = Product(
            id: element.product?.id,
            name: element.product?.name,
            price: element.product?.price!.toDouble(),
            description:  element.product?.description,
            urlImage: element.product?.urlImage,
            sku: element.product?.sku,
            categories: <Categories>[
              Categories(name: 'PROMOCIONES')
            ],
            hasChallengePromo: 1
          );
          orderHasPromo = true;
          await openShop(context, product);
        },
        child: Image.network(
          element.urlImage!,
          fit: BoxFit.fitWidth
        ),
      );

      children.add(widget);
    });

    return children;
  }

  Widget returnSliderChildren(BuildContext context, SliderModel.SliderItem sliderItem){
    Widget widget = InkWell(
      onTap: () async{
        Product product = Product(
          id: sliderItem.product?.id,
          name: sliderItem.product?.name,
          price: sliderItem.product?.price!.toDouble(),
          description:  sliderItem.product?.description,
          urlImage: sliderItem.product?.urlImage,
          sku: sliderItem.product?.sku,
          categories: <Categories>[
            Categories(name: 'PROMOCIONES')
          ],
          hasChallengePromo: 1
        );
        orderHasPromo = true;
        await openShop(context, product);
      },
      child: Image.network(
        sliderItem.urlImage!,
        fit: BoxFit.fitWidth
      ),
    );

    return widget;
  }
}