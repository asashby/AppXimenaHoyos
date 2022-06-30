import 'package:data/models/products_payload_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {
  final bool clean;

  ProductsLoadingState({this.clean = false});

  @override
  List<Object> get props => [clean];
}

class ProductsSucessState extends ProductsState {
  final List<Product> products;
  final List<Categories> categories;

  ProductsSucessState(this.products, this.categories);

  @override
  List<Object> get props => [products, categories];
}

class ProductsErrorState extends ProductsState {
  final Exception error;

  ProductsErrorState(this.error);
}
