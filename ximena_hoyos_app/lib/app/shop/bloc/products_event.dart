import 'package:data/repositories/products_repository.dart';

abstract class ProductsEvent {}

class ProductsFetchEvent extends ProductsEvent {}

class ProductsRefreshEvent extends ProductsEvent {}

class ProductsApplyFilterEvent extends ProductsEvent {
  final ProductsFilter filter;
  final int categoryId;

  ProductsApplyFilterEvent(this.filter, this.categoryId);
}
