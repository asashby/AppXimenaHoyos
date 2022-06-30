import 'package:data/models/products_payload_model.dart';
import 'package:data/repositories/products_repository.dart';
import 'package:data/utils/constants.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/shop/bloc/products_bloc.dart';
import 'package:ximena_hoyos_app/main.dart';

class CategoriesView extends StatefulWidget {

  final List<Categories>? categories;

  const CategoriesView({Key? key, required this.categories}) : super(key: key);
  @override 
  _CategoriesViewState createState() => _CategoriesViewState(categories);
}

final ProductsRepository repository = ProductsRepository(TokenStoreImp());
class _CategoriesViewState extends State<CategoriesView>{

  final List<Categories>? categories;
  int selectedIndex = 0;

  _CategoriesViewState(this.categories);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories?.length,
          itemBuilder: (context, index) =>  buildCategory(index),
        )
      ),
    );
  }

  Widget buildCategory(int index){
    return GestureDetector(
      onTap:(){
        setState(() {
          selectedIndex = index;
        });
        ProductsFilter filter = ProductsFilter.all;
        if(categories![index].name!.toLowerCase() != "todos"){
          filter = ProductsFilter.specificCategory;
        }
        BlocProvider.of<ProductBloc>(context)
              .add(ProductApplyFilterEvent(filter, categories![index].id!, index));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories![index].name!.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: selectedIndex == index ? applicationBlueColor : Colors.white,
              )
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index ? applicationBlueColor : Colors.transparent,
            )
          ],
        )
      ),
    );
  }
}
