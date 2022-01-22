
import 'package:data/models/checkout_item.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ximena_hoyos_app/app/shop/components/shop_body.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ximena_hoyos_app/app/shop_cart/view/shop_cart_page.dart';
import 'package:ximena_hoyos_app/app/shop/bloc/products_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';

class ShopPage extends StatelessWidget {

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ShopPage()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ProductBloc(RepositoryProvider.of<ProductsRepository>(ctx)),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.initial:
              _fetchDetail(context);
              return SizedBox.shrink();
            case ProductStatus.error:
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
            case ProductStatus.loading:
              return SizedBox(
                height: 400,
                child: Center(child: Center(child: CircularProgressIndicator())),
              );
            case ProductStatus.success:
              return Scaffold(
                appBar: buildAppBar(context),
                body: ShopBody(productsData: state.products),
                backgroundColor: backgroundMainColor,
              );
          }
        }
      ),
    );
  }

  _fetchDetail(BuildContext context) {
    context.read<ProductBloc>().add(ProductFetchEvent());
  }

  AppBar buildAppBar(BuildContext context){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundMainColor,
      elevation: 0,
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft,
            color: Colors.white,),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget> [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.search,
            color: Colors.white,), 
          onPressed: (){
          },
        ),
      IconButton(
        icon: FaIcon(FontAwesomeIcons.shoppingCart,
          color: Colors.white,),
        onPressed: () => Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => ShopCartPage()
          )
        ),
      ),
      SizedBox(width:kDefaultPadding / 2)
      ]
    );
  }
}